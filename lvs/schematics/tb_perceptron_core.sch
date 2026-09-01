v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 660 -160 660 -100 {lab=0}
N 660 -160 880 -160 {lab=0}
N 830 -390 940 -390 {lab=V_out_perceptron}
N 210 -160 290 -160 {lab=0}
N 420 -160 660 -160 {lab=0}
N 290 -160 420 -160 {lab=0}
N 140 -160 210 -160 {lab=0}
N 140 -440 140 -220 {lab=#net1}
N 140 -440 530 -440 {lab=#net1}
N 210 -420 530 -420 {lab=#net2}
N 210 -420 210 -220 {lab=#net2}
N 290 -400 290 -220 {lab=#net3}
N 290 -400 530 -400 {lab=#net3}
N 360 -380 530 -380 {lab=#net4}
N 360 -380 360 -220 {lab=#net4}
N 430 -360 430 -220 {lab=#net5}
N 430 -360 530 -360 {lab=#net5}
N 500 -340 530 -340 {lab=#net6}
N 500 -340 500 -220 {lab=#net6}
N 730 -310 730 -160 {lab=0}
N 730 -470 880 -470 {lab=#net7}
N 880 -470 880 -220 {lab=#net7}
C {vsource.sym} 880 -190 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 660 -100 0 0 {name=l1 lab=0}
C {lab_pin.sym} 940 -390 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {isource.sym} 290 -190 0 0 {name=I_X1 value=25u}
C {isource.sym} 430 -190 0 0 {name=I_X2 value=25u
}
C {vsource.sym} 210 -190 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 500 -190 0 0 {name=V_W2 value=1.65 savecurrent=false}
C {vsource.sym} 360 -190 0 0 {name=V_B value=1.65 savecurrent=false}
C {code.sym} 190 -640 0 0 {name=COMMANDS
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/perceptron_graph1_weights.txt v(V_out_perceptron)
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/perceptron_graph2_sensors.txt v(V_out_perceptron)
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/perceptron_graph3_bias.txt v(V_out_perceptron)
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/perceptron_graph4_vshift.txt v(V_out_perceptron)
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/3d_sensors.txt v(V_out_perceptron)
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
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/3d_weights.txt v(V_out_perceptron)
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
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_perceptron_chain.txt v(V_out_perceptron) @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  alter V_W1 = 1.65
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 0
  alter I_X2 = 0
  * === OP-SWEEP DIAGNOSTIC #2: all devices.
  alter V_W1 = 1.85
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 25u
  save all @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  dc I_X2 0 50u 1u
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_perceptron_chain_ix2.txt v(V_out_perceptron) @m.x1.x1.xm1.m0[vgs] @m.x1.x1.xm1.m0[vth] @m.x1.x1.xm1.m0[id] @m.x1.x2.xm1.m0[vgs] @m.x1.x2.xm1.m0[vth] @m.x1.x2.xm1.m0[id] @m.x1.x_g1.xm7.m0[vgs] @m.x1.x_g1.xm7.m0[vth] @m.x1.x_g1.xm7.m0[id] @m.x1.x_g2.xm7.m0[vgs] @m.x1.x_g2.xm7.m0[vth] @m.x1.x_g2.xm7.m0[id] @m.x1.x_g3.xm7.m0[vgs] @m.x1.x_g3.xm7.m0[vth] @m.x1.x_g3.xm7.m0[id] @m.x1.x_tanh.xm1.m0[vgs] @m.x1.x_tanh.xm1.m0[vth] @m.x1.x_tanh.xm1.m0[id] @m.x1.x_tanh.xm2.m0[vgs] @m.x1.x_tanh.xm2.m0[vth] @m.x1.x_tanh.xm2.m0[id]
  alter V_W1 = 1.65
  alter V_W2 = 1.65
  alter V_B  = 1.65
  alter I_X1 = 0
  alter I_X2 = 0
.endc
"}
C {devices/code_shown.sym} 340 -630 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
* .lib $::180MCU_MODELS/sm141064.ngspice res_statistical
"}
C {vsource.sym} 140 -190 0 0 {name=V_Shift value=3.3 savecurrent=false}
C {title.sym} 160 0 0 0 {name=l2 author="Guru Charan"}
C {analog-perceptron-gf180mcu/lvs/schematics/perceptron_core.sym} 680 -390 0 0 {name=x1}
