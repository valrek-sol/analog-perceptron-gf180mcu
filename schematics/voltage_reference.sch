v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 100 -560 100 -520 {lab=v_1_65}
N 100 -460 100 -420 {lab=v_1_2_5}
N 100 -360 100 -320 {lab=v_1_15}
N 100 -260 100 -220 {lab=v_0_7}
N 60 -590 80 -590 {lab=VSS}
N 60 -590 60 -490 {lab=VSS}
N 60 -490 80 -490 {lab=VSS}
N 60 -490 80 -490 {lab=VSS}
N 60 -490 60 -390 {lab=VSS}
N 60 -390 80 -390 {lab=VSS}
N 60 -390 80 -390 {lab=VSS}
N 60 -390 60 -290 {lab=VSS}
N 60 -290 80 -290 {lab=VSS}
N 60 -290 80 -290 {lab=VSS}
N 60 -290 60 -190 {lab=VSS}
N 60 -190 80 -190 {lab=VSS}
N 60 -190 80 -190 {lab=VSS}
N 60 -190 60 -160 {lab=VSS}
N 60 -160 100 -160 {lab=VSS}
N 100 -540 200 -540 {lab=v_1_65}
N 100 -440 200 -440 {lab=v_1_2_5}
N 100 -340 200 -340 {lab=v_1_15}
N 100 -240 200 -240 {lab=v_0_7}
C {symbols/ppolyf_u_1k.sym} 100 -590 0 0 {name=R1
W=1.5e-6
L=11.98e-6
model=ppolyf_u_1k
spiceprefix=X
m=24}
C {symbols/ppolyf_u_1k.sym} 100 -490 0 0 {name=R2
W=1.5e-6
L=2.78e-6
model=ppolyf_u_1k
spiceprefix=X
m=24}
C {symbols/ppolyf_u_1k.sym} 100 -390 0 0 {name=R3
W=1.5e-6
L=0.57e-6
model=ppolyf_u_1k
spiceprefix=X
m=24}
C {symbols/ppolyf_u_1k.sym} 100 -290 0 0 {name=R4
W=1.5e-6
L=3.15e-6
model=ppolyf_u_1k
spiceprefix=X
m=24}
C {symbols/ppolyf_u_1k.sym} 100 -190 0 0 {name=R5
W=1.5e-6
L=4.99e-6
model=ppolyf_u_1k
spiceprefix=X
m=24}
C {iopin.sym} 100 -620 3 0 {name=p1 lab=VDD}
C {iopin.sym} 100 -160 1 0 {name=p2 lab=VSS}
C {opin.sym} 200 -540 0 0 {name=p3 lab=v_1_65}
C {opin.sym} 200 -440 0 0 {name=p4 lab=v_1_2_5}
C {opin.sym} 200 -340 0 0 {name=p5 lab=v_1_15}
C {opin.sym} 200 -240 0 0 {name=p6 lab=v_0_7}
