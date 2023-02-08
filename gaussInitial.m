function vRho = gaussInitial(t1, t2, t3, mat_rhohat, mat_Rsite, mu)
% Steven Sharp
% Dr. Abercromby
% AERO 557 - Advanced Orbital Mechanics
% 31 January 2023

% Preinitialize data types for code generationa
c = [0, 0, 0];
a = [0, 0, 0, 0];
r2_root = 10000;

% evaluate my C function to get values for a
coder.ceval('gauss_initial', coder.rref(r2_root), coder.rref(t1),...
    coder.rref(t2), coder.rref(t3), coder.rref(mu), coder.wref(a), coder.wref(c));

% I trust MATLAB to do this faster than C
mat_M = mat_rhohat\mat_Rsite;

% matrix stuff can be handled in MATLAB
d1 = mat_M(2, 1) * a(1) - mat_M(2, 2) + mat_M(2, 3) * a(3);
d1u = mat_M(2, 1) * a(2) + mat_M(2, 3) * a(4);
C = dot(mat_rhohat(:, 2), mat_Rsite(:, 2));

% root solve for r2
r2fun = @(x) x^8 - (d1^2 + 2 * C * d1 + norm(mat_Rsite(:, 2))^2) * x^6 - 2 * mu * (C * d1u + d1 * d1u) * x^3 - mu^2 * d1u^2;
r2_root = fzero(r2fun, 10000);

% generate an include in the C code
coder.cinclude('gauss_initial.h');

% evaluate my C function to get values for c
coder.ceval('gauss_initial', coder.rref(r2_root), coder.rref(t1),...
    coder.rref(t2), coder.rref(t3), coder.rref(mu), coder.wref(a), coder.wref(c));

% find magnitudes of the rho vectors
vRho_t = (mat_M * -c') ./ c;

% lagrange coefficients for v2
f1 = 1 - mu / 2 / r2_root^3 * (t1-t2)^2;
f3 = 1 - mu / 2 / r2_root^3 * (t3-t2)^2;

g1 = t1-t2 - mu / 6 / r2_root^3 * (t1-t2)^3;
g3 = t3-t2 - mu / 6 / r2_root^3 * (t3-t2)^3;

v2 = (-f3 * (mat_Rsite(:, 1) + vRho_t(:, 1)) + f1 * (mat_Rsite(:, 3) + vRho_t(:, 3))) / (f1 * g3 - f3 * g1);

% return all data in a single matrix
vRho = [vRho_t, v2, [f1; f3; 0], [g1; g3; 0]];

end