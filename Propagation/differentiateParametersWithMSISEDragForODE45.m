function dCOES = differentiateParametersWithPerturbationsForODE45(t, COES, rbody, mu, vw, Cd, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

p_cell = num2cell(COES);
[ecc, h, inc, RAAN, w, theta] = p_cell{:};

[vr_ECI, vv_ECI] = COEStoVectors(mu, ecc, h, theta, w, inc, RAAN);
Q_LVLH_ECI = construct313RotationMatrix(w + theta, inc, RAAN);
current_time = datetime(2023, 1, 1, 0, 0, 0) + seconds(t);
vt = datevec(current_time);
vr_LLA = eci2lla(vr_ECI * 1000, vt);

% Atmospheric drag
v_rel = vv_ECI - cross(vw, vr_ECI);
r = norm(vr_ECI);
[~, vrho] = atmosnrlmsise00(vr_LLA(3), vr_LLA(1), vr_LLA(2), current_time.Year, day(current_time, 'dayofyear'), current_time.Hour * 3600 + current_time.Minute * 60 + current_time.Second);
va_drag_ECI = dragAcceleration(Cd, A_xsec, m, vrho(6), v_rel)';
va_drag_LVLH = Q_LVLH_ECI * va_drag_ECI;

% Combine perturbations and split into components
va_pert_LVLH = va_drag_LVLH;
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