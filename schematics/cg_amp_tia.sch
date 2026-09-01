v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 620 -380 620 -320 {lab=V_out}
N 620 -260 620 -250 {lab=I_in}
N 620 -250 620 -180 {lab=I_in}
N 500 -290 580 -290 {lab=V_ref}
N 620 -350 750 -350 {lab=V_out}
N 620 -290 720 -290 {lab=VSS}
N 720 -290 720 -170 {lab=VSS}
N 500 -180 620 -180 {lab=I_in}
N 500 -440 620 -440 {lab=V_ref}
N 500 -440 500 -290 {lab=V_ref}
C {symbols/nfet_03v3.sym} 600 -290 0 0 {name=M1
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
C {symbols/ppolyf_u_1k.sym} 620 -410 0 0 {name=R1
W=3e-6
L=8.1e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {iopin.sym} 620 -440 3 0 {name=p1 lab=V_ref}
C {iopin.sym} 720 -170 1 0 {name=p2 lab=VSS}
C {ipin.sym} 500 -180 0 0 {name=p3 lab=I_in}
C {lab_pin.sym} 600 -410 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {opin.sym} 750 -350 0 0 {name=p6 lab=V_out
}
C {title.sym} 160 0 0 0 {name=l1 author="Guru Charan" rev=1.0 lock=false}
