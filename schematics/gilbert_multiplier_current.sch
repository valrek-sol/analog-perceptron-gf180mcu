v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -300 380 -300 {lab=#net1}
N 600 -300 860 -300 {lab=#net2}
N 360 -90 360 -10 {lab=#net3}
N 620 -90 620 -10 {lab=#net4}
N 300 20 320 20 {lab=V_tail}
N 300 -30 300 20 {lab=V_tail}
N 300 -30 680 -30 {lab=V_tail}
N 680 -30 680 20 {lab=V_tail}
N 660 20 680 20 {lab=V_tail}
N 220 20 300 20 {lab=V_tail}
N 360 50 360 80 {lab=VSS}
N 360 80 620 80 {lab=VSS}
N 620 50 620 80 {lab=VSS}
N 490 80 490 110 {lab=VSS}
N 220 -180 320 -180 {lab=V_x_p}
N 660 -180 680 -180 {lab=V_x_n}
N 680 -180 680 -130 {lab=V_x_n}
N 220 -130 680 -130 {lab=V_x_n}
N 120 -580 120 -360 {lab=I_o_n}
N 380 -460 380 -360 {lab=I_o_p}
N 860 -580 860 -360 {lab=I_o_p}
N 240 -300 240 -260 {lab=#net1}
N 240 -260 360 -260 {lab=#net1}
N 360 -260 360 -210 {lab=#net1}
N 620 -260 620 -210 {lab=#net2}
N 620 -260 730 -260 {lab=#net2}
N 730 -260 740 -260 {lab=#net2}
N 740 -300 740 -260 {lab=#net2}
N 20 -330 80 -330 {lab=V_w_p}
N 900 -330 940 -330 {lab=V_w_p}
N 520 -50 620 -50 {lab=#net4}
N 360 -50 460 -50 {lab=#net3}
N 120 -500 600 -460 {lab=I_o_n}
N 380 -460 860 -500 {lab=I_o_p}
N 360 -150 360 -90 {lab=#net3}
N 620 -150 620 -90 {lab=#net4}
N 600 -460 600 -360 {lab=I_o_n}
N 420 -330 560 -330 {lab=V_w_n}
N 20 -280 490 -280 {lab=V_w_n}
N 490 -330 490 -280 {lab=V_w_n}
N 940 -330 1030 -330 {lab=V_w_p}
C {symbols/nfet_03v3.sym} 340 -180 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} 640 -180 0 1 {name=M2
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
C {symbols/nfet_03v3.sym} 100 -330 0 0 {name=M3
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
C {symbols/nfet_03v3.sym} 400 -330 0 1 {name=M4
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
C {symbols/nfet_03v3.sym} 580 -330 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} 880 -330 0 1 {name=M6
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
C {symbols/nfet_03v3.sym} 340 20 0 0 {name=M7
L=1u
W=5u
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
C {symbols/nfet_03v3.sym} 640 20 0 1 {name=M8
L=1u
W=5u
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
C {ipin.sym} 220 -180 0 0 {name=p1 lab=V_x_p}
C {ipin.sym} 220 -130 0 0 {name=p2 lab=V_x_n}
C {ipin.sym} 220 20 0 0 {name=p3 lab=V_tail}
C {iopin.sym} 490 110 1 0 {name=p4 lab=VSS
}
C {ipin.sym} 20 -330 0 0 {name=p5 lab=V_w_p
}
C {ipin.sym} 20 -280 0 0 {name=p6 lab=V_w_n
}
C {symbols/ppolyf_u.sym} 490 -50 1 0 {name=R1
W=1e-6
L=40e-6
model=ppolyf_u
spiceprefix=X
m=1}
C {opin.sym} 120 -580 3 0 {name=p8 lab=I_o_n
}
C {opin.sym} 860 -580 3 0 {name=p9 lab=I_o_p}
C {lab_pin.sym} 380 -330 0 0 {name=p10 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 120 -330 2 0 {name=p11 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 600 -330 2 0 {name=p12 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 860 -330 0 0 {name=p13 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 620 -180 0 0 {name=p15 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 620 20 0 0 {name=p16 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 360 -180 2 0 {name=p17 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 360 20 2 0 {name=p18 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 490 -70 1 0 {name=p20 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 1030 -330 2 0 {name=p21 sig_type=std_logic lab=V_w_p
}
