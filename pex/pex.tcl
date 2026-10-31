#!/usr/bin/env tclsh
# =============================================================================
# pex/pex.tcl — LVS + parasitic extraction + PEX sanity check
# Project : B12 Electron Ensemble — analog perceptron (SSCS OSE Chipathon 2026)
# PDK     : gf180mcuD (open_pdks)   Tools: magic 8.3.636, netgen 1.5.318, ngspice
#
# Usage   : tclsh pex/pex.tcl ?all|lvs|pex|check|tb|sim|plot|clean?   (default: all = lvs..sim)
#           plot is separate: runs plots/*.py on pex/out/sim/* + overlays
#           Needs $PDK_ROOT and $PDK (set in the IIC-OSIC-TOOLS image).
#           Run from anywhere; paths are resolved relative to this file.
#
# Outputs : pex/out/      committed (reports, netlists, summary)
#           pex/build/    scratch (.ext etc.), gitignored, safe to delete
#
# Flow
#   lvs   : magic hierarchical extraction -> netgen LVS vs lvs/spice/<cell>.spice
#           (the layout-aware schematics with dummies)
#   pex   : magic flat extraction, 2 modes per cell
#             c  = device + coupling/substrate C, no R
#             rc = full RC: extresist R networks on every net + distributed C
#           subckt renamed <cell>_pex_c / <cell>_pex_rc, port order = schematic
#           order, so it drops into any testbench in place of <cell>.
#   check : ngspice op + DC sweep + AC on schematic vs pex_c vs pex_rc,
#           rail IR drop from the RC netlist, results into summary.md
#
# Layout quirk handled here (GDS is NOT modified):
#   top cell 'perceptron' carries every signal label twice: at the die edge
#   (ASIG5V side) and at the perceptron_core boundary (to_gate side, behind the
#   secondary-ESD resistor). Magic merges same-name labels into one net, which
#   would short the ESD resistor. In-session, the core-side copies inside the
#   perceptron_core instance bbox are renamed <pin>_core and de-ported;
#   core-side VDD/VSS copies are only de-ported (same net anyway).
# =============================================================================

package require Tcl 8.6

# ------------------------------------------------------------------ config ---
set HERE [file dirname [file normalize [info script]]]
set ROOT [file dirname $HERE]
set OUT  [file join $HERE out]
set BLD  [file join $HERE build]

# LVS targets: {cell  gds  schematic-netlist}   (paths relative to repo root)
set LVS_TARGETS {
    {perceptron                 gds/perceptron.gds                                          lvs/spice/perceptron.spice}
    {perceptron_core            layout/perceptron/perceptron_core.gds                       lvs/spice/perceptron_core.spice}
    {cg_amp_tia                 layout/cg_amp_tia/cg_amp_tia.gds                            lvs/spice/cg_amp_tia.spice}
    {gilbert_multiplier_current layout/gilbert_multiplier_current/gilbert_multiplier_current.gds lvs/spice/gilbert_multiplier_current.spice}
    {tanh_ota                   layout/tanh_ota/tanh_ota.gds                                lvs/spice/tanh_ota.spice}
    {voltage_reference          layout/voltage_reference/voltage_reference.gds              lvs/spice/voltage_reference.spice}
}
# PEX targets (must also be LVS targets)
set PEX_TARGETS {perceptron perceptron_core}
set PEX_MODES   {c rc}

# KLayout PCell sub-cells flattened on GDS read; only design blocks stay hierarchical
set FLATGLOB {nfet* pfet* ppolyf_u* via_dev* diode_* TEXT* design}
# Cell whose instance bbox marks the "core side" for the duplicate-label fix
set CORE_CELL   perceptron_core
set SUPPLY_PINS {VDD VSS}
# extresist: higher tolerance -> more resistors kept in the network
set RC_TOLERANCE 10

# Check-stage operating point (from tb_realistic_perceptron_core)
set STIM {
    VDD     {v 3.3}
    VSS     {v 0}
    V_shift {v 3.3}
    V_w1    {v 1.85}
    V_w2    {v 1.65}
    V_b     {v 1.65}
    I_x1    {i 25u}
    I_x2    {i 25u}
}
set OUT_PIN    V_out_perceptron
set DC_SWEEP   {V_w1 1.45 1.85 0.01}
set AC_SRC     I_x1
set CORNER     typical
set RES_CORNER res_typical
set DIODE_CORNER diode_typical


# Testbench re-simulation (stages tb + sim): {testbench  dut-cell  plot-script}
# "tb_realistic_perceptron .sch" (7x extracted io_asig_5p0 pads) is left out on
# purpose: it ran out of memory at ~20 GB even without parasitics.
set TB_LIST {
    {tb_perceptron_core           perceptron_core plot_results.py}
    {tb_demo_perceptron_core      perceptron_core {}}
    {tb_realistic_perceptron_core perceptron_core plot_real_results.py}
    {tb_perceptron                perceptron      plot_results.py}
    {tb_demo_perceptron           perceptron      {}}
}
# sch = lvs/schematics (layout-aware, with dummies) as the baseline
set SIM_VIEWS {sch c rc}

# ----------------------------------------------------------------- helpers ---
proc die {msg} { puts stderr "FATAL: $msg"; exit 2 }
proc say {msg} { puts "\[pex\] $msg"; flush stdout }
proc mkdirs {args} { foreach d $args { file mkdir $d } }
proc slurp {f} { set h [open $f r]; set d [read $h]; close $h; return $d }
proc spit {f data} { set h [open $f w]; puts -nonewline $h $data; close $h }
proc rel {p} { global ROOT; string map [list "$ROOT/" ""] $p }

proc need_tool {t} { if {[auto_execok $t] eq ""} { die "'$t' not found in PATH" } }

# run a command, cwd = dir, stdout+stderr -> log; returns exit code
proc run {dir log args} {
    set old [pwd]; cd $dir
    set rc [catch {exec {*}$args >& $log} err opts]
    cd $old
    if {$rc} {
        set ec [lindex [dict get $opts -errorcode] end]
        if {![string is integer -strict $ec]} { set ec 1 }
        return $ec
    }
    return 0
}

# join SPICE '+' continuation lines
proc spice_lines {text} {
    set out {}
    foreach l [split $text \n] {
        if {[string match "+*" $l] && [llength $out]} {
            lset out end "[lindex $out end] [string range $l 1 end]"
        } else { lappend out $l }
    }
    return $out
}

# port list of '.subckt cell ...' in a netlist file
proc subckt_pins {file cell} {
    foreach l [spice_lines [slurp $file]] {
        set w [regexp -all -inline {\S+} $l]
        if {[string tolower [lindex $w 0]] eq ".subckt" && [lindex $w 1] eq $cell} {
            set pins {}
            foreach t [lrange $w 2 end] { if {[string first = $t] < 0} { lappend pins $t } }
            return $pins
        }
    }
    die "no .subckt $cell in [rel $file]"
}

# SPICE number -> double
proc sval {s} {
    if {![regexp -nocase {^([-+0-9.eE]+)([a-z]*)} $s -> n u]} { return 0.0 }
    set u [string tolower $u]
    foreach {k m} {meg 1e6 f 1e-15 p 1e-12 n 1e-9 u 1e-6 m 1e-3 k 1e3 g 1e9 t 1e12} {
        if {[string match "$k*" $u]} { return [expr {$n*$m}] }
    }
    return [expr {double($n)}]
}

proc pin_of {cell} {
    global LVS_TARGETS
    foreach t $LVS_TARGETS { if {[lindex $t 0] eq $cell} { return $t } }
    die "unknown cell $cell"
}

# ------------------------------------------------- magic helper library -----
# Written to build/ and sourced by every generated magic script.
set MAGIC_LIB {
namespace eval pex {}
proc pex::read {gds cell globs} {
    foreach g $globs { gds flatglob $g }
    gds read $gds
    load $cell
    select top cell
    select clear
}
proc pex::um {b} {
    set s [cif scale out]
    return [format "(%.3f, %.3f) um" [expr {[lindex $b 0]*$s}] [expr {[lindex $b 1]*$s}]]
}
# boxes (internal units) of every top-level label named $name
proc pex::label_boxes {name} {
    set out {}
    box values -9 -9 -9 -9
    set sentinel [box values]
    for {set k 0} {$k < 64} {incr k} {
        box values -9 -9 -9 -9
        findlabel $name $k
        set b [box values]
        if {$b eq $sentinel} break
        if {[lsearch -exact $out $b] < 0} { lappend out $b }
    }
    return $out
}
proc pex::sel_label {b} {
    select clear
    lassign $b x1 y1 x2 y2
    box values ${x1}i ${y1}i ${x2}i ${y2}i
    select area labels
}
proc pex::is_port {} { expr {[string is integer -strict [port index]]} }
proc pex::inside {b r} {
    lassign $b x1 y1 x2 y2; lassign $r a1 b1 a2 b2
    expr {$x1 >= $a1 && $x2 <= $a2 && $y1 >= $b1 && $y2 <= $b2}
}
# duplicate-label fix (see header of pex.tcl)
proc pex::fix_labels {top pins core supplies} {
    set log {}
    set bbs {}
    foreach inst [cellname list childinst $top] {
        if {[regexp "^${core}_\[0-9\]+\$" $inst]} {
            select clear; select cell $inst; lappend bbs [select bbox]
        }
    }
    select clear
    foreach p $pins {
        set keep 0
        foreach b [pex::label_boxes $p] {
            set incore 0
            foreach r $bbs { if {[pex::inside $b $r]} { set incore 1 } }
            pex::sel_label $b
            if {$incore && [lsearch -exact $supplies $p] < 0} {
                setlabel text ${p}_core
                port remove
                lappend log "renamed  $p [pex::um $b] -> ${p}_core (non-port)"
            } elseif {$incore} {
                port remove
                lappend log "deported $p [pex::um $b] (core-side supply copy)"
            } else { incr keep }
            select clear
        }
        if {$keep == 0} { lappend log "WARNING no top-level label for pin $p" }
    }
    return $log
}
# force port order = schematic order (two passes to avoid index collisions,
# equal indices would make ports equivalent); ports not in $pins are removed
proc pex::order_ports {top pins} {
    box values -1000000 -1000000 1000000 1000000
    select area labels
    set names {}
    foreach l [lindex [what -list] 1] { lappend names [lindex $l 0] }
    select clear
    foreach n [lsort -unique $names] {
        if {[lsearch -exact $pins $n] >= 0} continue
        foreach b [pex::label_boxes $n] { pex::sel_label $b; if {[pex::is_port]} { port remove } }
    }
    foreach off {1000 0} {
        set i 1
        foreach p $pins {
            set bs [pex::label_boxes $p]
            if {![llength $bs]} { puts "PEXERR missing label $p"; incr i; continue }
            set done 0
            foreach b $bs {
                pex::sel_label $b
                if {[pex::is_port]} { port index [expr {$off+$i}]; set done 1 }
            }
            if {!$done} { pex::sel_label [lindex $bs 0]; port make [expr {$off+$i}] }
            select clear
            incr i
        }
    }
}
}

# --------------------------------------------------------------- env/setup ---
proc setup {} {
    global env PDK_ROOT PDK RCFILE SETUP MODELS OUT BLD MAGIC_LIB HERE
    foreach v {PDK_ROOT PDK} { if {![info exists env($v)]} { die "\$$v not set" } }
    set PDK_ROOT $env(PDK_ROOT); set PDK $env(PDK)
    set RCFILE [file join $PDK_ROOT $PDK libs.tech magic $PDK.magicrc]
    set SETUP  [file join $PDK_ROOT $PDK libs.tech netgen ${PDK}_setup.tcl]
    set MODELS [file join $PDK_ROOT $PDK libs.tech ngspice]
    foreach f [list $RCFILE $SETUP $MODELS/sm141064.ngspice $MODELS/design.ngspice] {
        if {![file exists $f]} { die "missing PDK file $f" }
    }
    foreach t {magic netgen ngspice} { need_tool $t }
    mkdirs $OUT $BLD
    spit $BLD/pexlib.tcl $MAGIC_LIB
    if {![file exists $HERE/.gitignore]} { spit $HERE/.gitignore "build/\n" }
}

proc write_env {} {
    global OUT ROOT PDK_ROOT PDK
    set e "# generated by pex/pex.tcl — tool/PDK provenance\n"
    append e "date      : [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S %Z}]\n"
    catch { append e "repo      : [exec git -C $ROOT rev-parse HEAD]" }
    catch { if {[exec git -C $ROOT status --porcelain -- gds layout lvs] ne ""} { append e " (dirty: gds/layout/lvs)" } }
    append e "\n"
    catch { append e "magic     : [lindex [split [exec magic -dnull -noconsole --version] \n] end]\n" }
    catch { append e "netgen    : [lindex [split [exec netgen -batch quit 2>@1] \n] 0]\n" }
    catch { regexp {ngspice-[0-9]+} [exec ngspice -v 2>@1] v; append e "ngspice   : $v\n" }
    append e "PDK       : $PDK_ROOT/$PDK\n"
    set ni [file join $PDK_ROOT $PDK .config nodeinfo.json]
    if {[file exists $ni]} {
        set j [slurp $ni]
        if {[regexp {"build"\s*:\s*\{[^\}]*"open_pdks"\s*:\s*"([^"]+)"} $j -> v]} { append e "open_pdks : $v\n" }
        if {[regexp {"commit"\s*:\s*\{[^\}]*"open_pdks"\s*:\s*"([^"]+)"} $j -> v]} { append e "pdk commit: $v\n" }
    }
    spit $OUT/env.txt $e
}

# ---------------------------------------------------------------- LVS stage ---
set RESULTS [dict create]

proc lvs_one {t} {
    global ROOT OUT BLD RCFILE SETUP FLATGLOB CORE_CELL SUPPLY_PINS RESULTS
    lassign $t cell gds sch
    set gds [file join $ROOT $gds]; set sch [file join $ROOT $sch]
    set wd  [file join $BLD lvs $cell]; set od [file join $OUT lvs]
    file delete -force $wd; mkdirs $wd $od
    set pins [subckt_pins $sch $cell]

    spit $wd/lvs.tcl [subst -nocommands {
source $BLD/pexlib.tcl
pex::read $gds $cell {$FLATGLOB}
foreach l [pex::fix_labels $cell {$pins} $CORE_CELL {$SUPPLY_PINS}] { puts "PEXFIX \$l" }
extract all
ext2spice lvs
ext2spice -o $od/$cell.layout.spice
quit -noprompt
}]
    run $wd $wd/magic.log magic -dnull -noconsole -rcfile $RCFILE $wd/lvs.tcl
    set mlog [slurp $wd/magic.log]
    set fixes [regexp -all -inline -line {^PEXFIX (.*)$} $mlog]
    if {![file exists $od/$cell.layout.spice]} {
        dict set RESULTS lvs $cell [list FAIL "magic extraction failed, see [rel $wd/magic.log]" {}]
        return
    }
    set rpt $od/$cell.lvs.report
    run $wd $wd/netgen.log netgen -batch lvs "$od/$cell.layout.spice $cell" "$sch $cell" $SETUP $rpt -json
    set r [expr {[file exists $rpt] ? [slurp $rpt] : ""}]
    set dev ""
    regexp {.*Circuit 1 contains (\d+) devices, Circuit 2 contains (\d+) devices} $r -> d1 d2
    regexp {.*Circuit 1 contains (\d+) nets,\s+Circuit 2 contains (\d+) nets} $r -> n1 n2
    if {[info exists d1]} { set dev "devices $d1/$d2, nets $n1/$n2 (top level, layout/schematic)" }
    if {[regexp {Final result: Circuits match uniquely} $r] && ![regexp {Property errors were found} $r]} {
        set v PASS
    } elseif {[regexp {Final result: Circuits match uniquely} $r]} {
        set v "FAIL (property errors)"
    } else { set v FAIL }
    set fx {}; foreach {- f} $fixes { lappend fx $f }
    dict set RESULTS lvs $cell [list $v $dev $fx]
    say "LVS  [format %-28s $cell] $v"
}

proc stage_lvs {} {
    global LVS_TARGETS
    foreach t $LVS_TARGETS { lvs_one $t }
}

# ---------------------------------------------------------------- PEX stage ---
proc pex_one {cell mode} {
    global ROOT OUT BLD RCFILE FLATGLOB CORE_CELL SUPPLY_PINS RC_TOLERANCE RESULTS
    lassign [pin_of $cell] - gds sch
    set gds [file join $ROOT $gds]; set sch [file join $ROOT $sch]
    set wd  [file join $BLD pex ${cell}_$mode]; set od [file join $OUT pex]
    file delete -force $wd; mkdirs $wd $od
    set pins [subckt_pins $sch $cell]
    set raw  $wd/${cell}_raw.spice
    set rcon [expr {$mode eq "rc"}]

    spit $wd/pex.tcl [subst -nocommands {
source $BLD/pexlib.tcl
pex::read $gds $cell {$FLATGLOB}
foreach l [pex::fix_labels $cell {$pins} $CORE_CELL {$SUPPLY_PINS}] { puts "PEXFIX \$l" }
# flatten: uniform extraction incl. cross-block coupling; sub-cell labels are
# kept with hierarchical prefixes (e.g. tanh_ota_0.V_in_p) as net names
select top cell
flatten -noports ${cell}__flat
load ${cell}__flat
cellname delete $cell
cellname rename ${cell}__flat $cell
load $cell
pex::order_ports $cell {$pins}
if {$rcon} {
    extresist tolerance $RC_TOLERANCE
    extract do resistance
}
extract all
ext2spice format ngspice
ext2spice scale off
ext2spice hierarchy on
ext2spice subcircuit top on
ext2spice cthresh 0
if {$rcon} { ext2spice extresist on }
ext2spice -o $raw
quit -noprompt
}]
    set t0 [clock milliseconds]
    run $wd $wd/magic.log magic -dnull -noconsole -rcfile $RCFILE $wd/pex.tcl
    set dt [expr {([clock milliseconds]-$t0)/1000.0}]
    if {![file exists $raw]} {
        dict set RESULTS pex $cell $mode [list FAIL "see [rel $wd/magic.log]"]; say "PEX  $cell/$mode FAIL"; return
    }
    # rename subckt -> <cell>_pex_<mode>, verify port order
    set name ${cell}_pex_$mode
    set txt [regsub -line "^\\.subckt $cell " [slurp $raw] ".subckt $name "]
    set txt [regsub -line "^\\.ends.*$" $txt ".ends $name"]
    set hdr "* $name — Magic [string toupper $mode] extraction of $cell ([rel $gds])\n"
    append hdr "* generated by pex/pex.tcl, see pex/out/env.txt for provenance\n"
    append hdr "* ports (schematic order): $pins\n"
    spit $od/$name.spice $hdr$txt
    set got [subckt_pins $od/$name.spice $name]
    set ok [expr {$got eq $pins ? "ok" : "PORT ORDER MISMATCH: $got"}]
    dict set RESULTS pex $cell $mode [list $ok [format %.1fs $dt] [rel $od/$name.spice]]
    say "PEX  [format %-28s $cell/$mode] $ok ([format %.1f $dt] s)"
}

proc stage_pex {} {
    global PEX_TARGETS PEX_MODES
    foreach c $PEX_TARGETS { foreach m $PEX_MODES { pex_one $c $m } }
}

# netlist statistics for the summary
proc pex_stats {file pins} {
    set nR 0; set nC 0; set nX 0; set nD 0; set Ctot 0.0; set Rmax 0.0; set float {}
    array set cnet {}
    foreach p $pins { set cnet($p) 0.0 }
    foreach l [spice_lines [slurp $file]] {
        set w [regexp -all -inline {\S+} $l]
        if {![llength $w]} continue
        switch -glob -- [string toupper [string index [lindex $w 0] 0]] {
            R { incr nR; set v [sval [lindex $w 3]]; if {$v > $Rmax} { set Rmax $v } }
            X { incr nX }
            D { incr nD }
            C {
                incr nC; set v [sval [lindex $w 3]]; set Ctot [expr {$Ctot+$v}]
                foreach n [lrange $w 1 2] {
                    set base [regsub {\.[nt]\d+$} $n ""]
                    if {[info exists cnet($base)]} { set cnet($base) [expr {$cnet($base)+$v}] }
                }
                if {[string match "*FLOATING*" $l]} { lappend float [lindex $w 1] }
            }
        }
    }
    return [list nX $nX nD $nD nR $nR nC $nC Ctot $Ctot Rmax $Rmax cnet [array get cnet] float $float]
}

# node name a_X_Y# -> um (gf180 magic: 1 unit = 5 nm)
proc node_um {n} {
    if {[regexp {a_(-?\d+)_(-?\d+)#} $n -> x y]} { return [format "(%.2f, %.2f)" [expr {$x*0.005}] [expr {$y*0.005}]] }
    return ""
}

# -------------------------------------------------------------- check stage ---
proc deck {cell view incfile subname pins wd} {
    global MODELS CORNER RES_CORNER DIODE_CORNER STIM OUT_PIN DC_SWEEP AC_SRC
    set d "* check $cell / $view\n"
    append d ".include $MODELS/design.ngspice\n"
    append d ".lib $MODELS/sm141064.ngspice $CORNER\n"
    append d ".lib $MODELS/sm141064.ngspice $RES_CORNER\n"
    append d ".lib $MODELS/sm141064.ngspice $DIODE_CORNER\n"
    append d ".include $incfile\n.temp 27\n"
    set conn {}
    foreach p $pins {
        if {[dict exists $STIM $p]} {
            lassign [dict get $STIM $p] kind val
            if {$kind eq "v"} {
                append d "V$p $p 0 $val\n"
            } else {
                set ac [expr {$p eq $AC_SRC ? " ac 1" : ""}]
                append d "I$p $p 0 dc $val$ac\n"
            }
        }
        lappend conn $p
    }
    append d "xdut $conn $subname\n"
    lassign $DC_SWEEP sp a b s
    set vo [string tolower $OUT_PIN]
    append d ".control\nset filetype=ascii\nset wr_singlescale\nset wr_vecnames\noption numdgt=7\n"
    append d "op\nlet ivdd = -vvdd#branch\nprint v($vo) ivdd\nwrite $wd/op.raw all\n"
    # 'reset' before each analysis: without it ngspice-42 AC results depend on
    # the previous dc/tran run when the ESD diodes are present (verified)
    append d "reset\nac dec 20 1 1G\nlet mg = mag(v($vo))\nwrdata $wd/ac.txt mg\n"
    append d "reset\ndc V$sp $a $b $s\nwrdata $wd/dc.txt v($vo)\n"
    append d ".endc\n.end\n"
    return $d
}

proc read_cols {f} {
    set rows {}
    foreach l [split [slurp $f] \n] {
        set w [regexp -all -inline {\S+} $l]
        if {[llength $w] >= 2 && [string is double -strict [lindex $w 0]]} { lappend rows [list [lindex $w 0] [lindex $w end]] }
    }
    return $rows
}

# ascii raw (op): name -> value
proc read_raw_op {f} {
    set txt [split [slurp $f] \n]; set names {}; set vals {}; set mode ""
    foreach l $txt {
        if {[string match "Variables:*" $l]} { set mode v; continue }
        if {[string match "Values:*" $l]} { set mode d; continue }
        set w [regexp -all -inline {\S+} $l]
        if {$mode eq "v" && [llength $w] >= 3} { lappend names [lindex $w 1] }
        if {$mode eq "d" && [llength $w]} { lappend vals [lindex $w end] }
    }
    set out [dict create]
    foreach n $names v $vals { if {$v ne ""} { dict set out [string tolower $n] $v } }
    return $out
}

proc check_one {cell} {
    global ROOT OUT BLD RESULTS PEX_MODES OUT_PIN SUPPLY_PINS STIM
    lassign [pin_of $cell] - gds sch
    set sch [file join $ROOT $sch]
    set pins [subckt_pins $sch $cell]
    set views [list sch]; foreach m $PEX_MODES { lappend views $m }
    foreach v $views {
        set wd [file join $BLD check ${cell}_$v]; file delete -force $wd; mkdirs $wd
        if {$v eq "sch"} { set inc $sch; set sub $cell } else {
            set sub ${cell}_pex_$v; set inc [file join $OUT pex $sub.spice]
            if {![file exists $inc]} { die "missing [rel $inc] — run the pex stage first" }
        }
        spit $wd/deck.spice [deck $cell $v $inc $sub $pins $wd]
        set t0 [clock milliseconds]
        run $wd $wd/ngspice.log ngspice -b $wd/deck.spice
        set dt [expr {([clock milliseconds]-$t0)/1000.0}]
        set log [slurp $wd/ngspice.log]
        set vo ""; set iv ""
        regexp -nocase "v\\([string tolower $OUT_PIN]\\) = (\\S+)" $log -> vo
        regexp {ivdd = (\S+)} $log -> iv
        set r [dict create time $dt vout $vo ivdd $iv]
        if {[file exists $wd/dc.txt]} { dict set r dc [read_cols $wd/dc.txt] }
        if {[file exists $wd/ac.txt]} {
            set ac [read_cols $wd/ac.txt]
            set g0 [lindex $ac 0 1]; set f3 ""
            foreach row $ac { if {[lindex $row 1] < $g0/sqrt(2.0)} { set f3 [lindex $row 0]; break } }
            dict set r zt $g0; dict set r f3db $f3
        }
        # rail IR drop from the RC netlist: worst sub-node deviation from pin
        if {$v eq "rc" && [file exists $wd/op.raw]} {
            set op [read_raw_op $wd/op.raw]
            foreach s $SUPPLY_PINS {
                set vpin [lindex [dict get $STIM $s] 1]; set worst 0.0; set wn ""
                dict for {n val} $op {
                    if {[regexp "^v\\(xdut\\.[string tolower $s]\\.\[nt\]\\d+\\)\$" $n]} {
                        set dv [expr {abs($val - $vpin)}]
                        if {$dv > $worst} { set worst $dv; set wn $n }
                    }
                }
                dict set r ir $s [list $worst $wn]
            }
        }
        if {[regexp -nocase {(singular matrix|timestep too small|no convergence|error:)} $log m]} { dict set r err $m }
        dict set RESULTS check $cell $v $r
        say "CHK  [format %-28s $cell/$v] Vout=$vo  Ivdd=$iv  ([format %.1f $dt] s)"
    }
}

proc stage_check {} {
    global PEX_TARGETS
    foreach c $PEX_TARGETS { check_one $c }
}


# ------------------------------------------------------------ tb/sim stages ---
# tb  : writes pex/xschem/<cell>_pex_<mode>.sym (copy of schematics/<cell>.sym
#       whose netlist is the PEX file via spice_sym_def) and
#       pex/xschem/<tb>_<view>.sch (copy of schematics/<tb>.sch with the DUT
#       swapped, wrdata redirected to pex/out/sim/<tb>_<view>/plots/, and
#       @m.* device probes removed: device names do not survive extraction)
# sim : xschem batch netlist -> ngspice -b -> repo plot scripts -> overlays
proc stage_tb {} {
    global ROOT HERE OUT TB_LIST SIM_VIEWS PEX_MODES RESULTS
    set proj [file tail $ROOT]
    set xd [file join $HERE xschem]; mkdirs $xd
    set cells {}
    foreach t $TB_LIST { lappend cells [lindex $t 1] }
    foreach cell [lsort -unique $cells] {
        set src [file join $ROOT schematics $cell.sym]
        foreach m $PEX_MODES {
            set net [file join $OUT pex ${cell}_pex_$m.spice]
            set sym [slurp $src]
            set sym [string map [list "template=\"name=x1\"" "template=\"name=x1\"\nspice_sym_def=\".include $net\""] $sym]
            append sym "T {PEX [string toupper $m]} -40 -110 0 0 0.3 0.3 {}\n"
            spit [file join $xd ${cell}_pex_$m.sym] $sym
        }
    }
    foreach t $TB_LIST {
        lassign $t tb cell -
        set src [file join $ROOT schematics $tb.sch]
        if {![file exists $src]} { say "TB   $tb: [rel $src] missing, skipped"; continue }
        set orig [slurp $src]
        foreach v $SIM_VIEWS {
            if {$v eq "sch"} { set newsym "$proj/lvs/schematics/$cell.sym" } else { set newsym "$proj/pex/xschem/${cell}_pex_$v.sym" }
            set txt [string map [list "{$proj/schematics/$cell.sym}" "{$newsym}"] $orig]
            set dd [file join $OUT sim ${tb}_$v plots]
            set txt [regsub -all {(wrdata\s+)\S*/plots/([^\s/]+\.txt)} $txt "\\1$dd/\\2"]
            set txt [regsub -all {[ \t]+@m\.[^\s]+} $txt ""]
            spit [file join $xd ${tb}_$v.sch] $txt
        }
        say "TB   $tb -> pex/xschem/${tb}_{[join $SIM_VIEWS ,]}.sch"
    }
}

set OVERLAY_PY {
import sys, numpy as np, matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from pathlib import Path
root, tb, out = Path(sys.argv[1]), sys.argv[2], Path(sys.argv[3])
views = [v for v in ("sch", "c", "rc") if (root / f"{tb}_{v}" / "plots").is_dir()]
ref = root / f"{tb}_{views[0]}" / "plots"
files = sorted(ref.glob("*.txt"))
if files:
    out.mkdir(parents=True, exist_ok=True)
for f in files:
    fig, ax = plt.subplots(figsize=(6, 4))
    ac = "ac" in f.stem
    for v, st in zip(views, ("-", "--", ":")):
        p = root / f"{tb}_{v}" / "plots" / f.name
        if not p.exists():
            continue
        d = np.atleast_2d(np.loadtxt(p))
        x = d[:, 0].astype(float)
        y = np.hypot(d[:, -2], d[:, -1]) if (ac and d.shape[1] >= 3) else d[:, -1].astype(float)
        brk = np.where(np.diff(x) < 0)[0] + 1          # stacked sweeps: no retrace lines
        x, y = np.insert(x, brk, np.nan), np.insert(y, brk, np.nan)
        ax.plot(x, y, st, lw=1.2, label=v)
    if ac:
        ax.set_xscale("log"); ax.set_yscale("log")
    ax.set_title(f"{tb}: {f.stem}"); ax.grid(alpha=0.3); ax.legend()
    fig.tight_layout(); fig.savefig(out / f"{f.stem}.png", dpi=120); plt.close(fig)
    print("[ok]", f.stem)
}

proc stage_sim {} {
    global ROOT HERE OUT BLD TB_LIST SIM_VIEWS RESULTS PDK_ROOT PDK OVERLAY_PY
    need_tool xschem
    set rc [file join $PDK_ROOT $PDK libs.tech xschem xschemrc]
    set parent [file dirname $ROOT]; set proj [file tail $ROOT]
    foreach t $TB_LIST {
        lassign $t tb cell plot
        foreach v $SIM_VIEWS {
            set sch [file join $HERE xschem ${tb}_$v.sch]
            if {![file exists $sch]} { die "missing [rel $sch] — run the tb stage first" }
            set wd [file join $BLD sim ${tb}_$v]; file delete -force $wd; mkdirs $wd
            set od [file join $OUT sim ${tb}_$v]; file delete -force $od; mkdirs $od/plots
            set old [pwd]; cd $parent
            catch {exec env PWD=$parent xschem --rcfile $rc -n -s -q -x -o $wd $proj/pex/xschem/${tb}_$v.sch >& $wd/xschem.log}
            cd $old
            set nl [file join $wd ${tb}_$v.spice]
            if {![file exists $nl]} {
                dict set RESULTS sim $tb $v [list FAIL "netlist failed, see [rel $wd/xschem.log]" 0 0]
                say "SIM  [format %-34s $tb/$v] FAIL (netlist)"; continue
            }
            set t0 [clock milliseconds]
            run $wd $wd/ngspice.log ngspice -b $nl
            set dt [expr {([clock milliseconds]-$t0)/1000.0}]
            set log [slurp $wd/ngspice.log]
            set nf [llength [glob -nocomplain $od/plots/*.txt]]
            set st ok
            if {[regexp -nocase {(singular matrix|timestep too small|no convergence|error on line|could not find)} $log m]} { set st "⚠ $m" }
            if {$st eq "ok" && [regexp -nocase {source stepping failed} $log]} {
                set st "⚠ DC op did not converge in ≥1 analysis (gmin+source stepping failed) — that data is invalid"
            }
            if {!$nf && [regexp -nocase {v\(v_out_perceptron\) = (\S+)} $log -> vop]} { append st ", op Vout = $vop V" }
            dict set RESULTS sim $tb $v [list $st [format %.1fs $dt] $nf [rel $od]]
            say "SIM  [format %-34s $tb/$v] $st ([format %.1f $dt] s, $nf data files)"
        }
    }
}


# plot: repo plot scripts, unmodified, run with cwd = pex/out/sim/<tb>_<view>,
# so their ./plots paths resolve to that folder (mirrors repo-root/plots/),
# plus sch/c/rc overlays into pex/out/sim/compare/<tb>/. Never touches plots/.
proc stage_plot {} {
    global ROOT OUT BLD TB_LIST SIM_VIEWS OVERLAY_PY
    set py [expr {[auto_execok python3] ne "" ? "python3" : "python"}]
    spit $BLD/overlay.py $OVERLAY_PY
    foreach t $TB_LIST {
        lassign $t tb cell plot
        foreach v $SIM_VIEWS {
            set od [file join $OUT sim ${tb}_$v]
            if {$plot eq "" || ![llength [glob -nocomplain $od/plots/*.txt]]} continue
            set rc [run $od $od/plot.log $py [file join $ROOT plots $plot]]
            say "PLOT [format %-34s $tb/$v] [expr {$rc ? "FAIL, see [rel $od/plot.log]" : "ok"}]"
        }
        if {[llength $SIM_VIEWS] > 1 && [llength [glob -nocomplain $OUT/sim/${tb}_*/plots/*.txt]]} {
            file delete -force [file join $OUT sim compare $tb]
            set rc [run $BLD $BLD/overlay_$tb.log $py $BLD/overlay.py [file join $OUT sim] $tb [file join $OUT sim compare $tb]]
            say "PLOT [format %-34s $tb/compare] [expr {$rc ? "FAIL, see [rel $BLD/overlay_$tb.log]" : "ok"}]"
        }
    }
}

# ------------------------------------------------------------------ summary ---
proc fmtv {x {u ""} {d 4}} { if {$x eq ""} { return "—" }; return "[format %.${d}g $x]$u" }

proc write_summary {} {
    global OUT RESULTS PEX_TARGETS PEX_MODES ROOT OUT_PIN
    set s "# PEX / LVS summary — perceptron (gf180mcuD)\n\n"
    append s "Generated by `pex/pex.tcl`. Provenance: \[`env.txt`\](env.txt).\n\n"
    if {[dict exists $RESULTS lvs]} {
        append s "## LVS (magic hierarchical extract vs `lvs/spice/*.spice`, netgen)\n\n"
        append s "| cell | result | top-level counts | report |\n|---|---|---|---|\n"
        dict for {c r} [dict get $RESULTS lvs] {
            lassign $r v dev fx
            append s "| `$c` | **$v** | $dev | \[`lvs/$c.lvs.report`\](lvs/$c.lvs.report) |\n"
        }
        append s "\nIn-session label fixes (GDS untouched):\n\n"
        dict for {c r} [dict get $RESULTS lvs] {
            foreach f [lindex $r 2] { append s "- `$c`: $f\n" }
        }
        append s "\n"
    }
    if {[dict exists $RESULTS pex]} {
        append s "## PEX netlists\n\n"
        append s "| netlist | ports | devices X/D | parasitic R | parasitic C | ΣC | max R | magic time |\n"
        append s "|---|---|---|---|---|---|---|---|\n"
        set cnets {}
        dict for {c md} [dict get $RESULTS pex] {
            dict for {m r} $md {
                lassign $r ok tm path
                if {$ok eq "FAIL"} { append s "| `$c` $m | FAIL | | | | | | |\n"; continue }
                set pins [subckt_pins [file join $ROOT $path] ${c}_pex_$m]
                set st [pex_stats [file join $ROOT $path] $pins]
                dict with st {}
                append s "| \[`[file tail $path]`\](pex/[file tail $path]) | $ok | $nX/$nD | $nR | $nC | [fmtv [expr {$Ctot*1e12}] " pF" 3] | [fmtv $Rmax " Ω" 4] | $tm |\n"
                dict set cnets "$c/$m" $cnet
            }
        }
        append s "\nTotal capacitance per pin net (grounded + coupling, fF):\n\n"
        set hdr "| net |"; set sep "|---|"
        dict for {k -} $cnets { append hdr " `$k` |"; append sep "---|" }
        append s "$hdr\n$sep\n"
        set first [lindex [dict values $cnets] 0]
        foreach {p -} $first {
            append s "| `$p` |"
            dict for {k cn} $cnets { append s " [format %.2f [expr {[dict get $cn $p]*1e15}]] |" }
            append s "\n"
        }
        append s "\n"
    }
    if {[dict exists $RESULTS check]} {
        append s "## Sanity simulation (ngspice, typical, 27 °C)\n\n"
        append s "OP stimulus: see `STIM` in `pex.tcl`. ΔDC = max |Vout(pex) − Vout(sch)| over the DC sweep. Zt = |Vout/I_x1| at 1 Hz, f₋₃dB from the AC sweep.\n\n"
        append s "| cell | view | Vout (V) | I(VDD) | ΔDC max | Zt (Ω) | f₋₃dB | sim time | notes |\n|---|---|---|---|---|---|---|---|---|\n"
        dict for {c vd} [dict get $RESULTS check] {
            set ref [dict get $vd sch]
            dict for {v r} $vd {
                set dd ""
                if {$v ne "sch" && [dict exists $r dc] && [dict exists $ref dc]} {
                    set dd 0.0
                    foreach a [dict get $r dc] b [dict get $ref dc] {
                        if {$a eq "" || $b eq ""} continue
                        set x [expr {abs([lindex $a 1]-[lindex $b 1])}]; if {$x > $dd} { set dd $x }
                    }
                    set dd "[format %.2f [expr {$dd*1e3}]] mV"
                }
                set notes ""
                if {[dict exists $r ir]} {
                    dict for {sp w} [dict get $r ir] { append notes "IR($sp)=[format %.3f [expr {[lindex $w 0]*1e3}]] mV " }
                }
                if {[dict exists $r err]} { append notes "⚠ [dict get $r err]" }
                set zt [expr {[dict exists $r zt] ? [dict get $r zt] : ""}]
                set f3 [expr {[dict exists $r f3db] ? [dict get $r f3db] : ""}]
                append s "| `$c` | $v | [fmtv [dict get $r vout] "" 6] | [fmtv [dict get $r ivdd] " A" 4] | $dd | [fmtv $zt "" 4] | [fmtv $f3 " Hz" 3] | [format %.1f [dict get $r time]] s | $notes |\n"
            }
        }
        append s "\nIR(VDD/VSS) = worst rail sub-node deviation from the pin in the RC netlist (Magic extresist R network incl. metal, contacts and well/substrate paths).\n"
    }
    if {[dict exists $RESULTS sim]} {
        append s "\n## Testbench re-simulation (xschem netlist + ngspice -b)\n\n"
        append s "Data: `sim/<tb>_<view>/plots/*.txt` (each `<tb>_<view>/` mirrors the repo root, so `plots/*.py` run there unmodified). Plots: `tclsh pex/pex.tcl plot`, or by hand (see header of `pex.tcl`); sch/c/rc overlays go to `sim/compare/<tb>/`. `@m.*` device probes are stripped (device names do not survive extraction), so op-sweep Vov plots are not reproduced.\n\n"
        append s "| testbench | view | status | ngspice time | data files | output |\n|---|---|---|---|---|---|\n"
        dict for {tb vd} [dict get $RESULTS sim] {
            dict for {v r} $vd {
                lassign $r st tm nf od
                append s "| `$tb` | $v | $st | $tm | $nf | `[string map [list pex/out/ {}] $od]` |\n"
            }
        }
    }
    spit $OUT/summary.md $s
    say "summary -> [rel $OUT/summary.md]"
}

# --------------------------------------------------------------------- main ---
set stage [expr {$argc ? [lindex $argv 0] : "all"}]
if {$stage eq "clean"} { file delete -force $BLD; say "removed [rel $BLD]"; exit 0 }
if {$stage ni {all lvs pex check tb sim plot}} { die "usage: tclsh pex/pex.tcl ?all|lvs|pex|check|tb|sim|plot|clean?" }

setup
write_env
# results persist across partial runs so summary.md always covers every stage
set RESFILE [file join $OUT .results]
if {[file exists $RESFILE]} { catch { set RESULTS [slurp $RESFILE] } }
foreach {st keys} {lvs lvs pex pex check check sim sim} {
    if {$stage in [list all $st]} { catch { dict unset RESULTS $keys } }
}
if {$stage in {all lvs}}   { stage_lvs }
if {$stage in {all pex}}   { stage_pex }
if {$stage in {all check}} { stage_check }
if {$stage in {all tb}}    { stage_tb }
if {$stage in {all sim}}   { stage_sim }
if {$stage eq "plot"}      { stage_plot }
write_summary

# exit status: 1 if any LVS failed or any PEX port order is off
set bad 0
if {[dict exists $RESULTS lvs]} { dict for {c r} [dict get $RESULTS lvs] { if {[lindex $r 0] ne "PASS"} { set bad 1 } } }
if {[dict exists $RESULTS pex]} { dict for {c md} [dict get $RESULTS pex] { dict for {m r} $md { if {[lindex $r 0] ne "ok"} { set bad 1 } } } }
exit $bad
