v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 -120 460 -60 {lab=0}
N 460 -120 680 -120 {lab=0}
N 630 -380 840 -380 {lab=V_out_perceptron}
N 10 -120 90 -120 {lab=0}
N 220 -120 460 -120 {lab=0}
N 90 -120 220 -120 {lab=0}
N -60 -120 10 -120 {lab=0}
N -60 -400 -60 -180 {lab=#net1}
N -60 -400 330 -400 {lab=#net1}
N 10 -380 330 -380 {lab=#net2}
N 10 -380 10 -180 {lab=#net2}
N 90 -360 90 -180 {lab=#net3}
N 90 -360 330 -360 {lab=#net3}
N 160 -340 330 -340 {lab=#net4}
N 160 -340 160 -180 {lab=#net4}
N 230 -320 230 -180 {lab=#net5}
N 230 -320 330 -320 {lab=#net5}
N 300 -300 330 -300 {lab=#net6}
N 300 -300 300 -180 {lab=#net6}
N 630 -400 680 -400 {lab=#net7}
N 680 -400 680 -180 {lab=#net7}
N 630 -360 640 -360 {lab=0}
N 640 -360 640 -120 {lab=0}
N 10 -300 40 -270 {lab=#net2}
N 90 -300 120 -270 {lab=#net3}
N 120 -210 140 -120 {lab=0}
N 40 -210 60 -120 {lab=0}
N 680 -120 780 -120 {lab=0}
N 680 -220 780 -180 {lab=#net7}
N 780 -120 850 -120 {lab=0}
N 680 -220 850 -180 {lab=#net7}
C {vsource.sym} 680 -150 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 460 -60 0 0 {name=l1 lab=0}
C {lab_pin.sym} 840 -380 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {isource.sym} 10 -150 0 0 {name=I_X1 value=25u}
C {isource.sym} 90 -150 0 0 {name=I_X2 value=25u
}
C {vsource.sym} 160 -150 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 230 -150 0 0 {name=V_W2 value=1.65 savecurrent=false}
C {vsource.sym} 300 -150 0 0 {name=V_B value=1.65 savecurrent=false}
C {code.sym} 910 -600 0 0 {name=COMMANDS
value="
.control
  * --- start from neutral ---
  alter V_W1 = 1.65
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 0
  alter I_X2 = 0
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
  * === OP-SWEEP DIAGNOSTIC #2: all devices, I_X2 swept,
  *     I_X1 held at mid-scale (25uA) so TIA1 stays validly biased too,
  *     and TIA2 actually carries current for once ===
  alter V_W1 = 1.85
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 25u
  save all @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  dc I_X2 0 50u 1u
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/real_opsweep_perceptron_chain_ix2.txt v(V_out_perceptron) @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  alter V_W1 = 1.65
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 0
  alter I_X2 = 0
.endc
"}
C {devices/code_shown.sym} 340 -590 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {vsource.sym} -60 -150 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {analog-perceptron-gf180mcu/schematics/perceptron.sym} 480 -350 0 0 {name=x1}
C {capa.sym} 40 -240 0 0 {name=Cs1
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 120 -240 0 0 {name=Cs2
m=1
value=70p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 780 -150 0 0 {name=Cl
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 850 -150 0 0 {name=Rl
value=1M
footprint=1206
device=resistor
m=1}
