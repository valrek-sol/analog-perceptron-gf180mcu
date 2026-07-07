v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -310 20 -160 {lab=#net1}
N 20 -310 410 -310 {lab=#net1}
N 100 -290 410 -290 {lab=#net2}
N 100 -290 100 -160 {lab=#net2}
N 180 -270 180 -160 {lab=#net3}
N 180 -270 410 -270 {lab=#net3}
N 250 -250 410 -250 {lab=#net4}
N 250 -250 250 -160 {lab=#net4}
N 330 -230 330 -160 {lab=#net5}
N 330 -230 410 -230 {lab=#net5}
N 20 -100 100 -100 {lab=0}
N 100 -100 180 -100 {lab=0}
N 180 -100 250 -100 {lab=0}
N 250 -100 330 -100 {lab=0}
N 180 -100 180 -40 {lab=0}
N 180 -70 500 -70 {lab=0}
N 500 -70 790 -70 {lab=0}
N 790 -110 790 -70 {lab=0}
N 790 -310 790 -170 {lab=#net6}
N 710 -310 790 -310 {lab=#net6}
N 740 -250 740 -70 {lab=0}
N 710 -250 740 -250 {lab=0}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier.sym} 560 -270 0 0 {name=x1}
C {vsource.sym} 180 -130 0 0 {name=V_X_P value=1.35 savecurrent=false}
C {vsource.sym} 250 -130 0 0 {name=V_X_N value=1.2 savecurrent=false}
C {vsource.sym} 330 -130 0 0 {name=V_TAIL value=1.8 savecurrent=false}
C {vsource.sym} 20 -130 0 0 {name=V_W_P value=1.65 savecurrent=false}
C {vsource.sym} 100 -130 0 0 {name=V_W_N value=1.65 savecurrent=false}
C {gnd.sym} 180 -40 0 0 {name=l1 lab=0}
C {code.sym} 850 -260 0 0 {name=COMMANDS
value="
.control
  * Nested Sweep: 
  * 1. Sweep Weight (V_W_P) from 1.15V to 2.15V in 10mV steps.
  * 2. Step Sensor (V_X_P) from 1.10V to 1.30V in 50mV steps.
  dc V_W_P 1.15 2.15 0.01 V_X_P 1.10 1.30 0.05
  
  * Calculate differential output
  let V_diff_out = v(V_o_p) - v(V_o_n)
  
  * Export the family of curves to a text file
  wrdata /foss/designs/analog-perceptron-gf180mcu/schematics/sweep_4quadrant.txt V_diff_out
  
  * Plot the result in the Xschem GUI
  plot V_diff_out
.endc
"}
C {devices/code_shown.sym} 390 -490 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {vsource.sym} 790 -140 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {lab_pin.sym} 710 -290 2 0 {name=p1 sig_type=std_logic lab=V_o_n}
C {lab_pin.sym} 710 -270 2 0 {name=p2 sig_type=std_logic lab=V_o_p}
