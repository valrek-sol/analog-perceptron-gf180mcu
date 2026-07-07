# Programmable Analog Perceptron

## Overview

A single perceptron in the analog (continuous time) domain, where its weights and biases are programmable. Intended operation is in DC mode, and sensor agnostic as long as it is a current mode sensor. Designed with phot[^1]odiodes in mind. Basically analog computation, where the computation performed is : y = f(x1w1+x2w2+b), where f is an activation function resembling or closely approximating tanh or sigmoid.

Highlight is that there is no digital, memory elements. The calculation happens as fast it can. As in, the time taken, intuitively, is the time taken for an input impulse to form a respective output impulse response. All while maintaining the full "analog" resolution. In contrast, a typical digital circuit would take a MAC operation(s) with a delay to perform it, and would be limited to the precision it has. Not to mention the involvment of ADC, DAC in such a digital circuit, causing overhead.

## Repository Structure

## Chipathon Documents & Related

Area estimate is approximately ~300um x 300um currently. 

Progress tracker

Proposal

Schematic

## Specifications (Target)

### Pins