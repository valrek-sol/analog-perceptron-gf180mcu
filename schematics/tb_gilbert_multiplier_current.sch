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
N 650 -70 940 -70 {lab=0}
N 940 -110 940 -70 {lab=0}
N 740 -250 740 -70 {lab=0}
N 740 -270 740 -250 {lab=0}
N 710 -270 740 -270 {lab=0}
N 500 -70 580 -70 {lab=0}
N 940 -200 940 -170 {lab=#net6}
N 940 -310 940 -260 {lab=V_o_p}
N 780 -310 940 -310 {lab=V_o_p}
N 710 -310 780 -310 {lab=V_o_p}
N 580 -70 650 -70 {lab=0}
N 800 -290 800 -260 {lab=V_o_n}
N 710 -290 800 -290 {lab=V_o_n}
N 800 -200 800 -190 {lab=#net6}
N 800 -190 940 -190 {lab=#net6}
N 910 -230 920 -230 {lab=0}
N 910 -230 910 -170 {lab=0}
N 770 -170 910 -170 {lab=0}
N 770 -230 770 -170 {lab=0}
N 770 -230 780 -230 {lab=0}
N 740 -230 770 -230 {lab=0}
C {vsource.sym} 180 -130 0 0 {name=V_X_P value=1.35 savecurrent=false}
C {vsource.sym} 250 -130 0 0 {name=V_X_N value=1.2 savecurrent=false}
C {vsource.sym} 330 -130 0 0 {name=V_TAIL value=1.8 savecurrent=false}
C {vsource.sym} 20 -130 0 0 {name=V_W_P value=1.65 savecurrent=false}
C {vsource.sym} 100 -130 0 0 {name=V_W_N value=1.65 savecurrent=false}
C {gnd.sym} 180 -40 0 0 {name=l1 lab=0}
C {code.sym} 960 -500 0 0 {name=COMMANDS
value="
.control
  * === Single sweep: baseline transfer curve ===
  alter V_X_P = 1.30
  alter V_X_N = 1.20
  dc V_W_P 1.15 2.15 0.01
  let V_diff_single = v(V_o_p) - v(V_o_n)
  plot V_diff_single title \\"Gilbert Multiplier: Single Weight Sweep\\"
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_single_sweep.txt V_diff_single

  setplot const
  * === Family of curves, one clean sweep per V_X_P step ===
  let n = 0
  dowhile n <= 4
    let vxp = 1.10 + n * 0.05
    alter V_X_P = vxp
    dc V_W_P 1.15 2.15 0.01
    let V_diff_fam = v(V_o_p) - v(V_o_n)
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_family_sweep.txt V_diff_fam
    set appendwrite
    let n = n + 1
  end
  unset appendwrite

  alter V_X_P = 1.35
  alter V_X_N = 1.2
  alter V_W_P = 1.65
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
C {vsource.sym} 940 -140 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 560 -270 0 0 {name=x1}
C {symbols/ppolyf_u.sym} 940 -230 0 0 {name=R1
W=1e-6
L=20e-6
model=ppolyf_u
spiceprefix=X
m=1}
C {symbols/ppolyf_u.sym} 800 -230 0 0 {name=R2
W=1e-6
L=20e-6
model=ppolyf_u
spiceprefix=X
m=1}
C {lab_wire.sym} 840 -310 0 0 {name=p1 sig_type=std_logic lab=V_o_p}
C {lab_wire.sym} 800 -270 0 0 {name=p2 sig_type=std_logic lab=V_o_n}
