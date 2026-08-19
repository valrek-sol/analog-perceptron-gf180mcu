v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -310 20 -160 {lab=#net1}
N 20 -310 410 -310 {lab=#net1}
N 100 -290 410 -290 {lab=#net2}
N 100 -290 100 -160 {lab=#net2}
N 180 -270 180 -160 {lab=#net3}
N 180 -270 410 -270 {lab=#net3}
N 250 -250 410 -250 {lab=#net4}
N 250 -250 250 -160 {lab=#net4}
N 20 -100 180 -100 {lab=0}
N 180 -70 180 -40 {lab=0}
N 180 -70 740 -70 {lab=0}
N 740 -70 940 -70 {lab=0}
N 940 -110 940 -70 {lab=0}
N 940 -190 940 -170 {lab=#net5}
N 940 -310 940 -260 {lab=V_o_p}
N 710 -310 940 -310 {lab=V_o_p}
N 800 -290 800 -260 {lab=V_o_n}
N 710 -290 800 -290 {lab=V_o_n}
N 800 -200 800 -190 {lab=#net5}
N 800 -190 940 -190 {lab=#net5}
N 910 -230 920 -230 {lab=0}
N 910 -230 910 -170 {lab=0}
N 770 -170 910 -170 {lab=0}
N 770 -230 770 -170 {lab=0}
N 770 -230 780 -230 {lab=0}
N 180 -100 180 -70 {lab=0}
N 940 -200 940 -190 {lab=#net5}
N 180 -100 250 -100 {lab=0}
N 710 -270 710 -230 {lab=0}
N 710 -230 770 -230 {lab=0}
N 840 -170 840 -70 {lab=0}
N 250 -100 320 -100 {lab=0}
N 320 -230 320 -160 {lab=#net6}
N 320 -230 410 -230 {lab=#net6}
C {vsource.sym} 180 -130 0 0 {name=V_X_P value=1.25 savecurrent=false}
C {vsource.sym} 250 -130 0 0 {name=V_X_N value=1.15 savecurrent=false}
C {vsource.sym} 20 -130 0 0 {name=V_W_P value=1.65 savecurrent=false}
C {vsource.sym} 100 -130 0 0 {name=V_W_N value=1.65 savecurrent=false}
C {gnd.sym} 180 -40 0 0 {name=l1 lab=0}
C {code.sym} 220 -510 0 0 {name=COMMANDS
value="
.control
  op
  echo \\"--- Gilbert cell x1: transistor op points ---\\"
  print @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds]
  print @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds]
  print @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds]
  print @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds]
  print @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds]
  print @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds]
  print @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds]
  print @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  echo \\"--- Gilbert cell x1: tail resistor ---\\"
  print @r.x1.xr1.rt1[resistance] @r.x1.xr1.rt2[resistance]
  * === Single sweep: baseline transfer curve ===
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  dc V_W_P 1.15 2.15 0.01
  let V_diff_single = v(V_o_p) - v(V_o_n)
  plot V_diff_single title \\"Gilbert Multiplier: Single Weight Sweep\\"
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_single_sweep.txt V_diff_single

  setplot const
  * === Family of curves, one clean sweep per V_X_P step ===
  let n = 0
  dowhile n <= 4
    let vxp = 1.05 + n * 0.05
    alter V_X_P = vxp
    dc V_W_P 1.15 2.15 0.01
    let V_diff_fam = v(V_o_p) - v(V_o_n)
    wrdata /foss/designs/analog-perceptron-gf180mcu/plots/gilbert_family_sweep.txt V_diff_fam
    set appendwrite
    let n = n + 1
  end
  unset appendwrite

  alter V_X_P = 1.25
  alter V_X_N = 1.15
  alter V_W_P = 1.65
  * === OP-SWEEP DIAGNOSTIC: all 8 devices' headroom across full weight range ===
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  save all @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds] @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds] @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds] @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  dc V_W_P 1.15 2.15 0.01
  wrdata /foss/designs/analog-perceptron-gf180mcu/plots/opsweep_gilbert.txt v(V_o_p) v(V_o_n) @m.x1.xm1.m0[vgs] @m.x1.xm1.m0[vth] @m.x1.xm1.m0[vdsat] @m.x1.xm1.m0[id] @m.x1.xm1.m0[gm] @m.x1.xm1.m0[gds] @m.x1.xm2.m0[vgs] @m.x1.xm2.m0[vth] @m.x1.xm2.m0[vdsat] @m.x1.xm2.m0[id] @m.x1.xm2.m0[gm] @m.x1.xm2.m0[gds] @m.x1.xm3.m0[vgs] @m.x1.xm3.m0[vth] @m.x1.xm3.m0[vdsat] @m.x1.xm3.m0[id] @m.x1.xm3.m0[gm] @m.x1.xm3.m0[gds] @m.x1.xm4.m0[vgs] @m.x1.xm4.m0[vth] @m.x1.xm4.m0[vdsat] @m.x1.xm4.m0[id] @m.x1.xm4.m0[gm] @m.x1.xm4.m0[gds] @m.x1.xm5.m0[vgs] @m.x1.xm5.m0[vth] @m.x1.xm5.m0[vdsat] @m.x1.xm5.m0[id] @m.x1.xm5.m0[gm] @m.x1.xm5.m0[gds] @m.x1.xm6.m0[vgs] @m.x1.xm6.m0[vth] @m.x1.xm6.m0[vdsat] @m.x1.xm6.m0[id] @m.x1.xm6.m0[gm] @m.x1.xm6.m0[gds] @m.x1.xm7.m0[vgs] @m.x1.xm7.m0[vth] @m.x1.xm7.m0[vdsat] @m.x1.xm7.m0[id] @m.x1.xm7.m0[gm] @m.x1.xm7.m0[gds] @m.x1.xm8.m0[vgs] @m.x1.xm8.m0[vth] @m.x1.xm8.m0[vdsat] @m.x1.xm8.m0[id] @m.x1.xm8.m0[gm] @m.x1.xm8.m0[gds]
  alter V_X_P = 1.25
  alter V_X_N = 1.15
  alter V_W_P = 1.65
.endc
"}
C {devices/code_shown.sym} 390 -490 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice ff
* .lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice res_ff
.temp 125
"}
C {vsource.sym} 940 -140 0 0 {name=V_SUPPLY value=3.3 savecurrent=false}
C {analog-perceptron-gf180mcu/schematics/gilbert_multiplier_current.sym} 560 -270 0 0 {name=x1}
C {symbols/ppolyf_u.sym} 940 -230 0 0 {name=R1
W=3e-6
L=7e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 800 -230 0 0 {name=R2
W=3e-6
L=7e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_wire.sym} 840 -310 0 0 {name=p1 sig_type=std_logic lab=V_o_p}
C {lab_wire.sym} 800 -270 0 0 {name=p2 sig_type=std_logic lab=V_o_n}
C {vsource.sym} 320 -130 0 0 {name=V_TAIL value=1.65 savecurrent=false}
