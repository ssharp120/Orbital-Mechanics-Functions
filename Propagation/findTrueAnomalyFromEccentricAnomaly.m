function theta = findTrueAnomalyFromEccentricAnomaly(E, ecc)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

    % Find true anomaly:
    % tan(E / 2) = sqrt((1 - e)/(1 + e)) * tan(theta / 2)
    % => tan(theta / 2) = sqrt((1 + e)/(1 - e)) * tan(E / 2)
    theta = 2 * atan(sqrt((1 + ecc)/(1 - ecc)) * tan(E / 2)); % [rad]
    theta = theta * 180 / pi + 360; % [°]
end

