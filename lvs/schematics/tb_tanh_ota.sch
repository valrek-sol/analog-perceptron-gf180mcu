v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 620 -120 760 -120 {lab=0}
N 560 -120 560 -90 {lab=0}
N 140 -120 560 -120 {lab=0}
N 220 -270 220 -180 {lab=#net1}
N 220 -270 380 -270 {lab=#net1}
N 560 -120 620 -120 {lab=0}
N 140 -320 380 -320 {lab=#net2}
N 140 -320 140 -180 {lab=#net2}
N 450 -220 450 -120 {lab=0}
N 500 -340 660 -340 {lab=#net3}
N 660 -340 660 -180 {lab=#net3}
N 760 -360 760 -180 {lab=#net4}
N 450 -360 760 -360 {lab=#net4}
C {devices/code_shown.sym} 340 -520 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.temp 27
"}
C {code.sym} 180 -530 0 0 {name=COMMANDS
value="
.control
  op
  echo \\"--- tanh OTA x1: transistor op points ---\\"
  print @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
  print @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds]
  print @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds]
  print @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds]
  print @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds]
  echo \\"--- tanh OTA x1: reference resistor ---\\"
  print @r.x1.xr1.rt1[resistance] @r.x1.xr1.rt2[resistance]
  dc V_IN_P 2.1 2.5 0.002
  let V_out = v(V_out)
  plot V_out title \\"tanh OTA: Saturating Transfer Characteristic\\"
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/tanh_ota_sweep.txt V_out
  * === OP-SWEEP DIAGNOSTIC: all 5 devices' headroom across full input range ===
  save all @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds]
  dc V_IN_P 2.1 2.5 0.002
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_tanh_ota.txt v(V_out) @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds]
.endc
"}
C {vsource.sym} 660 -150 0 0 {name=V_REF value=1.65 savecurrent=false}
C {vsource.sym} 760 -150 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 560 -90 0 0 {name=l1 lab=0}
C {vsource.sym} 220 -150 0 0 {name=V_IN_N value=2.3 savecurrent=false}
C {vsource.sym} 140 -150 0 0 {name=V_IN_P value=2.3 savecurrent=false}
C {lab_pin.sym} 570 -300 0 1 {name=p1 sig_type=std_logic lab=V_out}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
C {analog-perceptron-gf180mcu/lvs/schematics/tanh_ota.sym} 450 -300 0 0 {name=x1}
