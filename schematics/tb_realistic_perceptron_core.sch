v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 760 -150 760 -90 {lab=0}
N 760 -150 980 -150 {lab=0}
N 930 -380 1140 -380 {lab=V_out_perceptron}
N 200 -150 280 -150 {lab=0}
N 520 -150 760 -150 {lab=0}
N 280 -150 520 -150 {lab=0}
N 130 -150 200 -150 {lab=0}
N 130 -430 130 -210 {lab=#net1}
N 130 -430 630 -430 {lab=#net1}
N 200 -410 630 -410 {lab=#net2}
N 200 -410 200 -210 {lab=#net2}
N 280 -390 280 -210 {lab=#net3}
N 280 -390 630 -390 {lab=#net3}
N 400 -370 630 -370 {lab=#net4}
N 400 -370 400 -210 {lab=#net4}
N 480 -350 480 -210 {lab=#net5}
N 480 -350 630 -350 {lab=#net5}
N 600 -330 630 -330 {lab=#net6}
N 600 -330 600 -210 {lab=#net6}
N 980 -150 1080 -150 {lab=0}
N 1080 -150 1150 -150 {lab=0}
N 830 -300 830 -150 {lab=0}
N 980 -210 1150 -210 {lab=#net7}
N 980 -460 980 -210 {lab=#net7}
N 830 -460 980 -460 {lab=#net7}
N 480 -210 540 -210 {lab=#net5}
N 280 -210 340 -210 {lab=#net3}
C {vsource.sym} 980 -180 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 760 -90 0 0 {name=l1 lab=0}
C {lab_pin.sym} 1140 -380 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {code.sym} 400 -630 0 0 {name=COMMANDS
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
  alter @I_X1[pulse] = [ 0 0 0 0 0 0 0 ] $ Clear pulse after tran

  * === AC Analysis (Stability & Bandwidth) ===
  * Injecting AC signal into I_X1
  alter I_X1 = 25u
  alter @I_X1[acmag] = 1
  alter V_W1 = 1.85
  ac dec 20 1 1G
  * wrdata exports real and imaginary parts for AC.
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_ac_perceptron.txt v(V_out_perceptron)
  alter @I_X1[acmag] = 0 $ Clear AC magnitude
  alter I_X1 = 0

  * === Return to global environment before loops ===
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
  save all @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  dc I_X1 0 50u 1u
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_opsweep_perceptron_chain.txt v(V_out_perceptron) @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
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
  save all @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  dc I_X2 0 50u 1u
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_opsweep_perceptron_chain_ix2.txt v(V_out_perceptron) @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
.endc
"}
C {devices/code_shown.sym} 640 -620 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_statistical
.temp 27
"}
C {vsource.sym} 130 -180 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {capa.sym} 540 -180 0 0 {name=Cs1
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 340 -180 0 0 {name=Cs2
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1080 -180 0 0 {name=Cl
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 1150 -180 0 0 {name=Rl
value=1M
footprint=1206
device=resistor
m=1}
C {analog-perceptron-gf180mcu/schematics/perceptron_core.sym} 780 -380 0 0 {name=x1}
C {isource.sym} 280 -180 0 0 {name=I_X1 value=25u}
C {isource.sym} 480 -180 0 0 {name=I_X2 value=25u
}
C {vsource.sym} 200 -180 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 600 -180 0 0 {name=V_W2 value=1.65 savecurrent=false}
C {vsource.sym} 400 -180 0 0 {name=V_B value=1.65 savecurrent=false}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
