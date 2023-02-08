function dCOES = differentiateParametersWithAllPertsForODE45(t, COES, t0, r_body, mu_body, mu_sun, vw, J2, J3, J4, J5, J6, Cd, Cr, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

p_cell = num2cell(COES);
[ecc, h, inc, RAAN, w, theta] = p_cell{:};

[vr_ECI, vv_ECI] = COEStoVectors(mu_body, ecc, h, theta, w, inc, RAAN);
Q_LVLH_ECI = construct313RotationMatrix(w + theta, inc, RAAN);

% J2 - J6
va_J2_ECI = J2Acceleration(r_body, mu_body, J2, vr_ECI);
va_J3_ECI = J3Acceleration(r_body, mu_body, J3, vr_ECI);
va_J4_ECI = J4Acceleration(r_body, mu_body, J4, vr_ECI);
va_J5_ECI = J5Acceleration(r_body, mu_body, J5, vr_ECI);
va_J6_ECI = J6Acceleration(r_body, mu_body, J6, vr_ECI);

% Solar gravity and radiation pressure
[~, ~, vr_sun] = solar_position(customJulian2(datevec(t0 + seconds(t))));
vr_sun = vr_sun';
va_pert_solar_grav_ECI = solarGravityAcceleration(vr_ECI, vr_sun, mu_sun);
va_pert_SRP_ECI = solarRadiationPressureAcceleration(t, t0, vr_ECI, vr_sun, r_body, Cr, A_xsec, m);

% Atmospheric drag
r = norm(vr_ECI);
z = r - r_body;
if (z <= 1000)
    v_rel = vv_ECI - cross(vw, vr_ECI);
    rho = curtisAtmosphereExponentialModel(z);
    va_drag_ECI = dragAcceleration(Cd, A_xsec, m, rho, v_rel);
else
    va_drag_ECI = zeros(1, 3);
end

% Combine perturbations and split into components
va_pert_ECI = va_J2_ECI + ...
    va_J3_ECI + va_J4_ECI + ...
    va_J5_ECI + va_J6_ECI + ...
    va_pert_solar_grav_ECI + ...
    va_pert_SRP_ECI + va_drag_ECI;

va_pert_LVLH = Q_LVLH_ECI * va_pert_ECI';
R = va_pert_LVLH(1);
T = va_pert_LVLH(2);
N = va_pert_LVLH(3);

% Differentiate
dh = r * T;
decc = h / mu_body * sind(theta) * R + ((h^2 + mu_body * r) * cosd(theta) + mu_body * ecc * r) / mu_body / h * T;
dtheta = rad2deg(h / r^2 + (h^2 / mu_body * cosd(theta) * R - (h^2 / mu_body + r) * sind(theta) * T) / ecc / h);
dinc = rad2deg(r / h * cosd(w + theta) * N);
dRAAN = rad2deg(r * sind(w + theta) / h / sind(inc) * N);
dw = rad2deg(-(h^2 / mu_body * cosd(theta) * R - (h^2 / mu_body + r) * sind(theta) * T) / ecc / h - r * sind(w + theta) / h / tand(inc) * N);

dCOES = [decc; dh; dinc; dRAAN; dw; dtheta];

end