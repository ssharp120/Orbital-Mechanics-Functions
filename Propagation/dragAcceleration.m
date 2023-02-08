function a = dragAcceleration(Cd, A, m, rho, vv)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 3 November 2022

a = -(norm(vv) * 1000 * Cd * A * rho / 2 / m) .* vv; % [km/s^2]

end