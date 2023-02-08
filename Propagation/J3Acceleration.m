function a = J3Acceleration(rbody, mu, J3, vr)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

r = norm(vr);

a = zeros(1, 3);
a(1) = -5 * J3 * mu * rbody^3 * vr(1) / 2 / r^7 * (3 * vr(3) - 7 * vr(3)^3 / r^2);
a(2) = -5 * J3 * mu * rbody^3 * vr(2) / 2 / r^7 * (3 * vr(3) - 7 * vr(3)^3 / r^2);
a(3) = -5 * J3 * mu * rbody^3 / 2 / r^7 * (6 * vr(3)^2 - 7 * vr(3)^4 / r^2 - 3 / 5 * r^2);

end