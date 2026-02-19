function results = music_doa(Rx, M, K, d, angles)
A_scan = steering_matrix(M, d, angles);
[V, D] = eig(Rx);
[~, idx] = sort(diag(D), 'descend');
En = V(:, idx(K+1:end));

spectrum = zeros(size(angles));
for n = 1:length(angles)
    a = A_scan(:, n);
    spectrum(n) = 1 / real(a' * (En * En') * a);
end

[peak_vals, peak_idx] = findpeaks(spectrum, 'SortStr', 'descend', 'NPeaks', K);
results.peaks = angles(peak_idx);
results.peakVals = peak_vals;
results.spectrum = spectrum;
end
