v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 -350 280 -240 {lab=#net1}
N 280 -350 510 -350 {lab=#net1}
N 350 -330 510 -330 {lab=#net2}
N 350 -330 350 -240 {lab=#net2}
N 120 -180 280 -180 {lab=0}
N 280 -150 280 -120 {lab=0}
N 280 -150 840 -150 {lab=0}
N 840 -150 1040 -150 {lab=0}
N 1040 -230 1040 -210 {lab=#net3}
N 1040 -350 1040 -300 {lab=V_o_p}
N 810 -350 1040 -350 {lab=V_o_p}
N 900 -330 900 -300 {lab=V_o_n}
N 810 -330 900 -330 {lab=V_o_n}
N 900 -240 900 -230 {lab=#net3}
N 900 -230 1040 -230 {lab=#net3}
N 1010 -270 1020 -270 {lab=0}
N 1010 -270 1010 -210 {lab=0}
N 870 -210 1010 -210 {lab=0}
N 870 -270 870 -210 {lab=0}
N 870 -270 880 -270 {lab=0}
N 280 -180 280 -150 {lab=0}
N 1040 -240 1040 -230 {lab=#net3}
N 280 -180 350 -180 {lab=0}
N 350 -180 420 -180 {lab=0}
N 420 -270 510 -270 {lab=#net4}
N 420 -270 420 -240 {lab=#net4}
N 630 -240 630 -150 {lab=0}
N 870 -210 870 -150 {lab=0}
N 740 -350 810 -350 {lab=V_o_p}
N 740 -330 810 -330 {lab=V_o_n}
N 200 -450 200 -240 {lab=#net5}
N 200 -450 650 -450 {lab=#net5}
N 650 -450 650 -430 {lab=#net5}
N 120 -480 120 -240 {lab=#net6}
N 120 -480 610 -480 {lab=#net6}
N 610 -480 610 -430 {lab=#net6}
C {vsource.sym} 280 -210 0 0 {name=V_X_P value=1.25 savecurrent=false}
C {vsource.sym} 350 -210 0 0 {name=V_X_N value=1.15 savecurrent=false}
C {vsource.sym} 120 -210 0 0 {name=V_W_P value=1.65 savecurrent=false}
C {vsource.sym} 200 -210 0 0 {name=V_W_N value=1.65 savecurrent=false}
C {gnd.sym} 280 -120 0 0 {name=l1 lab=0}
C {code.sym} 320 -630 0 0 {name=COMMANDS
value="
.control
  op
  echo \\"--- Gilbert cell x1: transistor op points ---\\"
  print @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
  print @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds]
  print @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds]
  print @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds]
  print @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds]
  print @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds]
  print @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds]
  print @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  echo \\"--- Gilbert cell x1: tail resistor ---\\"
  print @r.x1.xr1.rt1[resistance] @r.x1.xr1.rt2[resistance]
  * === Single sweep: baseline transfer curve ===
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  dc V_W_P 1.15 2.15 0.01
  let V_diff_single = v(V_o_p) - v(V_o_n)
  plot V_diff_single title \\"Gilbert Multiplier: Single Weight Sweep\\"
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_single_sweep.txt V_diff_single

  setplot const
  * === Family of curves, one clean sweep per V_X_P step ===
  let n = 0
  dowhile n <= 4
    let vxp = 1.05 + n * 0.05
    alter V_X_P = vxp
    dc V_W_P 1.15 2.15 0.01
    let V_diff_fam = v(V_o_p) - v(V_o_n)
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_family_sweep.txt V_diff_fam
    set appendwrite
    let n = n + 1
  end
  unset appendwrite

  alter V_X_P = 1.25
  alter V_X_N = 1.15
  alter V_W_P = 1.65
  * === OP-SWEEP DIAGNOSTIC: all 8 devices' headroom across full weight range ===
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  save all @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds] @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds] @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds] @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  dc V_W_P 1.15 2.15 0.01
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_gilbert.txt v(V_o_p) v(V_o_n) @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds] @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds] @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds] @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  alter V_W_P = 1.65
.endc
"}
C {devices/code_shown.sym} 490 -630 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.temp 27
"}
C {vsource.sym} 1040 -180 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 630 -340 0 0 {name=x1}
C {symbols/ppolyf_u.sym} 1040 -270 0 0 {name=R1
W=3e-6
L=7.3e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 900 -270 0 0 {name=R2
W=3e-6
L=7.3e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_wire.sym} 940 -350 0 0 {name=p1 sig_type=std_logic lab=V_o_p}
C {lab_wire.sym} 900 -310 0 0 {name=p2 sig_type=std_logic lab=V_o_n}
C {vsource.sym} 420 -210 0 0 {name=V_TAIL value=1.65 savecurrent=false}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
