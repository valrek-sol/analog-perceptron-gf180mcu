v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 -120 460 -60 {lab=0}
N 460 -120 680 -120 {lab=0}
N 680 -380 680 -180 {lab=#net1}
N 630 -380 680 -380 {lab=#net1}
N 770 -360 770 -180 {lab=#net2}
N 630 -360 770 -360 {lab=#net2}
N 630 -340 840 -340 {lab=#net3}
N 840 -340 840 -180 {lab=#net3}
N 630 -320 920 -320 {lab=#net4}
N 920 -320 920 -180 {lab=#net4}
N 1000 -300 1000 -180 {lab=#net5}
N 630 -300 1000 -300 {lab=#net5}
N 630 -280 1080 -280 {lab=#net6}
N 1080 -280 1080 -180 {lab=#net6}
N 1000 -120 1080 -120 {lab=0}
N 920 -120 1000 -120 {lab=0}
N 840 -120 920 -120 {lab=0}
N 770 -120 840 -120 {lab=0}
N 680 -120 770 -120 {lab=0}
N 630 -260 1120 -260 {lab=V_out_perceptron}
N 630 -240 640 -240 {lab=0}
N 640 -240 640 -120 {lab=0}
N 1120 -260 1220 -260 {lab=V_out_perceptron}
N 1160 -400 1160 -180 {lab=#net7}
N 630 -400 1160 -400 {lab=#net7}
N 1080 -120 1160 -120 {lab=0}
N 10 -120 90 -120 {lab=0}
N 220 -120 460 -120 {lab=0}
N 90 -380 90 -180 {lab=#net8}
N 90 -380 200 -380 {lab=#net8}
N 10 -400 200 -400 {lab=#net9}
N 10 -400 10 -180 {lab=#net9}
N 90 -120 220 -120 {lab=0}
N 200 -380 330 -380 {lab=#net8}
N 200 -400 330 -400 {lab=#net9}
N 160 -360 160 -180 {lab=#net10}
N 160 -360 330 -360 {lab=#net10}
N 230 -340 330 -340 {lab=#net11}
N 230 -340 230 -180 {lab=#net11}
N 300 -320 300 -180 {lab=#net12}
N 300 -320 330 -320 {lab=#net12}
C {analog-perceptron-gf180mcu/schematics/perceptron.sym} 480 -320 0 0 {name=x1}
C {vsource.sym} 680 -150 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {gnd.sym} 460 -60 0 0 {name=l1 lab=0}
C {vsource.sym} 770 -150 0 0 {name=V1 value=1 savecurrent=false}
C {vsource.sym} 840 -150 0 0 {name=V2 value=1.25 savecurrent=false}
C {vsource.sym} 920 -150 0 0 {name=V3 value=1.65 savecurrent=false}
C {vsource.sym} 1000 -150 0 0 {name=V4 value=1.15 savecurrent=false}
C {vsource.sym} 1080 -150 0 0 {name=V5 value=1.8 savecurrent=false}
C {lab_pin.sym} 1220 -260 2 0 {name=p1 sig_type=std_logic lab=V_out_perceptron}
C {vsource.sym} 1160 -150 0 0 {name=V6 value=0.7 savecurrent=false}
C {isource.sym} 10 -150 0 0 {name=I_X1 value=20u}
C {isource.sym} 90 -150 0 0 {name=I_X2 value=20u}
C {vsource.sym} 160 -150 0 0 {name=V_W1 value=1.85 savecurrent=false}
C {vsource.sym} 230 -150 0 0 {name=V_W2 value=1.85 savecurrent=false}
C {vsource.sym} 300 -150 0 0 {name=V_B value=1.65 savecurrent=false}
C {code.sym} 910 -600 0 0 {name=COMMANDS
value="
.control
  * --- UI THEME OVERRIDES ---
  set color0=white
  set color1=black
  set xbrushwidth=2

  * ==========================================
  * GRAPH 1: Weights (Inhibitive to Excitatory)
  * ==========================================
  alter I_X2 = 0
  alter V_W2 = 1.65
  alter V_B = 1.65
  * Sweep Sensor 1, Step Weight 1 (-200mV, 0mV, +200mV)
  dc I_X1 0 50u 1u V_W1 1.45 1.85 0.2
  set title=\\"Graph 1: Weight Sweep (Inhibitory, Neutral, Excitatory)\\"
  plot v(V_out_perceptron)

  * ==========================================
  * GRAPH 2: Sensor Interference
  * ==========================================
  alter V_W1 = 1.85
  alter V_W2 = 1.85
  alter V_B = 1.65
  * Both weights strongly positive. Sweep X1, Step X2 (0, 25u, 50u)
  dc I_X1 0 50u 1u I_X2 0 50u 25u
  set title=\\"Graph 2: Sensor 1 vs Sensor 2 Interference\\"
  plot v(V_out_perceptron)

  * ==========================================
  * GRAPH 3: Bias Shifting
  * ==========================================
  alter I_X2 = 0
  alter V_W1 = 1.85
  * Sensor 1 sweeping, Weight 1 positive, Step Bias
  dc I_X1 0 50u 1u V_B 1.45 1.85 0.2
  set title=\\"Graph 3: Bias shifting the S-Curve horizontally\\"
  plot v(V_out_perceptron)

  * ==========================================
  * 3D DATA GENERATION (Silent Export)
  * ==========================================
  * 3D Plot A: X = Sensor 1, Y = Sensor 2, Z = Output
  alter V_W1 = 1.85
  alter V_W2 = 1.85
  alter V_B = 1.65
  dc I_X1 0 50u 1u I_X2 0 50u 2u
  wrdata /foss/designs/analog-perceptron-gf180mcu/schematics/3d_sensors.txt v(V_out_perceptron)

  * 3D Plot B: X = Weight 1, Y = Weight 2, Z = Output
  alter I_X1 = 50u
  alter I_X2 = 50u
  alter V_B = 1.65
  dc V_W1 1.45 1.85 0.01 V_W2 1.45 1.85 0.02
  wrdata /foss/designs/analog-perceptron-gf180mcu/schematics/3d_weights.txt v(V_out_perceptron)
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
