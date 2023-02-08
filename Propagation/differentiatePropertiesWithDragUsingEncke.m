function [time_universal, properties_universal] = dualSpacecraftUniversalVariableRelativeStatePropagation(properties, duration, time_step, tolerance, maxIterations, rbody, mu, vw, Cd, A_xsec, m, min_z)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 6 November 2022
    % Inputs:
    %   properties - 1 x 6 row vector with:
    %       Columns 1:3 - the object's position [km]
    %       Columns 4:6 - the object's velocity [km/s]
    %   duration [s]
    %   time_step [s]
    %   tolerance - relative tolerance [km]
    %   maxIterations
    %   rbody - radius of celestial body [km]
    %   mu - gravitational parameter of celestial body [km]
    %   vw - angular velocity of celestial body's atmosphere [rad/s]
    %   Cd - object's coefficient of drag
    %   A_xsec - object's cross-sectional area [m]
    %   m - object's mass [kg]
    %   min_z - optional minimum altitude to stop integration [km]
 
    if (~exist("mu"))
        error("Must specify body gravitational parameter")
    end
    
    if (~exist("duration"))
        duration = 3600;
        warning("Using default duration of 1 hour")
    end
    
    if (~exist("time_step"))
        time_step = 1; % [s]
        warning("Using default duration of 1 second")
    end

    if (~exist("tolerance") || tolerance > 1)
        tolerance = 1e-8;
        warning("Using default tolerance of 1e-8");
    end

    if (~exist("maxIterations"))
        maxIterations = 1e5;
        warning("Using default maximum iterations of 10,000");
    end

    % Universal variable setup
    elapsed_time = 0; % [s]
    i = 1;
    properties_length = floor(duration / time_step);
    properties_universal = zeros(properties_length, 6);
    time_universal = zeros(properties_length, 1);
    vr_universal = properties(1:3);
    vv_universal = properties(4:6);

    % Universal variable propagation
    while (elapsed_time < duration)
        % Semi-major axis
        [ecc, h, ~, ~, ~, ~] = vectorsECItoCOEs(vr_universal, vv_universal, mu);
        a = h^2 / mu / (1 - ecc^2);
    
        % Universal variable
        X = findUniversalVariableUsingNewtons(vr_universal, vv_universal, mu, time_step, a, tolerance, maxIterations); % [km^1/2]

        % Atmospheric drag
        r = norm(vr_universal);
        v_rel = vv_universal - cross(vw, vr_universal);
        rho = curtisAtmosphereExponentialModel(r - rbody);
        va_drag = dragAcceleration(Cd, A_xsec, m, rho, v_rel);

        % Check minimum altitude
        if (r - rbody < min_z)
            warning("Stopping Encke's method after %.1f seconds", elapsed_time);
            properties_universal = properties_universal(1:i, :);
            time_universal = time_universal(1:i);
            return
        end

        % Display progress
        fprintf("Encke's method is %.3f%% done!\n", elapsed_time / duration * 100)
    
        % Combine perturbations
        va_pert = va_drag;

        % "Integrate" perturbations
        vv_pert = va_pert * time_step;
        vr_pert = va_pert * time_step^2 / 2;

        % Propagate oscullating properties
        [vr_universal, vv_universal] = lagrangePropagation(vr_universal, vv_universal, mu, a, time_step, X);

        % Rectify with perturbations
        vr_universal = vr_universal + vr_pert;
        vv_universal = vv_universal + vv_pert;

        % Increment counters
        i = i + 1;
        elapsed_time = elapsed_time + time_step;
        
        % Update output variables
        properties_universal(i, 1:3) = vr_universal;
        properties_universal(i, 4:6) = vv_universal;
        time_universal(i) = elapsed_time;
    end
end