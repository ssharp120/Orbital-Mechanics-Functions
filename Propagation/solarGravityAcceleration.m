function [a, vr_sun] = solarGravityAcceleration(vr_ECI, vr_sun, mu_sun)

q = dot(vr_ECI, 2 * vr_sun - vr_ECI) / norm(vr_sun)^2;
Fq = q * (q^2 - 3*q + 3) / (1 + (1 - q)^(3/2));
a = mu_sun * (Fq * vr_sun - vr_ECI) / norm(vr_sun - vr_ECI)^3;

end