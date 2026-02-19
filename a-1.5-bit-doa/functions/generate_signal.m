function [x, A] = generate_signal(M, N, K, theta_deg, snr_db, d)
A = steering_matrix(M, d, theta_deg);
s = (randn(K, N) + 1i * randn(K, N)) / sqrt(2);
n = (randn(M, N) + 1i * randn(M, N)) / sqrt(2);
x = 10^(snr_db / 20) * A * s + n;
end
