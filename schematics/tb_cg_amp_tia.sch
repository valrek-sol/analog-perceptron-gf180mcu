v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -300 270 -300 {lab=#net1}
N 120 -300 120 -200 {lab=#net1}
N 220 -140 220 -120 {lab=0}
N 120 -140 220 -140 {lab=0}
N 220 -140 640 -140 {lab=0}
N 220 -280 270 -280 {lab=#net2}
N 220 -280 220 -200 {lab=#net2}
N 640 -300 640 -200 {lab=#net3}
N 570 -300 640 -300 {lab=#net3}
N 570 -260 600 -260 {lab=0}
N 600 -260 600 -140 {lab=0}
C {analog-perceptron-gf180mcu/schematics/cg_amp_tia.sym} 420 -280 0 0 {name=x1}
C {vsource.sym} 640 -170 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 220 -120 0 0 {name=l1 lab=0}
C {vsource.sym} 120 -170 0 0 {name=V_BIAS value=1 savecurrent=false}
C {isource.sym} 220 -170 0 0 {name=I_SENSOR value=1u}
C {lab_pin.sym} 570 -280 2 0 {name=p1 sig_type=std_logic lab=V_out}
C {devices/code_shown.sym} 750 -240 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {code.sym} 740 -420 0 0 {name=COMMANDS
value="
.control
  dc I_SENSOR 0 50u 1u
  
  let V_out = v(V_out)
  plot V_out
.endc
"}
