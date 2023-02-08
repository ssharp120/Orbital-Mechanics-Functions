function dprop = differentiatePropertiesWithPerturbationsForODE45(T, properties, rbody, mu, vw, Cd, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 3 November 2022

    p_cell = num2cell(properties);
    [x, y, z, vx, vy, vz] = p_cell{:};

    % Atmospheric drag
    r = norm([x, y, z]);
    v_rel = [vx, vy, vz] - cross(vw, [x, y, z]);
    rho = curtisAtmosphereExponentialModel(r - rbody);
    va_drag = dragAcceleration(Cd, A_xsec, m, rho, v_rel)';

    % Combine perturbations
    va_pert = va_drag;

    dprop = [vx; vy; vz; (-mu / r^3) * [x; y; z] + va_pert];

end

