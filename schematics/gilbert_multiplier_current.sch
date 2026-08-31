v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 220 -560 480 -560 {lab=#net1}
N 700 -560 960 -560 {lab=#net2}
N 460 -350 460 -270 {lab=#net3}
N 720 -350 720 -270 {lab=#net4}
N 400 -240 420 -240 {lab=V_tail}
N 400 -290 400 -240 {lab=V_tail}
N 400 -290 780 -290 {lab=V_tail}
N 780 -290 780 -240 {lab=V_tail}
N 760 -240 780 -240 {lab=V_tail}
N 460 -210 460 -180 {lab=VSS}
N 460 -180 720 -180 {lab=VSS}
N 720 -210 720 -180 {lab=VSS}
N 590 -180 590 -150 {lab=VSS}
N 320 -440 420 -440 {lab=V_x_p}
N 760 -440 780 -440 {lab=V_x_n}
N 780 -440 780 -390 {lab=V_x_n}
N 320 -390 780 -390 {lab=V_x_n}
N 220 -840 220 -620 {lab=I_o_n}
N 480 -720 480 -620 {lab=I_o_p}
N 960 -840 960 -620 {lab=I_o_p}
N 340 -560 340 -520 {lab=#net1}
N 340 -520 460 -520 {lab=#net1}
N 460 -520 460 -470 {lab=#net1}
N 720 -520 720 -470 {lab=#net2}
N 720 -520 830 -520 {lab=#net2}
N 830 -520 840 -520 {lab=#net2}
N 840 -560 840 -520 {lab=#net2}
N 120 -590 180 -590 {lab=V_w_p}
N 1000 -590 1040 -590 {lab=V_w_p}
N 620 -310 720 -310 {lab=#net4}
N 460 -310 560 -310 {lab=#net3}
N 220 -760 700 -720 {lab=I_o_n}
N 480 -720 960 -760 {lab=I_o_p}
N 460 -410 460 -350 {lab=#net3}
N 720 -410 720 -350 {lab=#net4}
N 700 -720 700 -620 {lab=I_o_n}
N 520 -590 660 -590 {lab=V_w_n}
N 120 -540 590 -540 {lab=V_w_n}
N 590 -590 590 -540 {lab=V_w_n}
N 1040 -590 1130 -590 {lab=V_w_p}
N 320 -240 400 -240 {lab=V_tail}
C {symbols/nfet_03v3.sym} 440 -440 0 0 {name=M1
L=0.5u
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
C {symbols/nfet_03v3.sym} 740 -440 0 1 {name=M2
L=0.5u
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
C {symbols/nfet_03v3.sym} 200 -590 0 0 {name=M3
L=0.5u
W=20u
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
C {symbols/nfet_03v3.sym} 500 -590 0 1 {name=M4
L=0.5u
W=20u
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
C {symbols/nfet_03v3.sym} 680 -590 0 0 {name=M5
L=0.5u
W=20u
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
C {symbols/nfet_03v3.sym} 980 -590 0 1 {name=M6
L=0.5u
W=20u
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
C {symbols/nfet_03v3.sym} 440 -240 0 0 {name=M7
L=1u
W=8u
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
C {symbols/nfet_03v3.sym} 740 -240 0 1 {name=M8
L=1u
W=8u
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
C {ipin.sym} 320 -440 0 0 {name=p1 lab=V_x_p}
C {ipin.sym} 320 -390 0 0 {name=p2 lab=V_x_n}
C {ipin.sym} 320 -240 0 0 {name=p3 lab=V_tail}
C {iopin.sym} 590 -150 1 0 {name=p4 lab=VSS
}
C {ipin.sym} 120 -590 0 0 {name=p5 lab=V_w_p
}
C {ipin.sym} 120 -540 0 0 {name=p6 lab=V_w_n
}
C {symbols/ppolyf_u_1k.sym} 590 -310 1 0 {name=R1
W=3e-6
L=46.2e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {opin.sym} 220 -840 3 0 {name=p8 lab=I_o_n
}
C {opin.sym} 960 -840 3 0 {name=p9 lab=I_o_p}
C {lab_pin.sym} 480 -590 0 0 {name=p10 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 220 -590 2 0 {name=p11 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 700 -590 2 0 {name=p12 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 960 -590 0 0 {name=p13 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 720 -440 0 0 {name=p15 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 720 -240 0 0 {name=p16 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 460 -440 2 0 {name=p17 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 460 -240 2 0 {name=p18 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 590 -330 1 0 {name=p20 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 1130 -590 2 0 {name=p21 sig_type=std_logic lab=V_w_p
}
C {title.sym} 160 0 0 0 {name=l1 author="Guru Charan"}
