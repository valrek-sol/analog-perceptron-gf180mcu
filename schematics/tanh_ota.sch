v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 320 -360 540 -360 {lab=#net1}
N 430 -360 430 -310 {lab=#net1}
N 430 -250 430 -200 {lab=VSS}
N 320 -500 320 -420 {lab=#net2}
N 540 -500 540 -420 {lab=V_out}
N 360 -530 500 -530 {lab=#net2}
N 320 -480 380 -480 {lab=#net2}
N 380 -530 380 -480 {lab=#net2}
N 320 -620 320 -570 {lab=VDD}
N 540 -620 540 -560 {lab=VDD}
N 320 -620 540 -620 {lab=VDD}
N 430 -660 430 -620 {lab=VDD}
N 220 -390 280 -390 {lab=V_in_p}
N 580 -390 640 -390 {lab=V_in_n}
N 640 -390 640 -340 {lab=V_in_n}
N 220 -340 640 -340 {lab=V_in_n}
N 320 -280 390 -280 {lab=V_bias}
N 220 -280 320 -280 {lab=V_bias}
N 540 -460 640 -460 {lab=V_out}
N 720 -660 720 -580 {lab=V_ref}
N 640 -460 800 -460 {lab=V_out}
N 720 -520 720 -460 {lab=V_out}
N 320 -570 320 -560 {lab=VDD}
C {symbols/nfet_03v3.sym} 300 -390 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} 560 -390 0 1 {name=M2
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
C {symbols/nfet_03v3.sym} 410 -280 0 0 {name=M3
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
C {symbols/pfet_03v3.sym} 340 -530 0 1 {name=M4
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
C {symbols/pfet_03v3.sym} 520 -530 0 0 {name=M5
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
C {iopin.sym} 430 -660 3 0 {name=p1 lab=VDD}
C {iopin.sym} 430 -200 1 0 {name=p2 lab=VSS}
C {lab_pin.sym} 430 -280 2 0 {name=p3 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 320 -390 2 0 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 540 -530 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 540 -390 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 320 -530 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {ipin.sym} 220 -390 0 0 {name=p8 lab=V_in_p}
C {ipin.sym} 220 -340 0 0 {name=p9 lab=V_in_n}
C {ipin.sym} 220 -280 0 0 {name=p10 lab=V_bias}
C {opin.sym} 800 -460 0 0 {name=p11 lab=V_out}
C {symbols/ppolyf_u.sym} 720 -550 0 0 {name=R1
W=1e-6
L=64e-6
model=ppolyf_u
spiceprefix=X
m=1}
C {iopin.sym} 720 -660 3 0 {name=p12 lab=V_ref}
C {lab_pin.sym} 700 -550 0 0 {name=p13 sig_type=std_logic lab=VSS}
