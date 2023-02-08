function dCOES = differentiateParametersWithPerturbationsForODE45(T, COES, rbody, mu, vw, J2, Cd, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

p_cell = num2cell(COES);
[ecc, h, inc, RAAN, w, theta] = p_cell{:};

[vr_ECI, vv_ECI] = COEStoVectors(mu, ecc, h, theta, w, inc, RAAN);
Q_LVLH_ECI = construct313RotationMatrix(w + theta, inc, RAAN);

% Atmospheric drag
v_rel = vv_ECI - cross(vw, vr_ECI);
r = norm(vr_ECI);
rho = curtisAtmosphereExponentialModel(r - rbody);
va_drag_ECI = dragAcceleration(Cd, A_xsec, m, rho, v_rel)';

% J2
va_J2_ECI = J2Acceleration(rbody, mu, J2, vr_ECI)';

% Combine perturbations and split into components
va_pert_ECI = va_drag_ECI + va_J2_ECI;
va_pert_LVLH = Q_LVLH_ECI * va_pert_ECI;
R = va_pert_LVLH(1);
T = va_pert_LVLH(2);
N = va_pert_LVLH(3);

% Differentiate
dh = r * T;
decc = h / mu * sind(theta) * R + ((h^2 + mu * r) * cosd(theta) + mu * ecc * r) / mu / h * T;
dtheta = rad2deg(h / r^2 + (h^2 / mu * cosd(theta) * R - (h^2 / mu + r) * sind(theta) * T) / ecc / h);
dinc = rad2deg(r / h * cosd(w + theta) * N);
dRAAN = rad2deg(r * sind(w + theta) / h / sind(inc) * N);
dw = rad2deg(-(h^2 / mu * cosd(theta) * R - (h^2 / mu + r) * sind(theta) * T) / ecc / h - r * sind(w + theta) / h / tand(inc) * N);

dCOES = [decc; dh; dinc; dRAAN; dw; dtheta];

end