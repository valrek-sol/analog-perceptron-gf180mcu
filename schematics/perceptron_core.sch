v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 850 -560 910 -560 {lab=#net1}
N 850 -1010 910 -1010 {lab=#net2}
N 870 -780 910 -780 {lab=V_1_15}
N 870 -780 870 -680 {lab=V_1_15}
N 870 -680 1250 -680 {lab=V_1_15}
N 1250 -680 1250 -540 {lab=V_1_15}
N 1250 -540 1270 -540 {lab=V_1_15}
N 1030 -470 1420 -470 {lab=VSS}
N 1030 -690 1190 -690 {lab=VSS}
N 1190 -690 1190 -470 {lab=VSS}
N 1030 -920 1190 -920 {lab=VSS}
N 1190 -920 1190 -690 {lab=VSS}
N 890 -1030 910 -1030 {lab=V_1_25}
N 890 -1030 890 -580 {lab=V_1_25}
N 890 -580 910 -580 {lab=V_1_25}
N 890 -800 910 -800 {lab=V_1_25}
N 1270 -900 1270 -580 {lab=V_1_65}
N 610 -880 1010 -880 {lab=V_b}
N 610 -560 670 -560 {lab=I_x2}
N 610 -500 870 -500 {lab=V_w2}
N 870 -670 870 -500 {lab=V_w2}
N 870 -670 1010 -670 {lab=V_w2}
N 1010 -670 1010 -660 {lab=V_w2}
N 610 -1110 1010 -1110 {lab=V_w1}
N 1050 -880 1270 -880 {lab=V_1_65}
N 1050 -660 1270 -660 {lab=V_1_65}
N 1050 -1110 1270 -1110 {lab=V_1_65}
N 1270 -1110 1270 -900 {lab=V_1_65}
N 900 -720 910 -720 {lab=V_1_65}
N 900 -500 910 -500 {lab=V_1_65}
N 900 -720 900 -500 {lab=V_1_65}
N 1230 -560 1270 -560 {lab=V_1_25}
N 1230 -900 1230 -560 {lab=V_1_25}
N 890 -900 1230 -900 {lab=V_1_25}
N 1140 -1030 1340 -1030 {lab=V_o_p}
N 1140 -800 1340 -800 {lab=V_o_p}
N 1140 -580 1210 -580 {lab=V_o_p}
N 1210 -750 1210 -580 {lab=V_o_p}
N 1210 -750 1340 -750 {lab=V_o_p}
N 1340 -1030 1340 -750 {lab=V_o_p}
N 1340 -1210 1340 -1160 {lab=V_shift}
N 1340 -1100 1340 -1030 {lab=V_o_p}
N 1140 -1010 1520 -1010 {lab=V_o_n}
N 1140 -780 1520 -780 {lab=V_o_n}
N 1140 -560 1170 -560 {lab=V_o_n}
N 1170 -780 1170 -560 {lab=V_o_n}
N 1520 -1010 1520 -780 {lab=V_o_n}
N 1520 -1110 1520 -1010 {lab=V_o_n}
N 1520 -1240 1520 -1170 {lab=VDD}
N 1340 -920 1600 -920 {lab=V_o_p}
N 1520 -870 1600 -870 {lab=V_o_n}
N 1790 -900 1810 -900 {lab=V_out_perceptron}
N 1420 -470 1670 -470 {lab=VSS}
N 1670 -820 1670 -470 {lab=VSS}
N 730 -520 730 -470 {lab=VSS}
N 730 -470 1030 -470 {lab=VSS}
N 660 -970 730 -970 {lab=VSS}
N 660 -970 660 -520 {lab=VSS}
N 660 -520 730 -520 {lab=VSS}
N 890 -1080 890 -1030 {lab=V_1_25}
N 730 -1080 890 -1080 {lab=V_1_25}
N 730 -630 890 -630 {lab=V_1_25}
N 610 -1010 670 -1010 {lab=I_x1}
N 1520 -1170 1670 -1170 {lab=VDD}
N 1670 -1170 1670 -960 {lab=VDD}
N 1420 -660 1570 -660 {lab=VDD}
N 1570 -1170 1570 -660 {lab=VDD}
N 900 -950 900 -720 {lab=V_1_65}
N 900 -950 910 -950 {lab=V_1_65}
N 900 -910 1270 -910 {lab=V_1_65}
N 1720 -980 1720 -940 {lab=V_1_65}
N 1270 -980 1720 -980 {lab=V_1_65}
N 1320 -1130 1320 -1090 {lab=VSS}
N 1320 -1090 1540 -1090 {lab=VSS}
N 1540 -1140 1540 -1090 {lab=VSS}
N 1540 -1090 1540 -800 {lab=VSS}
N 1540 -800 1670 -800 {lab=VSS}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 1030 -1020 0 0 {name=x_g1}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 1030 -570 0 0 {name=x_g2}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 1030 -790 0 0 {name=x_g3}
C {analog-perceptron-gf180mcu/schematics/tanh_ota.sym} 1670 -900 0 0 {name=x_tanh}
C {symbols/ppolyf_u_1k.sym} 1340 -1130 0 0 {name=R1
W=3e-6
L=7.3e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {iopin.sym} 1520 -1240 3 0 {name=p1 lab=VDD}
C {iopin.sym} 1190 -470 1 0 {name=p2 lab=VSS}
C {ipin.sym} 610 -1010 0 0 {name=p4 lab=I_x1}
C {ipin.sym} 610 -560 0 0 {name=p5 lab=I_x2}
C {ipin.sym} 610 -1110 0 0 {name=p10 lab=V_w1}
C {ipin.sym} 610 -500 0 0 {name=p11 lab=V_w2}
C {ipin.sym} 610 -880 0 0 {name=p12 lab=V_b}
C {opin.sym} 1810 -900 0 0 {name=p14 lab=V_out_perceptron}
C {symbols/ppolyf_u_1k.sym} 1520 -1140 2 0 {name=R2
W=3e-6
L=7.3e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {ipin.sym} 1340 -1210 1 0 {name=p15 lab=V_shift}
C {lab_wire.sym} 1340 -920 0 0 {name=p16 sig_type=std_logic lab=V_o_p}
C {lab_wire.sym} 1520 -870 0 0 {name=p17 sig_type=std_logic lab=V_o_n}
C {analog-perceptron-gf180mcu/schematics/voltage_reference.sym} 1400 -560 0 1 {name=x3}
C {lab_wire.sym} 1230 -610 0 0 {name=p6 sig_type=std_logic lab=V_1_25}
C {lab_wire.sym} 1270 -820 0 0 {name=p7 sig_type=std_logic lab=V_1_65}
C {lab_wire.sym} 1250 -540 0 0 {name=p8 sig_type=std_logic lab=V_1_15}
C {analog-perceptron-gf180mcu/schematics/cg_amp_tia.sym} 610 -880 0 0 {name=x1}
C {analog-perceptron-gf180mcu/schematics/cg_amp_tia.sym} 610 -430 0 0 {name=x2}
C {title-3.sym} 0 0 0 0 {name=l1 author="Guru Charan" rev=1.0 lock=false}
