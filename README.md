# Programmable Analog Perceptron

## Goal

This project is made by utilizing GF180mcu PDK, for the 2026 SSCS PICO Chipathon. Objective primarily is to learn, and tapeout if possible.

## Overview

A single perceptron in the analog (continuous time) domain, where its weights and biases are programmable. Intended operation is in DC mode, and sensor agnostic as long as it is a current mode sensor. Designed with photodiodes in mind. Basically analog computation, where the computation performed is : y = f(x1w1+x2w2+b), where f is an activation function resembling or closely approximating tanh or sigmoid.

Highlight is that there is no digital, memory elements. The calculation happens as fast it can. As in, the time taken, intuitively, is the time taken for an input impulse to form a respective output impulse response. All while maintaining the full "analog" resolution. In contrast, a typical digital circuit would take a MAC operation(s) with a delay to perform it, and would be limited to the precision it has. Not to mention the involvment of ADC, DAC in such a digital circuit, causing overhead.

## Repository Structure

Main overview of the structure of this repository


* [`plots/`](plots/): Simulation sweep data and generated figures
   * [`plots/plot_results.py`](plots/plot_results.py): Script that generates all figures from sweep data
   * `plots/*.txt`: Raw ngspice sweep outputs (which are parsed by matplotlib)
   * [`plots/plots_generated/`](plots/plots_generated/): Plots generated from xschem via matplotlib (python)
* [`schematics/`](schematics/): Xschem sources and testbenches for all blocks
   * [`schematics/cg_amp_tia.sch`](schematics/cg_amp_tia.sch): CG-amp shunt-feedback TIA
   * [`schematics/gilbert_multiplier.sch`](schematics/gilbert_multiplier.sch) / [`gilbert_multiplier_current.sch`](schematics/gilbert_multiplier_current.sch): Gilbert cell multiplier (voltage-mode and current-mode variants)
   * [`schematics/tanh_ota.sch`](schematics/tanh_ota.sch): Differential amplifier sigmoid/tanh stage
   * [`schematics/perceptron.sch`](schematics/perceptron.sch): Top-level perceptron integration
   * `schematics/tb_*.sch`: Testbenches for each block above
   * [`schematics/diagrams/`](schematics/diagrams/): Exported block/testbench diagrams (PDF)

## Chipathon Documents & Related

Area estimate is approximately ~300um x 300um currently. 

[Github repo (this repo)](https://github.com/valrek-sol/analog-perceptron-gf180mcu)

[Google Drive containing all below material](https://drive.google.com/drive/folders/1w9kNC-WTRVOlu-ZDq20NobVmB2Sa7vTh?usp=sharing)

[Proposal Slide Link](https://docs.google.com/presentation/d/13eMg_GNvv0nm00do740fxi4ZR1RHCYNasZUUlCRyxGo/edit?usp=sharing)

[Proposal Video Link](https://drive.google.com/file/d/1MZTpp1oeU_d-gKvnwnpxPWE7-ZTWUfAw/view?usp=drive_link)

[Pin Requirement Link](https://docs.google.com/spreadsheets/d/1j0dq9UvAsj5zYBimwCMxk5xVtT9jLV9aKmREzxfqWbw/edit?usp=drive_link)

[Progress tracker Link](https://docs.google.com/spreadsheets/d/1hsH6fOqgu6h7McnxBpZjmTYU_prxYtLpsWHi7i9b4Zk/edit?usp=sharing)

[Schematic Review Slide Link (Compacted)](https://docs.google.com/presentation/d/11Yxg_3VuQzDJLRQqG4vkzuTGyFlSRIocTLgW-DXF2V8/edit?usp=drive_link)

[Schematic Review Slide Link (Full)](https://docs.google.com/presentation/d/1FTLqScoZ_3OFutOgfb5MBX5IrDTujoEfs5XRks5E18U/edit?usp=drive_link)

[Schematic Review Video Link](https://drive.google.com/file/d/1bdpH2OENgyuMhEZ-BPgnGtmW76qQdRpw/view?usp=drive_link)


## Specifications (Target)

### Pins
