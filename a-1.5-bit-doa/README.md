# Quantized DOA Estimation Demos (MATLAB)

This folder contains two explicitly separated MUSIC pipelines:

- `run_music_15bit_demo.m`: dedicated 1.5-bit path.
- `run_music_multibit_demo.m`: generic multi-bit (`b`-bit) path.

The two pipelines do not share the same main script and are wired to different quantizer/recovery entries.

## Main scripts

- `run_music_15bit_demo.m`
  - Quantizer: `quantize_one_point_five_bit_complex.m`
  - Correlation recovery: `recover_correlation_15bit.m`

- `run_music_multibit_demo.m`
  - Quantizer: `quantize_bbit_complex.m`
  - Correlation recovery: `recover_correlation_multibit.m`

## Function layout

- `functions/recover_correlation_15bit.m`: 1.5-bit estimator entry.
- `functions/recover_correlation_multibit.m`: multi-bit estimator entry.
- `functions/recover_correlation_from_coeff.m`: shared core solver.
- `functions/recover_correlation_b.m`: backward-compatible wrapper.

## Requirements

- MATLAB R2021a+ (recommended)
- Signal Processing Toolbox (for `findpeaks`)

## Quick start

```matlab
run_music_15bit_demo
```

or

```matlab
run_music_multibit_demo
```

## Reference

X. Lu, W. Liu, and A. Alomainy, "A 1.5-Bit Quantization Scheme and Its Application to Direction Estimation," IEEE Transactions on Signal Processing, 2025.
