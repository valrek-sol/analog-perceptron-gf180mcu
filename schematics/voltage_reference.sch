v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 470 -940 470 -900 {lab=V_I_1_65}
N 470 -840 470 -800 {lab=V_I_1_25}
N 470 -740 470 -700 {lab=V_I_1_15}
N 430 -970 450 -970 {lab=VSS}
N 430 -970 430 -870 {lab=VSS}
N 430 -870 450 -870 {lab=VSS}
N 430 -870 450 -870 {lab=VSS}
N 430 -870 430 -770 {lab=VSS}
N 430 -770 450 -770 {lab=VSS}
N 430 -770 450 -770 {lab=VSS}
N 430 -770 430 -670 {lab=VSS}
N 430 -670 450 -670 {lab=VSS}
N 430 -670 450 -670 {lab=VSS}
N 470 -920 570 -920 {lab=V_I_1_65}
N 470 -820 570 -820 {lab=V_I_1_25}
N 470 -720 570 -720 {lab=V_I_1_15}
N 1640 -490 1880 -490 {lab=VSS}
N 1680 -520 1840 -520 {lab=#net1}
N 1640 -630 1640 -550 {lab=#net1}
N 1640 -590 1760 -590 {lab=#net1}
N 1760 -590 1760 -520 {lab=#net1}
N 1880 -630 1880 -550 {lab=v_1_15}
N 1640 -730 1640 -690 {lab=#net2}
N 1640 -730 1760 -730 {lab=#net2}
N 1760 -730 1880 -730 {lab=#net2}
N 1880 -730 1880 -690 {lab=#net2}
N 1880 -590 2040 -590 {lab=v_1_15}
N 1920 -660 1960 -660 {lab=v_1_15}
N 1960 -660 1960 -590 {lab=v_1_15}
N 1270 -670 1270 -660 {lab=v_1_25}
N 1270 -660 1370 -660 {lab=v_1_25}
N 1250 -600 1270 -600 {lab=VSS}
N 1250 -630 1250 -600 {lab=VSS}
N 1560 -1230 1570 -1230 {lab=V_pbias}
N 1560 -1230 1560 -1190 {lab=V_pbias}
N 1560 -1190 1610 -1190 {lab=V_pbias}
N 1610 -1200 1610 -1190 {lab=V_pbias}
N 1610 -1190 1610 -1170 {lab=V_pbias}
N 1610 -1110 1610 -1090 {lab=VSS}
N 1590 -1140 1590 -1110 {lab=VSS}
N 1590 -1110 1610 -1110 {lab=VSS}
N 930 -1100 1150 -1100 {lab=#net3}
N 1040 -1100 1040 -1050 {lab=#net3}
N 930 -1240 930 -1160 {lab=#net4}
N 1150 -1240 1150 -1160 {lab=#net5}
N 970 -1270 1110 -1270 {lab=#net4}
N 930 -1220 990 -1220 {lab=#net4}
N 990 -1270 990 -1220 {lab=#net4}
N 930 -1360 930 -1310 {lab=VDD}
N 1150 -1360 1150 -1300 {lab=VDD}
N 930 -1360 1150 -1360 {lab=VDD}
N 930 -1310 930 -1300 {lab=VDD}
N 1190 -1130 1230 -1130 {lab=v_1_65}
N 1780 -1120 1800 -1120 {lab=V_nbias}
N 1780 -1180 1780 -1120 {lab=V_nbias}
N 1780 -1180 1840 -1180 {lab=V_nbias}
N 1840 -1180 1840 -1150 {lab=V_nbias}
N 1840 -1200 1840 -1180 {lab=V_nbias}
N 930 -590 1150 -590 {lab=#net6}
N 1040 -590 1040 -540 {lab=#net6}
N 930 -730 930 -650 {lab=#net7}
N 1150 -730 1150 -650 {lab=#net8}
N 970 -760 1110 -760 {lab=#net7}
N 930 -710 990 -710 {lab=#net7}
N 990 -760 990 -710 {lab=#net7}
N 930 -850 930 -800 {lab=VDD}
N 1150 -850 1150 -790 {lab=VDD}
N 930 -850 1150 -850 {lab=VDD}
N 930 -800 930 -790 {lab=VDD}
N 1150 -700 1230 -700 {lab=#net8}
N 1350 -660 1350 -540 {lab=v_1_25}
N 1190 -540 1350 -540 {lab=v_1_25}
N 1190 -620 1190 -540 {lab=v_1_25}
N 1270 -1100 1290 -1100 {lab=VSS}
N 1270 -1130 1270 -1100 {lab=VSS}
N 1150 -1200 1250 -1200 {lab=#net5}
N 1290 -1170 1290 -1160 {lab=v_1_65}
N 1290 -1160 1380 -1160 {lab=v_1_65}
N 1370 -1160 1370 -1050 {lab=v_1_65}
N 1230 -1050 1370 -1050 {lab=v_1_65}
N 1230 -1130 1230 -1050 {lab=v_1_65}
N 430 -640 470 -640 {lab=VSS}
N 430 -670 430 -640 {lab=VSS}
N 470 -1350 470 -1000 {lab=VDD}
N 470 -640 470 -410 {lab=VSS}
C {symbols/ppolyf_u_1k.sym} 470 -970 0 0 {name=R1
W=3e-6
L=165e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 470 -870 0 0 {name=R2
W=3e-6
L=40e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 470 -770 0 0 {name=R3
W=3e-6
L=10e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 470 -670 0 0 {name=R4
W=3e-6
L=115e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {iopin.sym} 470 -1350 3 0 {name=p1 lab=VDD}
C {iopin.sym} 470 -410 1 0 {name=p2 lab=VSS}
C {opin.sym} 1380 -1160 0 0 {name=p3 lab=v_1_65}
C {opin.sym} 2040 -590 0 0 {name=p5 lab=v_1_15}
C {opin.sym} 1370 -660 0 0 {name=p4 lab=v_1_25}
C {lab_pin.sym} 570 -920 2 0 {name=p13 sig_type=std_logic lab=V_I_1_65}
C {lab_pin.sym} 570 -820 2 0 {name=p14 sig_type=std_logic lab=V_I_1_25}
C {lab_pin.sym} 570 -720 2 0 {name=p15 sig_type=std_logic lab=V_I_1_15}
C {symbols/pfet_03v3.sym} 1740 -760 0 0 {name=M11
L=1u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 1620 -660 0 0 {name=M12
L=1u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 1900 -660 0 1 {name=M13
L=1u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1660 -520 0 1 {name=M14
L=1u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1860 -520 0 0 {name=M15
L=1u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1760 -760 2 0 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1640 -660 2 0 {name=p29 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1880 -660 0 0 {name=p31 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1880 -520 2 0 {name=p32 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1760 -490 3 0 {name=p33 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1760 -790 1 0 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1600 -660 0 0 {name=p35 sig_type=std_logic lab=V_I_1_15}
C {lab_pin.sym} 1720 -760 0 0 {name=p48 sig_type=std_logic lab=V_pbias}
C {symbols/nfet_03v3.sym} 1250 -700 0 0 {name=M21
L=1u
W=100u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1270 -730 1 0 {name=p19 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1270 -700 2 0 {name=p44 sig_type=std_logic lab=VSS}
C {symbols/ppolyf_u_1k.sym} 1270 -630 0 0 {name=R6
W=3e-6
L=20e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} 1270 -600 3 0 {name=p49 sig_type=std_logic lab=VSS}
C {symbols/pfet_03v3.sym} 1590 -1230 0 0 {name=M22
L=1u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1610 -1260 1 0 {name=p50 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1610 -1090 3 0 {name=p51 sig_type=std_logic lab=VSS}
C {symbols/ppolyf_u_1k.sym} 1610 -1140 0 0 {name=R7
W=3e-6
L=150e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} 1610 -1230 2 0 {name=p52 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1560 -1230 0 0 {name=p53 sig_type=std_logic lab=V_pbias}
C {symbols/nfet_03v3.sym} 910 -1130 0 0 {name=M1
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1170 -1130 0 1 {name=M2
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1020 -1020 0 0 {name=M3
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 950 -1270 0 1 {name=M4
L=2u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 1130 -1270 0 0 {name=M5
L=2u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1040 -1020 2 0 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 930 -1130 2 0 {name=p10 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1150 -1270 2 0 {name=p11 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1150 -1130 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 930 -1270 0 0 {name=p17 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1040 -990 3 0 {name=p8 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1040 -1360 1 0 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 890 -1130 0 0 {name=p18 sig_type=std_logic lab=V_I_1_65}
C {symbols/nfet_03v3.sym} 1820 -1120 0 0 {name=M23
L=1u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1840 -1090 3 0 {name=p47 sig_type=std_logic lab=VSS}
C {symbols/ppolyf_u_1k.sym} 1840 -1230 0 0 {name=R8
W=3e-6
L=150e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} 1840 -1260 1 0 {name=p54 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1820 -1230 0 0 {name=p55 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1840 -1120 2 0 {name=p56 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1780 -1170 0 0 {name=p57 sig_type=std_logic lab=V_nbias}
C {lab_pin.sym} 1000 -1020 0 0 {name=p58 sig_type=std_logic lab=V_nbias}
C {symbols/nfet_03v3.sym} 910 -620 0 0 {name=M6
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1170 -620 0 1 {name=M7
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 1020 -510 0 0 {name=M8
L=2u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 950 -760 0 1 {name=M9
L=2u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 1130 -760 0 0 {name=M10
L=2u
W=20u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1040 -510 2 0 {name=p20 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 930 -620 2 0 {name=p21 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1150 -760 2 0 {name=p22 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1150 -620 0 0 {name=p23 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 930 -760 0 0 {name=p24 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1040 -480 3 0 {name=p25 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1040 -850 1 0 {name=p26 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 890 -620 0 0 {name=p27 sig_type=std_logic lab=V_I_1_25}
C {lab_pin.sym} 1000 -510 0 0 {name=p46 sig_type=std_logic lab=V_nbias}
C {symbols/nfet_03v3.sym} 1270 -1200 0 0 {name=M24
L=1u
W=100u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 1290 -1230 1 0 {name=p59 sig_type=std_logic lab=VDD}
C {symbols/ppolyf_u_1k.sym} 1290 -1130 0 0 {name=R9
W=3e-6
L=20e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} 1290 -1100 3 0 {name=p60 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1290 -1200 2 0 {name=p61 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1640 -520 0 0 {name=p43 sig_type=std_logic lab=VSS}
C {title-3.sym} 0 0 0 0 {name=l1 author="Guru Charan" rev=1.0 lock=false}
