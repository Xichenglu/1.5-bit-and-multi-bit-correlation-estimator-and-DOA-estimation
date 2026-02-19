function Y = quantize_bbit_complex(X, levels, thresholds, sigma_ch)
[M, N] = size(X);
Y = zeros(M, N);
for m = 1:M
    sig = sigma_ch(m);
    xr = real(X(m, :));
    xi = imag(X(m, :));
    Y(m, :) = ( ...
        quantize_real(xr, sig, levels, thresholds) + ...
        1i * quantize_real(xi, sig, levels, thresholds) ...
    ) / sqrt(2);
end
end
