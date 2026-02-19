# A 1.5-Bit Quantization Demo for DOA Estimation

This repository contains a MATLAB demo implementation of DOA estimation with MUSIC for the **dedicated 1.5-bit quantization scheme**.

> Important: 1.5-bit quantization is not treated as a generic multi-bit setting in this codebase. A separate quantizer function is provided for the ternary output case.

Related paper:

> X. Lu, W. Liu, and A. Alomainy, "A 1.5-Bit Quantization Scheme and Its Application to Direction Estimation," *IEEE Transactions on Signal Processing*, 2025.

## Project structure

- `run_music_15bit_demo.m` — main demo script (1.5-bit pipeline).
- `functions/` — helper functions:
  - `make_one_point_five_bit_quantizer.m`
  - `quantize_one_point_five_bit_complex.m`
  - `make_symmetric_quantizer.m` and `quantize_bbit_complex.m` (generic multi-bit utilities)
  - signal generation, correlation recovery, and MUSIC routines
- `CITATION.cff` — citation metadata
- `LICENSE` / `COPYRIGHT` — legal and copyright files

## Requirements

- MATLAB R2021a+ (recommended)
- Signal Processing Toolbox (for `findpeaks`)

## Quick start

```matlab
run_music_15bit_demo
```

Tune `SNR_dB`, `lambda`, `theta`, and `Nsnap` in the script for your experiment.


## MATLAB code style

- Functions are kept modular and named by purpose (signal generation, quantization, recovery, DOA).
- The 1.5-bit path is explicitly separated from generic multi-bit utilities.
- Variable names and comments follow technical-paper style to improve readability and reproduction.

## Citation

If this code helps your research, please cite the paper above. Metadata is provided in `CITATION.cff`.
