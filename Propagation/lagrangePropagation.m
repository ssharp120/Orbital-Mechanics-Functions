function [vr, vv] = lagrangePropagation(vr_naught, vv_naught, mu, a, deltaT, X)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 6 November 2022

    % Get z and stumpff values:
    z = getZ(X, a);
    C = stumpffC(z);
    S = stumpffS(z);

    % Find the first two Lagrange coefficients:
    f = 1 - X^2 / norm(vr_naught) * C;
    g = deltaT - 1 / sqrt(mu) * X^3 * S;

    % Find the new radius vector:
    vr = f * vr_naught + g * vv_naught;

    % Find the second two Lagrange coefficients:
    fdot = sqrt(mu) / (norm(vr) * norm(vr_naught)) * X * (z * S - 1);
    gdot = 1 - (X^2 / norm(vr)) * C;

    % Find the new velocity vector:
    vv = fdot * vr_naught + gdot * vv_naught;
end