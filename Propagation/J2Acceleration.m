function a = J2Acceleration(rbody, mu, J2, vr)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

r = norm(vr);

a = zeros(1, 3);
a(1) = -3 * J2 * mu * rbody^2 * vr(1) / 2 / r^5 * (1 - 5 * vr(3)^2 / r^2);
a(2) = -3 * J2 * mu * rbody^2 * vr(2) / 2 / r^5 * (1 - 5 * vr(3)^2 / r^2);
a(3) = -3 * J2 * mu * rbody^2 * vr(3) / 2 / r^5 * (3 - 5 * vr(3)^2 / r^2);

end