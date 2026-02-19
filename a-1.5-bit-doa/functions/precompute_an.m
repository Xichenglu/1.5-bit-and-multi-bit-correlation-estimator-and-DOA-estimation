function coeff = precompute_an(levels, thresholds, nmax)
L = length(levels);
pos = ceil(L / 2):L;
levels_pos = levels(pos);
thrs_pos = thresholds(thresholds >= 0);

levels_full = [-levels_pos(end:-1:1), levels_pos];
thrs_full = [-thrs_pos(end:-1:1), thrs_pos];

K = length(thrs_full) + 1;
dz = diff(levels_full);
u = thrs_full / sqrt(2);
coeff.An = zeros(1, nmax + 1);

for n = 0:nmax
    Hn_u = hermiteH(n, u);
    accum = 0;
    for k = 1:K-1
        for m = 1:K-1
            accum = accum + dz(k) * dz(m) ...
                * exp(-(u(k)^2 + u(m)^2)) ...
                * Hn_u(k) * Hn_u(m);
        end
    end
    coeff.An(n + 1) = accum / factorial(n);
end

coeff.An = coeff.An / (2 * pi);
end
