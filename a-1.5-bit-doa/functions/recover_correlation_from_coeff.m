function [rho_rr, rho_ii, rho_ri] = recover_correlation_from_coeff( ...
    M, coeff, R_rr, R_ii, R_ri, nmax, tol, max_iter)

rho_rr = zeros(M);
rho_ii = zeros(M);
rho_ri = zeros(M);

for p = 1:M
    for q = p:M
        rho_rr(p, q) = solve_rho(R_rr(p, q), coeff, nmax, tol, max_iter);
        rho_rr(q, p) = rho_rr(p, q);

        rho_ii(p, q) = solve_rho(R_ii(p, q), coeff, nmax, tol, max_iter);
        rho_ii(q, p) = rho_ii(p, q);
    end
end

for p = 1:M
    for q = 1:M
        rho_ri(p, q) = solve_rho(R_ri(p, q), coeff, nmax, tol, max_iter);
    end
end
end
