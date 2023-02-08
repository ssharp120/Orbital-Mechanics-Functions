function a = J5Acceleration(rbody, mu, J5, vr)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

r = norm(vr);

a = zeros(1, 3);
a(1) = 3 * J5 * mu * rbody^5 * vr(1) * vr(3) / 8 / r^9 * (35 - 210 * vr(3)^2 / r^2 + 231 * vr(3)^4 / r^4);
a(2) = 3 * J5 * mu * rbody^5 * vr(2) * vr(3) / 8 / r^9 * (35 - 210 * vr(3)^2 / r^2 + 231 * vr(3)^4 / r^4);
a(3) = 3 * J5 * mu * rbody^5 * vr(3) * vr(3) / 8 / r^9 * (105 - 315 * vr(3)^2 / r^2 + 231 * vr(3)^4 / r^4) - 15 * J5 * mu * rbody^5 / 8 / r^7;

end