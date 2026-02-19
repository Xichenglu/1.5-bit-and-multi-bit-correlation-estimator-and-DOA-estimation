function [levels, thresholds] = make_symmetric_quantizer(b, lambda)
L = 2^b;
idx = -(L-1):2:(L-1);
levels = idx / sqrt(mean(idx.^2));
thresholds = lambda * ((levels(2:end) + levels(1:end-1)) / 2);
end
