function a = solarRadiationPressureAcceleration(t, t0, vr_ECI, vr_sun, r_body, Cr, A, m)

theta = acos(dot(vr_sun, vr_ECI) / norm(vr_sun) / norm(vr_ECI));
theta_A = acos(r_body / norm(vr_sun));
theta_B = acos(r_body / norm(vr_ECI));

if (theta_A + theta_B < theta)
    a = zeros(1, 3);
else
    P_SR = calculateSolarPower(t0 + seconds(t)) / 299792458; % [N/m^2]
    a = -P_SR * Cr * A / m * (vr_sun - vr_ECI) / norm(vr_sun - vr_ECI) / 1000; % [km/s^2]
end

end

