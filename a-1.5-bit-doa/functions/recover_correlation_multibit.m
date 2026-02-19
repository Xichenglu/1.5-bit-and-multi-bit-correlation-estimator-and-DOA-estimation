function [rho_rr, rho_ii, rho_ri] = recover_correlation_multibit( ...
    M, b, lambda, R_rr, R_ii, R_ri, nmax, tol, max_iter)
% Dedicated correlation recovery entry for the generic multi-bit pipeline.

[levels, thresholds] = make_symmetric_quantizer(b, lambda);
coeff = precompute_an(levels, thresholds, nmax);

[rho_rr, rho_ii, rho_ri] = recover_correlation_from_coeff( ...
    M, coeff, R_rr, R_ii, R_ri, nmax, tol, max_iter);
end
