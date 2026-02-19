function [rho_rr, rho_ii, rho_ri] = recover_correlation_15bit( ...
    M, lambda, R_rr, R_ii, R_ri, nmax, tol, max_iter)
% Dedicated correlation recovery entry for the 1.5-bit pipeline.
% Uses the ternary quantizer definition to build its own coefficients.

[levels, thresholds] = make_one_point_five_bit_quantizer(lambda);
coeff = precompute_an(levels, thresholds, nmax);

[rho_rr, rho_ii, rho_ri] = recover_correlation_from_coeff( ...
    M, coeff, R_rr, R_ii, R_ri, nmax, tol, max_iter);
end
