v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 440 -290 660 -290 {lab=#net1}
N 550 -290 550 -240 {lab=#net1}
N 550 -180 550 -130 {lab=VSS}
N 440 -430 440 -350 {lab=#net2}
N 660 -430 660 -350 {lab=V_out}
N 480 -460 620 -460 {lab=#net2}
N 440 -410 500 -410 {lab=#net2}
N 500 -460 500 -410 {lab=#net2}
N 440 -550 440 -500 {lab=VDD}
N 660 -550 660 -490 {lab=VDD}
N 440 -550 660 -550 {lab=VDD}
N 550 -590 550 -550 {lab=VDD}
N 120 -320 400 -320 {lab=V_in_p}
N 700 -320 760 -320 {lab=V_in_n}
N 760 -320 760 -270 {lab=V_in_n}
N 120 -270 760 -270 {lab=V_in_n}
N 440 -210 510 -210 {lab=#net3}
N 340 -210 440 -210 {lab=#net3}
N 660 -390 760 -390 {lab=V_out}
N 760 -390 920 -390 {lab=V_out}
N 440 -500 440 -490 {lab=VDD}
N 870 -590 870 -570 {lab=V_ref}
N 870 -510 870 -390 {lab=V_out}
N 300 -180 300 -170 {lab=VSS}
N 300 -170 550 -170 {lab=VSS}
N 300 -550 440 -550 {lab=VDD}
N 300 -550 300 -540 {lab=VDD}
N 300 -480 300 -240 {lab=#net3}
N 300 -290 380 -290 {lab=#net3}
N 380 -290 380 -210 {lab=#net3}
C {symbols/nfet_03v3.sym} 420 -320 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} 680 -320 0 1 {name=M2
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
C {symbols/nfet_03v3.sym} 530 -210 0 0 {name=M3
L=0.5u
W=3u
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
C {symbols/pfet_03v3.sym} 460 -460 0 1 {name=M4
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
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 640 -460 0 0 {name=M5
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
model=pfet_03v3
spiceprefix=X
}
C {iopin.sym} 550 -590 3 0 {name=p1 lab=VDD}
C {iopin.sym} 550 -130 1 0 {name=p2 lab=VSS}
C {lab_pin.sym} 550 -210 2 0 {name=p3 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 440 -320 2 0 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 660 -460 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 660 -320 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 440 -460 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {ipin.sym} 120 -320 0 0 {name=p8 lab=V_in_p}
C {ipin.sym} 120 -270 0 0 {name=p9 lab=V_in_n}
C {opin.sym} 920 -390 0 0 {name=p11 lab=V_out}
C {iopin.sym} 870 -590 3 0 {name=p12 lab=V_ref}
C {lab_pin.sym} 850 -540 0 0 {name=p13 sig_type=std_logic lab=VSS}
C {symbols/ppolyf_u_1k.sym} 870 -540 0 0 {name=R6
W=3e-6
L=45e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/nfet_03v3.sym} 320 -210 0 1 {name=M6
L=0.5u
W=30u
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
C {lab_pin.sym} 280 -510 0 0 {name=p10 sig_type=std_logic lab=VSS}
C {symbols/ppolyf_u_1k.sym} 300 -510 0 0 {name=R1
W=3e-6
L=110e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} 300 -210 0 0 {name=p14 sig_type=std_logic lab=VSS}
C {title.sym} 160 0 0 0 {name=l1 author="Guru Charan"}
