function rho = solve_rho(r_hat, coeff, nmax, tol, max_iter)
An = coeff.An;
orders = 0:nmax;

g = @(x) sum(An ./ (2.^orders .* (orders + 1)) .* x.^(orders + 1));
gp = @(x) sum(An ./ 2.^orders .* x.^orders);

rho = r_hat / gp(0);
for iter = 1:max_iter
    err = g(rho) - r_hat;
    if abs(err) < tol
        break;
    end

    rho = rho - err / gp(rho);
    rho = min(1, max(-1, rho));
end
end
