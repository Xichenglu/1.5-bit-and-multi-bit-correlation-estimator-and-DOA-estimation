%% A 1.5-Bit Quantization Demo for DOA Estimation (MUSIC)
% This script reproduces DOA estimation with a dedicated 1.5-bit quantizer.
% The 1.5-bit quantizer is ternary ({-1, 0, +1}) and is treated separately
% from generic multi-bit quantizers.
%
% Reference publication:
% X. Lu, W. Liu, A. Alomainy,
% "A 1.5-Bit Quantization Scheme and Its Application to Direction Estimation,"
% IEEE Transactions on Signal Processing, 2025.

clear; clc;
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));

%% ---------------- User parameters ----------------
M       = 10;            % Number of array elements
K       = 2;             % Number of sources
theta   = [-10, 3.5];    % True DOA in degrees
d       = 0.5;           % Element spacing (in wavelength)
Nsnap   = 300;           % Number of snapshots
SNR_dB  = -10;           % Input SNR (dB)
Norder  = 10;            % Hermite expansion order
maxIter = 300;           % Maximum iterations for inversion
tol     = 1e-6;          % Convergence tolerance
lambda  = 0.5;           % 1.5-bit threshold factor
angles  = -90:0.1:90;    % MUSIC scanning grid
rng(2025);               % Fixed seed for reproducibility

%% ---------------- 1) Generate array data ----------------
[X, ~] = generate_signal(M, Nsnap, K, theta, SNR_dB, d);
sigma_x = sqrt(var(X.', 1).');

%% ---------------- 2) 1.5-bit quantize snapshots ----------------
[levels, thresholds] = make_one_point_five_bit_quantizer(lambda);
Y = quantize_one_point_five_bit_complex(X, lambda, sigma_x);

%% ---------------- 3) Quantized covariance blocks ----------------
Y_real = real(Y);
Y_imag = imag(Y);
Ry_rr  = Y_real * Y_real' / Nsnap;
Ry_ii  = Y_imag * Y_imag' / Nsnap;
Ry_ri  = Y_real * Y_imag' / Nsnap;

%% ---------------- 4) Correlation recovery ----------------
coeff = precompute_an(levels, thresholds, Norder);
[rho_rr, rho_ii, rho_ri] = recover_correlation_b( ...
    M, coeff, Ry_rr, Ry_ii, Ry_ri, Norder, tol, maxIter);

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
title('MUSIC Spectrum (1.5-bit quantization)');
legend('MUSIC Spectrum', 'True DOA');
