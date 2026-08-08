v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 480 -220 660 -220 {lab=#net1}
N 480 -120 720 -120 {lab=0}
N 720 -220 720 -120 {lab=0}
N 480 -180 600 -180 {lab=V_1_25}
C {analog-perceptron-gf180mcu/schematics/voltage_reference.sym} 330 -170 0 0 {name=x1}
C {vsource.sym} 690 -220 3 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} 720 -120 0 0 {name=l1 lab=0}
C {devices/code_shown.sym} 820 -140 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {code_shown.sym} 820 -470 0 0 {name=COMMANDS
value="
.control
  op
  print all
  print @m.x1.xm2.m0[vgs] @m.x1.xm3.m0[vgs]
  print @m.x1.xm7.m0[vgs] @m.x1.xm8.m0[vgs]
  print @m.x1.xm12.m0[vgs] @m.x1.xm13.m0[vgs]
  print @m.x1.xm17.m0[vgs] @m.x1.xm18.m0[vgs]
  print v(V_1_65) v(V_1_25) v(V_1_15) v(V_0_7)
.endc
"}
C {lab_pin.sym} 480 -160 2 0 {name=p1 sig_type=std_logic lab=V_1_15}
C {lab_pin.sym} 480 -200 2 0 {name=p2 sig_type=std_logic lab=V_1_65}
C {lab_pin.sym} 480 -180 2 0 {name=p3 sig_type=std_logic lab=V_1_25}
C {lab_pin.sym} 480 -140 2 0 {name=p4 sig_type=std_logic lab=V_0_7}
C {isource.sym} 600 -150 0 0 {name=I0 value=100u}
