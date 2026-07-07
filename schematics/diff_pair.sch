v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 540 -500 780 -500 {lab=I_bias}
N 660 -500 660 -380 {lab=I_bias}
N 540 -660 540 -560 {lab=I_out_p}
N 780 -660 780 -560 {lab=I_out_n}
N 440 -530 500 -530 {lab=V_in_p}
N 820 -530 880 -530 {lab=V_in_n}
N 540 -530 780 -530 {lab=VSS}
N 660 -580 660 -530 {lab=VSS}
C {title.sym} 160 -40 0 0 {name=l1 author="Guru Charan
"}
C {symbols/nfet_03v3.sym} 520 -530 0 0 {name=M1
L=0.28u
W=0.22u
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
C {symbols/nfet_03v3.sym} 800 -530 0 1 {name=M2
L=0.28u
W=0.22u
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
C {ipin.sym} 440 -530 0 0 {name=p1 lab=V_in_p
}
C {ipin.sym} 880 -530 0 1 {name=p2 lab=V_in_n
}
C {ipin.sym} 660 -580 1 0 {name=p6 lab=VSS}
C {iopin.sym} 660 -380 1 0 {name=p5 lab=I_bias

}
C {iopin.sym} 540 -660 3 0 {name=p3 lab=I_out_p
}
C {iopin.sym} 780 -660 3 0 {name=p4 lab=I_out_n
}
