# Radix-16 FFT Hardware architecture

This is the implementation of a 16-point FFT in VHDL. The architecture focuses on a implementation using only one radix-4 computation block, three complex multipliers, and data registration.

## Defining the data types

The project is based on the 12-bit signed fixed point number ranging from -1 to 1 (but not including either ending). This can be easily changed on types.vhd

## Inputs and outputs

The input should be a real signal, represented by a 16-array of fixed point numbers. The output is a 9-array of fixed point numbers, representing the first half of the FFT. The remaining points can be obtained by considering the symmetry property of a real-number FTT.

The output is divided by 16, in such a way that the output values should fit between -1 and 1.

There are three input control signals: clk, reset, enable. The reset signal is activated with a logic zero. The enable signal will start a new calculations with a logic one. It is not necessary to keep the enable signal dunring the calculations.

## Usage

When testing, it is advisable to reset the radix16 before using.
For the operation the radix16 block:

1. Introduce the designated input signal.
2. Send reset to zero and enable to one.

The system necessitates 7 clock cycles for the completion of the operation.

Starting on the 7th clock cycle, the result will be kept available on the output, unless it starts a new calculation.

To start a new calculation, simply put enable = '1' at any time from the 8th cycle onwards (the calculation will start in the next cycle).

## Testing

I provided a testbenche for the radix16. I also provided the wave.do file for ModelSim Wave view.
