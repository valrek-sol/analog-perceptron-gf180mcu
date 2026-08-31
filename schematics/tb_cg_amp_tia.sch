v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 -340 460 -320 {lab=0}
N 460 -340 750 -340 {lab=0}
N 560 -440 560 -340 {lab=0}
N 560 -550 750 -550 {lab=#net1}
N 750 -550 750 -400 {lab=#net1}
N 460 -480 500 -480 {lab=#net2}
N 460 -480 460 -400 {lab=#net2}
C {analog-perceptron-gf180mcu/schematics/cg_amp_tia.sym} 440 -350 0 0 {name=x1}
C {vsource.sym} 750 -370 0 0 {name=V_SUPPLY value=1.25 savecurrent=false}
C {gnd.sym} 460 -320 0 0 {name=l1 lab=0}
C {isource.sym} 460 -370 0 0 {name=I_SENSOR value=50u}
C {lab_pin.sym} 680 -480 2 0 {name=p1 sig_type=std_logic lab=V_out}
C {devices/code_shown.sym} 500 -210 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.temp 27
"}
C {code.sym} 270 -210 0 0 {name=COMMANDS
value="
.control
  op
  print v(V_out)
  print @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
  print @r.x1.xr1.rt1[resistance] @r.x1.xr1.rt2[resistance]

  dc I_SENSOR 0 50u 1u
  let V_out_swp = v(V_out)
  plot V_out_swp title \\"CG-TIA: Sensor Current to Voltage\\"
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/cg_amp_tia_sweep.txt V_out_swp
  * === Op Sweep: M1 headroom across full 0-50uA input range ===
  save all @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
  dc I_SENSOR 0 50u 1u
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_cg_amp_tia.txt v(V_out) @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
.endc
"}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
