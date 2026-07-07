# Programmable Analog Perceptron

## Overview

A single perceptron in the analog (continuous time) domain, where its weights and biases are programmable. Intended operation is in DC mode, and sensor agnostic as long as it is a current mode sensor. Designed with photodiodes in mind. Basically analog computation, where the computation performed is : y = f(x1w1+x2w2+b), where f is an activation function resembling or closely approximating tanh or sigmoid.

Highlight is that there is no digital, memory elements. The calculation happens as fast it can. As in, the time taken, intuitively, is the time taken for an input impulse to form a respective output impulse response. All while maintaining the full "analog" resolution. In contrast, a typical digital circuit would take a MAC operation(s) with a delay to perform it, and would be limited to the precision it has. Not to mention the involvment of ADC, DAC in such a digital circuit, causing overhead.

## Repository Structure

## Repository Structure

* `plots/`: Simulation sweep data and generated figures
   * `plots/plot_results.py`: Script that generates all figures from sweep data
   * `plots/*.txt`: Raw ngspice sweep outputs (TIA, Gilbert cell, tanh OTA, perceptron)
   * `plots/plots_generated/`: Rendered PNGs — [TIA linearity](plots/plots_generated/01_tia_linear.png), [Gilbert single](plots/plots_generated/02_gilbert_single.png), [Gilbert family](plots/plots_generated/03_gilbert_family.png), [tanh OTA](plots/plots_generated/04_tanh_ota.png), [perceptron weights](plots/plots_generated/05_perceptron_weights.png), [perceptron sensors](plots/plots_generated/06_perceptron_sensors.png), [perceptron bias](plots/plots_generated/07_perceptron_bias.png), [3D sensors](plots/plots_generated/08_perceptron_3d_sensors.png), [3D weights](plots/plots_generated/09_perceptron_3d_weights.png)
* `schematics/`: Xschem sources and testbenches for all blocks
   * `schematics/cg_amp_tia.sch`: CG-amp shunt-feedback TIA
   * `schematics/gilbert_multiplier.sch` / `gilbert_multiplier_current.sch`: Gilbert cell multiplier (voltage-mode and current-mode variants)
   * `schematics/tanh_ota.sch`: Differential amplifier sigmoid/tanh stage
   * `schematics/perceptron.sch`: Top-level perceptron integration
   * `schematics/tb_*.sch`: Testbenches for each block above
   * `schematics/diagrams/`: Exported block/testbench diagrams (PDF) — [perceptron hierarchy](schematics/diagrams/diagram_perceptron_hierarchical.pdf), [TIA testbench](schematics/diagrams/diagram_tb_cg_amp_tia.pdf), [Gilbert multiplier testbench](schematics/diagrams/diagram_tb_gilbert_multiplier_current.pdf), [perceptron testbench](schematics/diagrams/diagram_tb_perceptron.pdf), [tanh OTA testbench](schematics/diagrams/diagram_tb_tanh_ota.pdf)
* `pyproject.toml` / `uv.lock`: Python environment config for the plotting/analysis scripts (managed with `uv`)

## Chipathon Documents & Related

Area estimate is approximately ~300um x 300um currently. 

Progress tracker

Proposal

Schematic

## Specifications (Target)

### Pins
