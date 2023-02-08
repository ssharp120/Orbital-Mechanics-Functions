function [a_min, dt_min, vv_1] = minimumEnergySolver(vr1, vr2, r1, r2, sindTheta, cosdTheta, mu, n, dThetaPi)
% Steven Sharp
% Dr. Abercromby
% AERO 557 - Advanced Orbital Mechanics
% 31 January 2023
%
% r1 - norm of radius vector 1 [km]
% r2 - norm of radius vector 2 [km]
% cosdTheta - cosine of the angle between vectors [rad]
% mu - gravitational parameter of parent body [km^3/s^2]
% n - number of revs
% dThetaPi - logical value of whether the angle between vectors >= pi

% Preinitialize data types for code generation
a_min = 0;
dt_min = 0;

% generate an include in the C code
coder.cinclude('minimum_energy_solver.h');

% evaluate my C function
coder.ceval('minimum_energy_solver', coder.rref(r1), coder.rref(r2),...
    coder.rref(cosdTheta), coder.rref(mu), int32(n), dThetaPi, coder.wref(a_min), coder.wref(dt_min));

% vector stuff
vv_1 = sqrt(mu * r1 * r2 * (1 - cosdTheta) / sqrt(r1^2 + r2^2 - 2 * r1 * r2 * cosdTheta)) / r1 / r2 / sindTheta ...
    * (vr2 - (1 - r2 / (r1 * r2 * (1 - cosdTheta) / sqrt(r1^2 + r2^2 - 2 * r1 * r2 * cosdTheta)) * (1 - cosdTheta)) * vr1);

end