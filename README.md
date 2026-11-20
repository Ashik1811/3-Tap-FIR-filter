
# 3-Tap FIR Filter Design and PPA Optimization

## Project Overview

This project focuses on the design, functional verification, synthesis, and Power, Performance, and Area (PPA) optimization of a 3-Tap Finite Impulse Response (FIR) Filter using Verilog HDL and Synopsys EDA tools.

The project explores both structural RTL implementation and arithmetic-based optimization while maintaining the intended filter functionality.


## Objectives

1. Understand the functionality of the Verilog RTL implementation.
2. Perform functional verification using Synopsys VCS.
3. Synthesize the design and generate Area, Power, Timing, and Cell reports.
4. Analyze PPA variations by modifying clock period, input delay, output delay, uncertainty, and output load.
5. Optimize PPA through RTL code modifications.
6. Analyze critical timing paths in the synthesized design.

## FIR Filter Architecture

A 3-Tap FIR filter consists of three coefficients and two sample-delay elements.

The difference equation is:

Y[n] = X[n]H0 + X[n-1]H1 + X[n-2]H2

Where:

- X[n] – Current input sample
- X[n-1] – Previous input sample
- X[n-2] – Input sample from two clock cycles earlier
- H0, H1, H2 – Filter coefficients
- Y[n] – Filter output

### RTL Architecture

The original structural implementation consists of:

- Full Adder (FA)
- 8-bit D Flip-Flop (DFF8)
- 16-bit D Flip-Flop (DFF16)
- 16-bit Ripple Carry Adder (RCA)
- 8×8 Braun Multiplier
- Top-level 3-Tap FIR Filter

The design uses three multipliers, two ripple-carry adders, two 8-bit delay registers, and one 16-bit output register.

## Tools and Technologies

- Verilog HDL
- Synopsys VCS – Functional Verification
- Synopsys Design Compiler – RTL Synthesis
- Tcl Scripting – Synthesis Automation
- SDC – Timing Constraints
- Linux Environment

## Verification

Functional verification was performed using Synopsys VCS before synthesis.

Simulation command:

```bash
vcs fir_3tap.v tb_fir_3tap.v -full64 -debug_all
```

The testbench applies input samples and filter coefficients and monitors the output response.

Simulation waveforms were analyzed to validate the functionality of the FIR filter.

## Synthesis and PPA Optimization

RTL synthesis was performed using Synopsys Design Compiler.

The following parameters were analyzed:

- Cell Count
- Power Consumption
- Area
- Timing Performance

### Constraint-Based Optimization

PPA was evaluated under different timing constraint configurations.

The analysis included variations in:

- Clock Period
- Input Delay
- Output Delay
- Clock Uncertainty
- Output Load

### Selected Constraint Configuration

| Parameter | Selected Value |
|---|---:|
| Clock Period | 8 ns |
| Input Delay | 1.2 ns |
| Output Delay | 1.2 ns |
| Clock Uncertainty | 0.3 ns |
| Output Load | 0.0004 |

### PPA Comparison

The following results were obtained for three RTL optimization configurations:

| Configuration | Performance | Power (µW) | Area | Cells |
|---|---:|---:|---:|---:|
| All Comments | -5.42 | 323.6337 | 3635.76 | 891 |
| First 6 Uncommented | -7.08 | 374.8294 | 4622.06 | 1499 |
| All Uncommented | -8.81 | 421.6346 | 5740.35 | 3014 |

*Values are reproduced from the project report.*

## RTL-Level Optimization

The original design implemented an 8×8 Braun multiplier using structural logic.

An alternative implementation using the Verilog multiplication operator was evaluated to study its impact on:

- Cell Count
- Power Consumption
- Area
- Timing Performance

The results demonstrated that modifying the RTL implementation can influence synthesis outcomes while preserving the intended filter functionality.

## Timing Analysis

Timing paths were examined after synthesis for:

1. The constraint-optimized design.
2. The RTL-modified design.

This analysis helped understand the impact of RTL architecture and timing constraints on the synthesized design.

## Key Learnings

- Structural RTL design and modular hardware implementation.
- Functional verification using Synopsys VCS.
- RTL synthesis using Synopsys Design Compiler.
- SDC constraint configuration and timing analysis.
- PPA trade-off analysis.
- RTL optimization and synthesis report interpretation.
- Critical timing-path analysis.

## Project Report

The detailed project report contains the RTL source code, testbench, simulation waveforms, synthesis procedure, PPA reports, optimization experiments, and timing-path analysis.

## Conclusion

The project successfully demonstrated the design and functional verification of a 3-Tap FIR filter, followed by synthesis and PPA optimization.

By experimenting with timing constraints and modifying the RTL architecture, the project provided practical insights into the relationship between hardware description, synthesis behavior, and PPA efficiency.

