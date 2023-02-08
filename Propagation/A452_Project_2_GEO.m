%% Introduction

% Steven Sharp
% AERO 452 - California Polytechnic State University
% Dr. Abercromby
% 4 December 2022

%% Housekeeping

clc
clear variables
close all

%% Constants
% "constant"

earth.r = 6378; % [km]
earth.mu = 398600; % [km^3/s^2]
earth.w = 7.29211e-5; % [rad/s]
earth.vw = [0, 0, earth.w]; % [rad/s]

earth.J2 = 0.00108263;
earth.J3 = -2.33936e-3 * earth.J2;
earth.J4 = -1.49601e-3 * earth.J2;
earth.J5 = -0.20995e-3 * earth.J2;
earth.J6 = 0.49941e-3 * earth.J2;

sun.mu = 1.327124e11; % [km^3/s^2]

simulation.integration_time = 3 * 365 * 24 * 3600; % [s]
simulation.minimum_altitude = 100; % [km]

%% Spacecraft initial conditions

spacecraft.initial_conditions.z_p = 35778; % [km]
spacecraft.initial_conditions.z_a = 35794; % [km]
spacecraft.initial_conditions.r_p = earth.r + spacecraft.initial_conditions.z_p; % [km]
spacecraft.initial_conditions.r_a = earth.r + spacecraft.initial_conditions.z_a; % [km]

spacecraft.initial_conditions.COES.ecc = ...
    (spacecraft.initial_conditions.r_a - spacecraft.initial_conditions.r_p) / ...
    (spacecraft.initial_conditions.r_p + spacecraft.initial_conditions.r_a);
spacecraft.initial_conditions.COES.RAAN = 142.9864; % [°]
spacecraft.initial_conditions.COES.inc = 0.0254; % [°]
spacecraft.initial_conditions.COES.w = 104.3997; % [°]
spacecraft.initial_conditions.COES.M = 334.792; % [°]
spacecraft.initial_conditions.COES.h = sqrt(earth.mu * (1 + spacecraft.initial_conditions.COES.ecc) * spacecraft.initial_conditions.r_p); % [km/s^2]
spacecraft.initial_conditions.COES.theta = ...
    findTrueAnomalyFromEccentricAnomaly(findEccentricAnomalyFromMeanAnomaly(spacecraft.initial_conditions.COES.M, spacecraft.initial_conditions.COES.ecc, 1e-9, 10000), ...
    spacecraft.initial_conditions.COES.ecc);  % [°]

spacecraft.physical_properties.A = 6.1 * 5.6; % [m^2]
spacecraft.physical_properties.Cd = 2.2;
spacecraft.physical_properties.Cr = 1.2;
spacecraft.physical_properties.m = 5192; % [kg]

%% Simulation

simulation.VoP.COES = [spacecraft.initial_conditions.COES.ecc, spacecraft.initial_conditions.COES.h, spacecraft.initial_conditions.COES.inc, ...
    spacecraft.initial_conditions.COES.RAAN, spacecraft.initial_conditions.COES.w, spacecraft.initial_conditions.COES.theta];

simulation.start_date = datetime(2022, 12, 4, 0, 0, 0);
simulation.time_span = [0, simulation.integration_time];
simulation.options = odeset("RelTol", 1e-8);

[results.time_final, results.COES_final] = ode45(@differentiateParametersWithAllPertsForODE45, simulation.time_span, simulation.VoP.COES, simulation.options, ...
    simulation.start_date, ...
    earth.r, earth.mu, sun.mu, earth.vw, ...
    earth.J2, earth.J3, earth.J4, earth.J5, earth.J6, ...
    spacecraft.physical_properties.Cd, spacecraft.physical_properties.Cr, spacecraft.physical_properties.A, spacecraft.physical_properties.m, ...
    simulation.minimum_altitude);

results.v_length = length(results.time_final);

%% Plotting

for (i = 1:results.v_length)
    results.semi_major_axis(i) = results.COES_final(i, 2)^2 / earth.mu / (1 - results.COES_final(i, 1)^2);
end
clear E i

plotCOES(results);