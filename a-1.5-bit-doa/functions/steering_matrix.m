function A = steering_matrix(M, d, theta_deg)
theta = sind(theta_deg(:).');
m = (0:M-1).';
A = exp(-1i * 2 * pi * d * m * theta);
end
