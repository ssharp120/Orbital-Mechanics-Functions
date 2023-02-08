function dprop = differentiatePropertiesForODE45(T, properties, mu)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 17 October 2022

    p_cell = num2cell(properties);
    [x, y, z, vx, vy, vz] = p_cell{:};
    r = norm([x, y, z]);
    dprop = [vx; vy; vz; (-mu / r^3) * [x; y; z]];

end

