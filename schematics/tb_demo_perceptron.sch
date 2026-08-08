v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 -120 460 -60 {lab=0}
N 460 -120 680 -120 {lab=0}
N 630 -380 840 -380 {lab=V_out_perceptron}
N 10 -120 90 -120 {lab=0}
N 220 -120 460 -120 {lab=0}
N 90 -120 220 -120 {lab=0}
N -60 -120 10 -120 {lab=0}
N -60 -400 -60 -180 {lab=#net1}
N -60 -400 330 -400 {lab=#net1}
N 10 -380 330 -380 {lab=#net2}
N 10 -380 10 -180 {lab=#net2}
N 90 -360 90 -180 {lab=#net3}
N 90 -360 330 -360 {lab=#net3}
N 160 -340 330 -340 {lab=#net4}
N 160 -340 160 -180 {lab=#net4}
N 230 -320 230 -180 {lab=#net5}
N 230 -320 330 -320 {lab=#net5}
N 300 -300 330 -300 {lab=#net6}
N 300 -300 300 -180 {lab=#net6}
N 630 -400 680 -400 {lab=#net7}
N 680 -400 680 -180 {lab=#net7}
N 630 -360 640 -360 {lab=0}
N 640 -360 640 -120 {lab=0}
C {vsource.sym} 680 -150 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 460 -60 0 0 {name=l1 lab=0}
C {lab_pin.sym} 840 -380 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {isource.sym} 10 -150 0 0 {name=I_X1 value=50u

}
C {isource.sym} 90 -150 0 0 {name=I_X2 value=50u
}
C {vsource.sym} 160 -150 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 230 -150 0 0 {name=V_W2 value=1.85 savecurrent=false}
C {vsource.sym} 300 -150 0 0 {name=V_B value=1.85 savecurrent=false}
C {code.sym} 910 -600 0 0 {name=COMMANDS
value="
.control
  op
  print all
  print v(V_out_perceptron)
.endc
"}
C {devices/code_shown.sym} 340 -590 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {vsource.sym} -60 -150 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {analog-perceptron-gf180mcu/schematics/perceptron.sym} 480 -350 0 0 {name=x1}
