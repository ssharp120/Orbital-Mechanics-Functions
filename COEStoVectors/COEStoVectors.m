function [vr, vv] = COEStoVectors(mu, ecc, h, theta, w, inc, RAAN)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 27 September 2022

    [vr_peri, vv_peri] = COEStoVectorsPerifocal(mu, ecc, h, theta);
    Q = construct313RotationMatrix(w, inc, RAAN);
    vr = (Q' * vr_peri')'; % [km]
    vv = (Q' * vv_peri')'; % [km/s]
end