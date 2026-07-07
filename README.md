# Programmable Analog Perceptron

## Goal

This project is made by utilizing GF180mcu PDK, for the 2026 SSCS PICO Chipathon. Objective primarily is to learn, and tapeout if possible.

## Overview

A single perceptron in the analog (continuous time) domain, where its weights and biases are programmable. Intended operation is in DC mode, and sensor agnostic as long as it is a current mode sensor. Designed with photodiodes in mind. Basically analog computation, where the computation performed is : y = f(x1w1+x2w2+b), where f is an activation function resembling or closely approximating tanh or sigmoid.

Highlight is that there is no digital, memory elements. The calculation happens as fast it can. As in, the time taken, intuitively, is the time taken for an input impulse to form a respective output impulse response. All while maintaining the full "analog" resolution. In contrast, a typical digital circuit would take a MAC operation(s) with a delay to perform it, and would be limited to the precision it has. Not to mention the involvment of ADC, DAC in such a digital circuit, causing overhead.

## Repository Structure

Main overview of the structure of this repository

* `plots/`: Simulation sweep data and generated figures
   * `plots/plot_results.py`: Script that generates all figures from sweep data
   * `plots/*.txt`: Raw ngspice sweep outputs (which are parsed by matplotlib) 
   * `plots/plots_generated/`: Plots generated from xschem via matplotlib (python)
* `schematics/`: Xschem sources and testbenches for all blocks
   * `schematics/cg_amp_tia.sch`: CG-amp shunt-feedback TIA
   * `schematics/gilbert_multiplier.sch` / `gilbert_multiplier_current.sch`: Gilbert cell multiplier (voltage-mode and current-mode variants)
   * `schematics/tanh_ota.sch`: Differential amplifier sigmoid/tanh stage
   * `schematics/perceptron.sch`: Top-level perceptron integration
   * `schematics/tb_*.sch`: Testbenches for each block above
   * `schematics/diagrams/`: Exported block/testbench diagrams (PDF) 

## Chipathon Documents & Related

Area estimate is approximately ~300um x 300um currently. 

Progress tracker

Proposal

Schematic

## Specifications (Target)

### Pins
