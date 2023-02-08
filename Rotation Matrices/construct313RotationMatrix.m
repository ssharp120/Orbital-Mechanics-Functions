function Q = construct313RotationMatrix(theta, gamma, iota)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 27 September 2022

    % Verify required arguments
    if (~exist("theta") || ~exist("gamma") || ~exist("iota"))
        error("Must specify all 3 angles")
    end
    
    % Calculate rotation matrix
    Q = [cosd(theta) * cosd(iota) - sind(theta) * cosd(gamma) * sind(iota) ...
        cosd(theta) * sind(iota) + sind(theta) * cosd(gamma) * cosd(iota) ...
        sind(theta) * sind(gamma);
        -sind(theta) * cosd(iota) - cosd(theta) * cosd(gamma) * sind(iota) ...
        -sind(theta) * sind(iota) + cosd(theta) * cosd(gamma) * cosd(iota) ...
        cosd(theta) * sind(gamma);
        sind(gamma) * sind(iota) ...
        -sind(gamma) * cosd(iota) ...
        cosd(gamma)];
end