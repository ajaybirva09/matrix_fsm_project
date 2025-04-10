 # FSM 2x2 Matrix Multiplier (Verilog)

This project implements a simple FSM-based matrix multiplier for two 2×2 matrices using Verilog. It demonstrates:

- FSM Design
- Parallel computation of matrix elements
- RTL and testbench separation
- EPWave-compatible waveform dump

## 💡 FSM States

- **IDLE**: Wait for start
- **LOAD**: Load input matrix values
- **MULT**: Compute multiplication using MAC
- **STORE**: Store result
- **DONE**: Completion flag

## ✅ Example Result

Given:

