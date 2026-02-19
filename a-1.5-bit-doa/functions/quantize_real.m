function y = quantize_real(x, sig, levels, thresholds)
edges = sig * [-inf, thresholds, inf];
y = levels(discretize(x, edges));
end
