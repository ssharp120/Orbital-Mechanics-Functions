function a = J4Acceleration(rbody, mu, J4, vr)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

r = norm(vr);

a = zeros(1, 3);
a(1) = 15 * J4 * mu * rbody^4 * vr(1) / 8 / r^7 * (1 - 14 * vr(3)^2 / r^2 + 21 * vr(3)^4 / r^4);
a(2) = 15 * J4 * mu * rbody^4 * vr(2) / 8 / r^7 * (1 - 14 * vr(3)^2 / r^2 + 21 * vr(3)^4 / r^4);
a(3) = 15 * J4 * mu * rbody^4 * vr(3) / 8 / r^7 * (5 - 70 * vr(3)^2 / 3 / r^2 + 21 * vr(3)^4 / r^4);

end