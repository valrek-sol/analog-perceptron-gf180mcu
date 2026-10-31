# Test Plan for the Perceptron

## Testbench
Simple Breadboard Setup,
Voltage Generator connected to input voltage pins,
Photo Diode Circuit Connected to input Current pins, or any current mode sensor for that matter,
Then a precise enough (order of ~10mV) Voltage Multimeter/ Voltmeter shall be used to measure the single output votlage. 
VDD stable supply from Voltage Generator.

### Sources and Measurement

| Pin | Direction | Type | Testbench Source / Measurement |
| --- | --- | --- | --- |
| I_in1 | In | Analog | Photo Diode| 
| I_in2 | Out | Analog | Photo Diode| 
| V_w1 | In | Analog | Voltage Generator DC| 
| V_w2 | In | Analog | Voltage Generator DC| 
| V_bias | In | Analog | Voltage Generator DC| 
| V_shift | In | Analog | Voltage Generator DC| 
| V_out | Out | Analog | Digital Voltmeter / Multimeter (Precise) |
| VDD | In | Power | 3.3V Voltage DC Source | 


## Evaluation

Do a voltage sweep across the extremes of input weights of the perceptron
Test the photodiode current via changing the light available to the perceptron
Check V_Shift behaviour by altering the generator voltage, and so on for every input. 
Collect ~15 point data per sweep. (15 is arbitrary)

## Validation
The 15 point data sweep, interpolated, should match the simulation results in shape. If it does, the circuit works flawlessly.

## Report

Testbench Details shall be included.
Report comparing simulated values and actual test-bench data.
Measuring the deviation if any, and reporting the error magnitude/ MSE per kind.

Compiling all possible data points, and logging it. For GF180mcuD / FOSS tool , it can become some sort of a valuable data point published online freely for the analog domain.

Perhaps a report also containing the FOSS side of things and pitfalls and overall guide may be useful for the subsequent user who wants to reproduce / attempt similar full custom analog designs.

