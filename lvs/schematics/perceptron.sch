v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 960 -1990 960 -460 2500 -460 2500 -2000 960 -2000 {}
P 4 5 940 -2020 940 -440 2520 -440 2520 -2020 940 -2020 {}
N 1960 -1570 1960 -1200 {lab=#net1}
N 1740 -1570 1740 -1290 {lab=#net2}
N 1660 -1290 1740 -1290 {lab=#net2}
N 1660 -1290 1660 -1250 {lab=#net2}
N 1520 -1570 1520 -1230 {lab=#net3}
N 1520 -1230 1660 -1230 {lab=#net3}
N 1500 -1210 1660 -1210 {lab=#net4}
N 1500 -1430 1500 -1210 {lab=#net4}
N 1380 -1430 1500 -1430 {lab=#net4}
N 1380 -1190 1660 -1190 {lab=#net5}
N 1380 -1210 1380 -1190 {lab=#net5}
N 1380 -1170 1660 -1170 {lab=#net6}
N 1380 -1170 1380 -990 {lab=#net6}
N 1500 -1150 1660 -1150 {lab=#net7}
N 1500 -1150 1500 -770 {lab=#net7}
N 1380 -770 1500 -770 {lab=#net7}
N 1280 -690 1300 -690 {lab=VSS}
N 1280 -1350 1300 -1350 {lab=VSS}
N 1280 -1350 1280 -690 {lab=VSS}
N 1280 -910 1300 -910 {lab=VSS}
N 1280 -1130 1300 -1130 {lab=VSS}
N 1300 -850 1320 -850 {lab=VDD}
N 1320 -1510 1320 -850 {lab=VDD}
N 1300 -1510 1320 -1510 {lab=VDD}
N 1300 -1290 1320 -1290 {lab=VDD}
N 1300 -1070 1320 -1070 {lab=VDD}
N 1280 -1650 1280 -1350 {lab=VSS}
N 1280 -1650 1440 -1650 {lab=VSS}
N 1440 -1670 1440 -1650 {lab=VSS}
N 1440 -1670 1880 -1670 {lab=VSS}
N 1880 -1670 1880 -1650 {lab=VSS}
N 1660 -1670 1660 -1650 {lab=VSS}
N 1600 -1650 1600 -1630 {lab=VDD}
N 1600 -1630 2040 -1630 {lab=VDD}
N 2040 -1650 2040 -1630 {lab=VDD}
N 1820 -1650 1820 -1630 {lab=VDD}
N 2240 -2020 2240 -1860 {lab=VDD}
N 1860 -1280 2240 -1280 {lab=VDD}
N 2240 -1860 2240 -1280 {lab=VDD}
N 1320 -1510 2240 -1510 {lab=VDD}
N 1300 -690 1300 -550 {lab=VSS}
N 940 -550 1860 -550 {lab=VSS}
N 1860 -1120 1860 -550 {lab=VSS}
N 940 -770 1180 -770 {lab=V_w2}
N 940 -990 1180 -990 {lab=I_x2}
N 940 -1210 1180 -1210 {lab=V_b}
N 940 -1430 1180 -1430 {lab=I_x1}
N 2040 -1650 2240 -1650 {lab=VDD}
N 1520 -2000 1520 -1770 {lab=V_w1}
N 1740 -2000 1740 -1770 {lab=V_shift}
N 1960 -2000 1960 -1770 {lab=V_out_perceptron}
C {analog-perceptron-gf180mcu/schematics/perceptron_core.sym} 1810 -1200 0 0 {name=x1}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1380 -910 0 1 {name=xIO5
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1380 -690 0 1 {name=xIO1
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1380 -1350 0 1 {name=xIO2
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1380 -1130 0 1 {name=xIO3
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1440 -1570 1 1 {name=xIO4
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1660 -1570 1 1 {name=xIO6
spiceprefix=X
}
C {analog-perceptron-gf180mcu/schematics/io_secondary_5p0.sym} 1880 -1570 1 1 {name=xIO7
spiceprefix=X
}
C {iopin.sym} 2240 -2020 3 0 {name=p1 lab=VDD}
C {iopin.sym} 940 -550 2 0 {name=p2 lab=VSS}
C {ipin.sym} 940 -1430 0 0 {name=p3 lab=I_x1}
C {ipin.sym} 940 -990 0 0 {name=p4 lab=I_x2}
C {ipin.sym} 940 -1210 0 0 {name=p5 lab=V_b}
C {ipin.sym} 940 -770 0 0 {name=p6 lab=V_w2}
C {ipin.sym} 1520 -2000 1 0 {name=p7 lab=V_w1}
C {ipin.sym} 1740 -2000 1 0 {name=p8 lab=V_shift}
C {opin.sym} 1960 -2000 3 0 {name=p9 lab=V_out_perceptron}
