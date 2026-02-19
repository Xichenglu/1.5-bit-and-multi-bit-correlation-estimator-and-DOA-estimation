%% Multi-Bit Quantization Demo for DOA Estimation (MUSIC)
% This script runs a generic b-bit quantization pipeline.
% It is intentionally separated from run_music_15bit_demo.m.

clear; clc;
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));

%% ---------------- User parameters ----------------
M       = 10;            % Number of array elements
K       = 2;             % Number of sources
theta   = [-10, 3.5];    % True DOA in degrees
d       = 0.5;           % Element spacing (in wavelength)
Nsnap   = 300;           % Number of snapshots
SNR_dB  = -10;           % Input SNR (dB)
b       = 2;             % Quantizer bit depth (>= 2 for generic multi-bit)
lambda  = 0.5;           % Symmetric threshold scaling factor
Norder  = 10;            % Hermite expansion order
maxIter = 300;           % Maximum iterations for inversion
tol     = 1e-6;          % Convergence tolerance
angles  = -90:0.1:90;    % MUSIC scanning grid
rng(2025);               % Fixed seed for reproducibility

%% ---------------- 1) Generate array data ----------------
[X, ~] = generate_signal(M, Nsnap, K, theta, SNR_dB, d);
sigma_x = sqrt(var(X.', 1).');

%% ---------------- 2) Multi-bit quantize snapshots ----------------
[levels, thresholds] = make_symmetric_quantizer(b, lambda);
Y = quantize_bbit_complex(X, levels, thresholds, sigma_x);

%% ---------------- 3) Quantized covariance blocks ----------------
Y_real = real(Y);
Y_imag = imag(Y);
Ry_rr  = Y_real * Y_real' / Nsnap;
Ry_ii  = Y_imag * Y_imag' / Nsnap;
Ry_ri  = Y_real * Y_imag' / Nsnap;

%% ---------------- 4) Correlation recovery ----------------
[rho_rr, rho_ii, rho_ri] = recover_correlation_multibit( ...
    M, b, lambda, Ry_rr, Ry_ii, Ry_ri, Norder, tol, maxIter);

Rx_hat = (sigma_x * sigma_x.') .* (rho_rr + rho_ii - 1i * (rho_ri - rho_ri'));

%% ---------------- 5) MUSIC DOA estimation ----------------
doa_est = music_doa(Rx_hat, M, K, d, angles);
rmse = sqrt(mean((sort(doa_est.peaks(:)) - sort(theta(:))).^2));

fprintf('Estimated DOA (deg):\n');
disp(sort(doa_est.peaks(:)).');
fprintf('RMSE = %.3f deg\n', rmse);

figure; hold on; grid on;
plot(angles, doa_est.spectrum, 'LineWidth', 1.4);
for idx = 1:numel(theta)
    xline(theta(idx), '--b', 'LineWidth', 1.0, 'HandleVisibility', 'off');
end
xlabel('Angle (deg)');
ylabel('|P_{MU}(\theta)|');
title(sprintf('MUSIC Spectrum (%d-bit quantization)', b));
legend('MUSIC Spectrum', 'True DOA');
