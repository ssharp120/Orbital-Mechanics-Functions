% Introduction
% Steven Sharp
% AERO 452 - California Polytechnic State University
% Dr. Abercromby
% 17 October 2022

% Housekeeping
clc
clear

% Constants
% "constant"
earth.r = 6378; % [km]
earth.mu = 398600; % [km^3/s^2]

% COEs of target from TLE
spacecraft.initial_conditions.z_p = 697; % [km]
spacecraft.initial_conditions.z_a = 39675; % [km]
spacecraft.initial_conditions.r_p = earth.r + spacecraft.initial_conditions.z_p; % [km]
spacecraft.initial_conditions.r_a = earth.r + spacecraft.initial_conditions.z_a; % [km]

spacecraft.initial_conditions.COES.ecc = ...
    (spacecraft.initial_conditions.r_a - spacecraft.initial_conditions.r_p) / ...
    (spacecraft.initial_conditions.r_p + spacecraft.initial_conditions.r_a);
spacecraft.initial_conditions.COES.RAAN = 308.5722; % [°]
spacecraft.initial_conditions.COES.inc = 63.2833; % [°]
spacecraft.initial_conditions.COES.w = 282.4803; % [°]
spacecraft.initial_conditions.COES.M = 10.7916; % [°]
spacecraft.initial_conditions.COES.h = sqrt(earth.mu * (1 + spacecraft.initial_conditions.COES.ecc) * spacecraft.initial_conditions.r_p); % [km/s^2]
spacecraft.initial_conditions.COES.theta = ...
    findTrueAnomalyFromEccentricAnomaly(findEccentricAnomalyFromMeanAnomaly(spacecraft.initial_conditions.COES.M, spacecraft.initial_conditions.COES.ecc, 1e-9, 10000), ...
    spacecraft.initial_conditions.COES.ecc);  % [°]

[A.vr_ECI_0, A.vv_ECI_0] = COEStoVectors(earth.mu, spacecraft.initial_conditions.COES.ecc, spacecraft.initial_conditions.COES.h, spacecraft.initial_conditions.COES.theta, spacecraft.initial_conditions.COES.w, spacecraft.initial_conditions.COES.inc, spacecraft.initial_conditions.COES.RAAN);

%% Hold

properties = [A.vr_ECI_0, A.vv_ECI_0];
tspan = [0, 25*3600]; % [s]
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9);
[~, properties_final] = ode45(@differentiatePropertiesForODE45, tspan, properties, options, earth.mu);

f{1} = figure("Name", "Target orbit")
f{1}.Position = [100 100 900 800];

plot3(properties_final(:, 1), properties_final(:, 2), properties_final(:, 3), 'Color', '#F3F3F3', 'LineWidth', 2)

grid on
hold on

plot3(properties_final(1, 1), properties_final(1, 2), properties_final(1, 3), 'o', 'Color', '#F3F3F3', 'MarkerSize', 8, 'MarkerFaceColor', '#AAAAAA')

[x, y, z] = sphere(100);
s = surf(x * earth.r, y * earth.r, z * earth.r);
s.EdgeColor = 'none';
s.FaceColor = '#11119A';

title("Target orbit and starting position in ECI")
xlabel("x [km]")
ylabel("y [km]")
zlabel("z [km]")

axis([-45000 45000 -45000 45000 -45000 45000])

set(gca, 'color', '#030303')