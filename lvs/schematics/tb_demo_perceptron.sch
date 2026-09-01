v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 660 -150 660 -90 {lab=0}
N 660 -150 880 -150 {lab=0}
N 830 -380 940 -380 {lab=V_out_perceptron}
N 210 -150 290 -150 {lab=0}
N 420 -150 660 -150 {lab=0}
N 290 -150 420 -150 {lab=0}
N 140 -150 210 -150 {lab=0}
N 140 -430 140 -210 {lab=#net1}
N 140 -430 530 -430 {lab=#net1}
N 210 -410 530 -410 {lab=#net2}
N 210 -410 210 -210 {lab=#net2}
N 290 -390 290 -210 {lab=#net3}
N 290 -390 530 -390 {lab=#net3}
N 360 -370 530 -370 {lab=#net4}
N 360 -370 360 -210 {lab=#net4}
N 430 -350 430 -210 {lab=#net5}
N 430 -350 530 -350 {lab=#net5}
N 500 -330 530 -330 {lab=#net6}
N 500 -330 500 -210 {lab=#net6}
N 730 -300 730 -150 {lab=0}
N 730 -460 880 -460 {lab=#net7}
N 880 -460 880 -210 {lab=#net7}
C {code.sym} 170 -600 0 0 {name=COMMANDS
value="
.control
  op
  print all
  print v(V_out_perceptron)
.endc
"}
C {devices/code_shown.sym} 340 -610 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice diode_typical
.lib $::180MCU_MODELS/sm141064.ngspice moscap_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {vsource.sym} 880 -180 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 660 -90 0 0 {name=l2 lab=0}
C {lab_pin.sym} 940 -380 2 0 {name=p2 sig_type=std_logic lab=V_out_perceptron}
C {isource.sym} 290 -180 0 0 {name=I_X1 value=25u}
C {isource.sym} 430 -180 0 0 {name=I_X2 value=25u
}
C {vsource.sym} 210 -180 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 500 -180 0 0 {name=V_W2 value=1.65 savecurrent=false}
C {vsource.sym} 360 -180 0 0 {name=V_B value=1.65 savecurrent=false}
C {vsource.sym} 140 -180 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {title.sym} 160 0 0 0 {name=l3 author="Guru Charan"}
C {analog-perceptron-gf180mcu/lvs/schematics/perceptron.sym} 680 -380 0 0 {name=x1}
