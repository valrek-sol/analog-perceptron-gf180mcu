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
N 220 20 300 20 {lab=V_tail}
N -30 -420 -30 -390 {lab=VSS}
N -30 -390 10 -390 {lab=VSS}
N 10 -390 20 -390 {lab=VSS}
N 10 -450 20 -450 {lab=I_o_n}
N 10 -420 20 -420 {lab=VSS}
N 1000 -430 1000 -400 {lab=VSS}
N 960 -400 1000 -400 {lab=VSS}
N 950 -400 960 -400 {lab=VSS}
N 950 -460 960 -460 {lab=I_o_p}
N 950 -430 960 -430 {lab=VSS}
N 10 -190 10 -160 {lab=VSS}
N 10 -160 50 -160 {lab=VSS}
N 50 -160 60 -160 {lab=VSS}
N 50 -220 60 -220 {lab=#net1}
N 50 -190 60 -190 {lab=VSS}
N 960 -190 960 -160 {lab=VSS}
N 920 -160 960 -160 {lab=VSS}
N 910 -160 920 -160 {lab=VSS}
N 910 -220 920 -220 {lab=#net2}
N 910 -190 920 -190 {lab=VSS}
N 10 20 10 50 {lab=VSS}
N 10 50 50 50 {lab=VSS}
N 50 50 60 50 {lab=VSS}
N 50 -10 60 -10 {lab=#net3}
N 50 20 60 20 {lab=VSS}
N 20 -420 20 -390 {lab=VSS}
N 20 -450 120 -450 {lab=I_o_n}
N 230 -400 230 -370 {lab=VSS}
N 230 -370 270 -370 {lab=VSS}
N 270 -370 280 -370 {lab=VSS}
N 270 -430 280 -430 {lab=I_o_p}
N 270 -400 280 -400 {lab=VSS}
N 280 -400 280 -370 {lab=VSS}
N 280 -430 380 -430 {lab=I_o_p}
N 950 -430 950 -400 {lab=VSS}
N 860 -460 950 -460 {lab=I_o_p}
N 780 -400 780 -370 {lab=VSS}
N 740 -370 780 -370 {lab=VSS}
N 730 -370 740 -370 {lab=VSS}
N 730 -430 740 -430 {lab=I_o_n}
N 730 -400 740 -400 {lab=VSS}
N 730 -400 730 -370 {lab=VSS}
N 600 -430 730 -430 {lab=I_o_n}
N 60 -190 60 -160 {lab=VSS}
N 60 -220 360 -220 {lab=#net1}
N 910 -190 910 -160 {lab=VSS}
N 620 -220 910 -220 {lab=#net2}
N 60 20 60 50 {lab=VSS}
N 60 -10 360 -10 {lab=#net3}
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
C {symbols/nfet_03v3.sym} 400 -330 0 1 {name=M4
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
C {symbols/nfet_03v3.sym} 580 -330 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} 880 -330 0 1 {name=M6
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
C {symbols/nfet_03v3.sym} 340 20 0 0 {name=M7
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
C {symbols/nfet_03v3.sym} 640 20 0 1 {name=M8
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
C {ipin.sym} 220 -180 0 0 {name=p1 lab=V_x_p}
C {ipin.sym} 220 -130 0 0 {name=p2 lab=V_x_n}
C {ipin.sym} 220 20 0 0 {name=p3 lab=V_tail}
C {iopin.sym} 490 110 1 0 {name=p4 lab=VSS
}
C {ipin.sym} 20 -330 0 0 {name=p5 lab=V_w_p
}
C {ipin.sym} 20 -280 0 0 {name=p6 lab=V_w_n
}
C {symbols/ppolyf_u_1k.sym} 490 -50 1 0 {name=R1
W=3e-6
L=46.2e-6
model=ppolyf_u_1k
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
C {symbols/nfet_03v3.sym} -10 -420 0 0 {name=M9
L=0.5u
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
C {lab_pin.sym} 20 -420 2 0 {name=p7 sig_type=std_logic lab=VSS
}
C {symbols/nfet_03v3.sym} 980 -430 0 1 {name=M10
L=0.5u
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
C {lab_pin.sym} 950 -430 2 1 {name=p14 sig_type=std_logic lab=VSS
}
C {symbols/nfet_03v3.sym} 30 -190 0 0 {name=M11
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
C {lab_pin.sym} 60 -190 2 0 {name=p19 sig_type=std_logic lab=VSS
W=5u}
C {symbols/nfet_03v3.sym} 940 -190 0 1 {name=M12
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
C {lab_pin.sym} 910 -190 2 1 {name=p22 sig_type=std_logic lab=VSS
W=5u}
C {symbols/nfet_03v3.sym} 30 20 0 0 {name=M13
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
C {lab_pin.sym} 60 20 2 0 {name=p23 sig_type=std_logic lab=VSS
W=5u}
C {symbols/nfet_03v3.sym} 250 -400 0 0 {name=M15
L=0.5u
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
C {lab_pin.sym} 280 -400 2 0 {name=p25 sig_type=std_logic lab=VSS
}
C {symbols/nfet_03v3.sym} 760 -400 0 1 {name=M16
L=0.5u
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
C {lab_pin.sym} 730 -400 2 1 {name=p26 sig_type=std_logic lab=VSS
}
