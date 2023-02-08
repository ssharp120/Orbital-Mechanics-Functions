function a = J6Acceleration(rbody, mu, J6, vr)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

r = norm(vr);

a = zeros(1, 3);
a(1) = -J6 * mu * rbody^6 * vr(1) / 16 / r^9 * (35 - 945 * vr(3)^2 / r^2 + 3465 * vr(3)^4 / r^4 - 3003 * vr(3)^6 / r^6);
a(2) = -J6 * mu * rbody^6 * vr(2) / 16 / r^9 * (35 - 945 * vr(3)^2 / r^2 + 3465 * vr(3)^4 / r^4 - 3003 * vr(3)^6 / r^6);
a(3) = -J6 * mu * rbody^6 * vr(3) / 16 / r^9 * (245 - 2205 * vr(3)^2 / r^2 + 4851 * vr(3)^4 / r^4 - 3003 * vr(3)^6 / r^6);

end