v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 720 -220 720 -140 {lab=0}
N 350 -140 720 -140 {lab=0}
N 500 -230 650 -230 {lab=V_1_25}
N 650 -230 650 -200 {lab=V_1_25}
N 720 -340 720 -280 {lab=#net1}
N 350 -340 350 -330 {lab=#net1}
N 350 -340 720 -340 {lab=#net1}
C {analog-perceptron-gf180mcu/schematics/voltage_reference.sym} 370 -230 0 0 {name=x1}
C {vsource.sym} 720 -250 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} 720 -140 0 0 {name=l1 lab=0}
C {devices/code_shown.sym} 390 -540 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.temp 27
"}
C {code.sym} 220 -530 0 0 {name=COMMANDS
value="
.control
  op
  print all
  print @m.x1.xm2.m0[vgs] @m.x1.xm3.m0[vgs]
  print @m.x1.xm7.m0[vgs] @m.x1.xm8.m0[vgs]
  print @m.x1.xm12.m0[vgs] @m.x1.xm13.m0[vgs]
  print v(V_1_65) v(V_1_25) v(V_1_15)
.endc
"}
C {lab_pin.sym} 500 -210 2 0 {name=p1 sig_type=std_logic lab=V_1_15}
C {lab_pin.sym} 500 -250 2 0 {name=p2 sig_type=std_logic lab=V_1_65}
C {lab_pin.sym} 500 -230 2 0 {name=p3 sig_type=std_logic lab=V_1_25}
C {isource.sym} 650 -170 0 0 {name=I0 value=100u}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
