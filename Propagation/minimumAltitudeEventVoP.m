function [z, isterminal, direction] = minimumAltitudeEventVoP(T, t0, COES, r_body, mu_body, mu_sun, vw, Cd, Cr, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

p_cell = num2cell(COES);
[ecc, h, inc, RAAN, w, theta] = p_cell{:};

[vr_ECI, ~] = COEStoVectors(mu, ecc, h, theta, w, inc, RAAN);

r = norm(vr_ECI);
z = r - rbody - min_z;

isterminal = 1;
direction = -1;

end