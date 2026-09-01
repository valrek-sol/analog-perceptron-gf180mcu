v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 760 -150 760 -90 {lab=0}
N 760 -150 1290 -150 {lab=0}
N -460 -150 -250 -150 {lab=0}
N 120 -150 760 -150 {lab=0}
N -250 -150 120 -150 {lab=0}
N -680 -150 -460 -150 {lab=0}
N 830 -300 830 -150 {lab=0}
N -250 -210 -190 -210 {lab=#net1}
N 220 -210 280 -210 {lab=#net2}
N 1290 -150 1430 -150 {lab=0}
N 1430 -150 1500 -150 {lab=0}
N 830 -460 1290 -460 {lab=#net3}
N 1290 -460 1290 -410 {lab=#net3}
N 1430 -210 1500 -210 {lab=V_out_perceptron}
N 1210 -330 1210 -290 {lab=#net4}
N 1210 -290 1210 -210 {lab=#net4}
N 1210 -210 1290 -210 {lab=#net4}
N 1370 -330 1370 -290 {lab=0}
N 1370 -290 1370 -150 {lab=0}
N 930 -380 1450 -380 {lab=V_out_perceptron}
N 1430 -380 1430 -210 {lab=V_out_perceptron}
N -760 -330 -760 -290 {lab=#net5}
N -540 -330 -540 -290 {lab=#net6}
N -330 -330 -330 -290 {lab=#net6}
N -170 -330 -170 -290 {lab=0}
N -600 -330 -600 -150 {lab=0}
N -380 -330 -380 -150 {lab=0}
N -170 -290 -170 -150 {lab=0}
N 90 -330 90 -150 {lab=0}
N 300 -330 300 -150 {lab=0}
N 520 -330 520 -150 {lab=0}
N 440 -410 520 -410 {lab=#net7}
N 520 -410 520 -340 {lab=#net7}
N 520 -340 540 -340 {lab=#net7}
N 540 -340 540 -330 {lab=#net7}
N 540 -330 630 -330 {lab=#net7}
N 540 -350 630 -350 {lab=#net8}
N 540 -420 540 -350 {lab=#net8}
N 220 -420 540 -420 {lab=#net8}
N 220 -420 220 -410 {lab=#net8}
N 550 -370 630 -370 {lab=#net9}
N 550 -430 550 -370 {lab=#net9}
N 10 -430 550 -430 {lab=#net9}
N 10 -430 10 -410 {lab=#net9}
N 560 -390 630 -390 {lab=#net10}
N 560 -440 560 -390 {lab=#net10}
N -250 -440 -250 -410 {lab=#net10}
N -250 -440 560 -440 {lab=#net10}
N 570 -410 630 -410 {lab=#net11}
N 570 -450 570 -410 {lab=#net11}
N -460 -450 -460 -410 {lab=#net11}
N -460 -450 570 -450 {lab=#net11}
N 580 -430 630 -430 {lab=#net12}
N 580 -460 580 -430 {lab=#net12}
N -680 -460 -680 -410 {lab=#net12}
N -680 -460 580 -460 {lab=#net12}
N -70 -330 -70 -290 {lab=#net6}
N 140 -330 140 -290 {lab=#net4}
N 360 -330 360 -290 {lab=#net4}
N 360 -320 1210 -320 {lab=#net4}
N 140 -320 360 -320 {lab=#net4}
N -70 -320 130 -320 {lab=#net6}
N -330 -320 -70 -320 {lab=#net6}
N -540 -320 -330 -320 {lab=#net6}
N -760 -320 -550 -320 {lab=#net5}
C {code.sym} 200 -590 0 0 {name=COMMANDS
value="
.control

* --- start from neutral ---
alter V_W1 = 1.65
alter V_W2 = 1.65
alter V_B  = 1.65
alter I_X1 = 0
alter I_X2 = 0
* === Transient Analysis ===
* Applying a 50uA pulse to I_X1 to observe step response and settling
alter @I_X1[pulse] = [ 0 50u 1u 10n 10n 10u 20u ]
alter I_X2 = 0
alter V_W1 = 1.85
alter V_W2 = 1.65
alter V_B  = 1.65
tran 10n 30u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_tran_perceptron.txt v(V_out_perceptron)
destroy all
alter @I_X1[pulse] = [ 0 0 0 0 0 0 0 ] $ Clear pulse after tran
* === AC Analysis (Stability & Bandwidth) ===
* Injecting AC signal into I_X1
alter I_X1 = 25u
alter @I_X1[acmag] = 1
alter V_W1 = 1.85
ac dec 20 1 1G
* wrdata exports real and imaginary parts for AC.
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_ac_perceptron.txt v(V_out_perceptron)
destroy all
alter @I_X1[acmag] = 0 $ Clear AC magnitude
alter I_X1 = 0
* === Return to global environment before loops ===
reset
setplot const
* === Graph 1: Weight sweep (inhibitory / neutral / excitatory) ===
alter I_X2 = 0
alter V_W2 = 1.65
alter V_B  = 1.65
let n = 0
dowhile n <= 2
let vw1 = 1.45 + n * 0.2
alter V_W1 = vw1
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_perceptron_graph1_weights.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_W1 = 1.65
* === Graph 2: Sensor 1 sweep, Sensor 2 interference ===
alter V_W1 = 1.85
alter V_W2 = 1.85
alter V_B  = 1.65
let n = 0
dowhile n <= 2
let ix2 = n * 25u
alter I_X2 = ix2
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_perceptron_graph2_sensors.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_W1 = 1.65
alter V_W2 = 1.65
alter I_X2 = 0
* === Graph 3: Bias shifting ===
alter I_X2 = 0
alter V_W1 = 1.85
let n = 0
dowhile n <= 2
let vb = 1.45 + n * 0.2
alter V_B = vb
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_perceptron_graph3_bias.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_W1 = 1.65
alter V_B  = 1.65
* === Graph 4: V_Shift sweep (reference-rail sensitivity / corner check) ===
alter I_X2 = 0
alter V_W1 = 1.85
alter V_B  = 1.65
let n = 0
dowhile n <= 5
let vshift = 3.25 + n * 0.02
alter V_Shift = vshift
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_perceptron_graph4_vshift.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_Shift = 3.3
alter V_W1 = 1.65
* === 3D Dataset A: I_X1 x I_X2 -> V_out ===
alter V_W1 = 1.85
alter V_W2 = 1.85
alter V_B  = 1.65
let n = 0
dowhile n <= 25
let ix2b = n * 2u
alter I_X2 = ix2b
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_3d_sensors.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_W1 = 1.65
alter V_W2 = 1.65
alter I_X2 = 0
* === 3D Dataset B: V_W1 x V_W2 -> V_out ===
alter I_X1 = 50u
alter I_X2 = 50u
alter V_B  = 1.65
let n = 0
dowhile n <= 20
let vw2 = 1.45 + n * 0.02
alter V_W2 = vw2
dc V_W1 1.45 1.85 0.01
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_3d_weights.txt v(V_out_perceptron)
destroy all
set appendwrite
let n = n + 1
end
unset appendwrite
alter V_W1 = 1.65
alter V_W2 = 1.65
alter V_B  = 1.65
alter I_X1 = 0
alter I_X2 = 0
* === OP-SWEEP DIAGNOSTIC: all devices ===
alter V_W1 = 1.85
alter V_W2 = 1.65
alter V_B  = 1.65
alter I_X2 = 0
save all @m.x1.x1.x1.xm1.m0[vgs] @m.x1.x1.x1.xm1.m0[vth] @m.x1.x1.x1.xm1.m0[id] @m.x1.x1.x2.xm1.m0[vgs] @m.x1.x1.x2.xm1.m0[vth] @m.x1.x1.x2.xm1.m0[id] @m.x1.x1.x_g1.xm7.m0[vgs] @m.x1.x1.x_g1.xm7.m0[vth] @m.x1.x1.x_g1.xm7.m0[id] @m.x1.x1.x_g2.xm7.m0[vgs] @m.x1.x1.x_g2.xm7.m0[vth] @m.x1.x1.x_g2.xm7.m0[id] @m.x1.x1.x_g3.xm7.m0[vgs] @m.x1.x1.x_g3.xm7.m0[vth] @m.x1.x1.x_g3.xm7.m0[id] @m.x1.x1.x_tanh.xm1.m0[vgs] @m.x1.x1.x_tanh.xm1.m0[vth] @m.x1.x1.x_tanh.xm1.m0[id] @m.x1.x1.x_tanh.xm2.m0[vgs] @m.x1.x1.x_tanh.xm2.m0[vth] @m.x1.x1.x_tanh.xm2.m0[id]
dc I_X1 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_opsweep_perceptron_chain.txt v(V_out_perceptron) @m.x1.x1.x1.xm1.m0[vgs] @m.x1.x1.x1.xm1.m0[vth] @m.x1.x1.x1.xm1.m0[id] @m.x1.x1.x2.xm1.m0[vgs] @m.x1.x1.x2.xm1.m0[vth] @m.x1.x1.x2.xm1.m0[id] @m.x1.x1.x_g1.xm7.m0[vgs] @m.x1.x1.x_g1.xm7.m0[vth] @m.x1.x1.x_g1.xm7.m0[id] @m.x1.x1.x_g2.xm7.m0[vgs] @m.x1.x1.x_g2.xm7.m0[vth] @m.x1.x1.x_g2.xm7.m0[id] @m.x1.x1.x_g3.xm7.m0[vgs] @m.x1.x1.x_g3.xm7.m0[vth] @m.x1.x1.x_g3.xm7.m0[id] @m.x1.x1.x_tanh.xm1.m0[vgs] @m.x1.x1.x_tanh.xm1.m0[vth] @m.x1.x1.x_tanh.xm1.m0[id] @m.x1.x1.x_tanh.xm2.m0[vgs] @m.x1.x1.x_tanh.xm2.m0[vth] @m.x1.x1.x_tanh.xm2.m0[id]
destroy all
alter V_W1 = 1.65
alter V_W2 = 1.65
alter V_B  = 1.65
alter I_X1 = 0
alter I_X2 = 0
* === OP-SWEEP DIAGNOSTIC #2: all devices, I_X2 swept ===
alter V_W1 = 1.85
alter V_W2 = 1.65
alter V_B  = 1.65
alter I_X1 = 25u
save all @m.x1.x1.x1.xm1.m0[vgs] @m.x1.x1.x1.xm1.m0[vth] @m.x1.x1.x1.xm1.m0[id] @m.x1.x1.x2.xm1.m0[vgs] @m.x1.x1.x2.xm1.m0[vth] @m.x1.x1.x2.xm1.m0[id] @m.x1.x1.x_g1.xm7.m0[vgs] @m.x1.x1.x_g1.xm7.m0[vth] @m.x1.x1.x_g1.xm7.m0[id] @m.x1.x1.x_g2.xm7.m0[vgs] @m.x1.x1.x_g2.xm7.m0[vth] @m.x1.x1.x_g2.xm7.m0[id] @m.x1.x1.x_g3.xm7.m0[vgs] @m.x1.x1.x_g3.xm7.m0[vth] @m.x1.x1.x_g3.xm7.m0[id] @m.x1.x1.x_tanh.xm1.m0[vgs] @m.x1.x1.x_tanh.xm1.m0[vth] @m.x1.x1.x_tanh.xm1.m0[id] @m.x1.x1.x_tanh.xm2.m0[vgs] @m.x1.x1.x_tanh.xm2.m0[vth] @m.x1.x1.x_tanh.xm2.m0[id]
dc I_X2 0 50u 1u
wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_opsweep_perceptron_chain_ix2.txt v(V_out_perceptron) @m.x1.x1.x1.xm1.m0[vgs] @m.x1.x1.x1.xm1.m0[vth] @m.x1.x1.x1.xm1.m0[id] @m.x1.x1.x2.xm1.m0[vgs] @m.x1.x1.x2.xm1.m0[vth] @m.x1.x1.x2.xm1.m0[id] @m.x1.x1.x_g1.xm7.m0[vgs] @m.x1.x1.x_g1.xm7.m0[vth] @m.x1.x1.x_g1.xm7.m0[id] @m.x1.x1.x_g2.xm7.m0[vgs] @m.x1.x1.x_g2.xm7.m0[vth] @m.x1.x1.x_g2.xm7.m0[id] @m.x1.x1.x_g3.xm7.m0[vgs] @m.x1.x1.x_g3.xm7.m0[vth] @m.x1.x1.x_g3.xm7.m0[id] @m.x1.x1.x_tanh.xm1.m0[vgs] @m.x1.x1.x_tanh.xm1.m0[vth] @m.x1.x1.x_tanh.xm1.m0[id] @m.x1.x1.x_tanh.xm2.m0[vgs] @m.x1.x1.x_tanh.xm2.m0[vth] @m.x1.x1.x_tanh.xm2.m0[id]
destroy all
.endc
"}
C {vsource.sym} 1290 -180 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 760 -90 0 0 {name=l1 lab=0}
C {lab_pin.sym} 1450 -380 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {vsource.sym} -680 -180 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {isource.sym} -250 -180 0 0 {name=I_X1 value=25u}
C {isource.sym} 220 -180 0 0 {name=I_X2 value=25u
}
C {vsource.sym} -460 -180 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 440 -180 0 0 {name=V_W2 value=1.65 savecurrent=false}
C {vsource.sym} 10 -180 0 0 {name=V_B value=1.65 savecurrent=false}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
C {devices/code_shown.sym} 360 -630 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice diode_typical
.lib $::180MCU_MODELS/sm141064.ngspice moscap_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.include /foss/designs/analog-perceptron-gf180mcu/schematics/gf180mcu_fd_io__asig_5p0_extracted.spice
"}
C {capa.sym} -190 -180 0 0 {name=Cs2
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 280 -180 0 0 {name=Cs1
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1430 -180 0 0 {name=Cl
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 1500 -180 0 0 {name=Rl
value=1M
footprint=1206
device=resistor
m=1}
C {analog-perceptron-gf180mcu/schematics/perceptron.sym} 780 -380 0 0 {name=x1}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} 1370 -210 3 0 {name=IO1
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} 520 -210 3 0 {name=IO2
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} 300 -210 3 0 {name=IO3
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} 90 -210 3 0 {name=IO4
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} -170 -210 3 0 {name=IO5
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} -380 -210 3 0 {name=IO6
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_asig_5p0.sym} -600 -210 3 0 {name=IO7
model=gf180mcu_fd_io__asig_5p0_extracted
spiceprefix=X
}
