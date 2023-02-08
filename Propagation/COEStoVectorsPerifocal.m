function [vr, vv] = COEStoVectorsPerifocal(mu, ecc, h, theta);

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 27 September 2022

    % Verify required arguments
    if (~exist("ecc") || ~exist("h") || ~exist("theta"))
        error("Must specify all COES")
    end

    if (~exist("mu"))
        error("Must specify mu")
    end
    
    % Calculate vectors
    vr = h^2 / (mu * (1 + ecc * cosd(theta))) * [cosd(theta), sind(theta), 0]; % [km]
    vv = mu / h * [-sind(theta), ecc + cosd(theta), 0]; % [km/s]
end
