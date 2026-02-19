function Y = quantize_one_point_five_bit_complex(X, lambda, sigma_ch)
% Channel-wise 1.5-bit quantization for complex snapshots.
% Real and imaginary parts are quantized independently to {-1,0,+1}.
[M, N] = size(X);
Y = zeros(M, N);

for m = 1:M
    sig = sigma_ch(m);
    xr = real(X(m, :));
    xi = imag(X(m, :));

    yr = quantize_one_point_five_bit_real(xr, lambda, sig);
    yi = quantize_one_point_five_bit_real(xi, lambda, sig);
    Y(m, :) = (yr + 1i * yi) / sqrt(2);
end
end

function y = quantize_one_point_five_bit_real(x, lambda, sig)
y = zeros(size(x));
idx_pos = x >= lambda * sig;
idx_neg = x <= -lambda * sig;
y(idx_pos) = 1;
y(idx_neg) = -1;
end
