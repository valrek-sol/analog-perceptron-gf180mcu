v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 640 -180 740 -180 {lab=0}
N 180 -180 640 -180 {lab=0}
N 440 -180 440 -150 {lab=0}
N 560 -290 600 -290 {lab=0}
N 600 -290 600 -180 {lab=0}
N 100 -180 180 -180 {lab=0}
N 20 -180 100 -180 {lab=0}
N 100 -330 100 -240 {lab=#net1}
N 100 -330 260 -330 {lab=#net1}
N 640 -330 640 -240 {lab=#net2}
N 560 -330 640 -330 {lab=#net2}
N 560 -350 740 -350 {lab=#net3}
N 740 -350 740 -240 {lab=#net3}
N 180 -310 180 -240 {lab=#net4}
N 180 -310 260 -310 {lab=#net4}
N 20 -350 260 -350 {lab=#net5}
N 20 -350 20 -240 {lab=#net5}
C {analog-perceptron-gf180mcu/schematics/tanh_ota.sym} 410 -320 0 0 {name=x1}
C {devices/code_shown.sym} 910 -380 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {code.sym} 900 -560 0 0 {name=COMMANDS
value="
.control
  dc V_IN_P 1.4 1.9 0.002
  
  let V_out = v(V_out)
  plot V_out
.endc
"}
C {vsource.sym} 640 -210 0 0 {name=V_REF value=1.65 savecurrent=false}
C {vsource.sym} 740 -210 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {vsource.sym} 180 -210 0 0 {name=V_BIAS value=0.7 savecurrent=false}
C {gnd.sym} 440 -150 0 0 {name=l1 lab=0}
C {vsource.sym} 100 -210 0 0 {name=V_IN_N value=1.65 savecurrent=false}
C {vsource.sym} 20 -210 0 0 {name=V_IN_P value=1.65 savecurrent=false}
C {lab_pin.sym} 560 -310 0 1 {name=p1 sig_type=std_logic lab=V_out}
