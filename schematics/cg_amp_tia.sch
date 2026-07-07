v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 270 -340 270 -280 {lab=V_out}
N 270 -220 270 -210 {lab=I_in}
N 270 -210 270 -140 {lab=I_in}
N 150 -250 230 -250 {lab=V_bias}
N 270 -310 400 -310 {lab=V_out}
N 270 -250 370 -250 {lab=VSS}
N 370 -250 370 -130 {lab=VSS}
N 150 -140 270 -140 {lab=I_in}
C {symbols/nfet_03v3.sym} 250 -250 0 0 {name=M1
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
C {symbols/ppolyf_u.sym} 270 -370 0 0 {name=R1
W=1e-6
L=7e-6
model=ppolyf_u
spiceprefix=X
m=1}
C {iopin.sym} 270 -400 3 0 {name=p1 lab=VDD}
C {iopin.sym} 370 -130 1 0 {name=p2 lab=VSS}
C {ipin.sym} 150 -140 0 0 {name=p3 lab=I_in}
C {ipin.sym} 150 -250 0 0 {name=p4 lab=V_bias}
C {lab_pin.sym} 250 -370 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {opin.sym} 400 -310 0 0 {name=p6 lab=V_out
}
