function [levels, thresholds] = make_one_point_five_bit_quantizer(lambda)
% 1.5-bit quantizer: ternary output {-1, 0, +1}.
% Thresholds are +/- lambda * sigma for each channel.
levels = [-1, 0, 1];
thresholds = [-lambda, lambda];
end
