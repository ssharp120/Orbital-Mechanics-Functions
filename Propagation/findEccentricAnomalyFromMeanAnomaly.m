function E = findEccentricAnomalyFromMeanAnomaly(Me, ecc, RelTol, maxIterations)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

    Me = boundMeanAnomaly(Me);
    
    % Check optional arguments
    if (~exist('RelTol') || RelTol <= 0 || RelTol > 1)
        warning('Using default relative tolerance of 10^-8 rad')
        RelTol = 1e-8;
    end
    
    if (~exist('maxIterations') || maxIterations <= 0)
        warning('Using default absolute tolerance of 10,000 iterations')
        maxIterations = 10000;
    end
    
    % Set up iterated variables
    iterations = 0;
    delta = 1;
    
    % Determine initial guees for eccentric anomaly
    if (Me < pi) 
        E = Me + ecc / 2;
    else
        E = Me - ecc / 2;
    end
    
    % Iterate
    while (abs(delta) > RelTol && iterations < maxIterations)
    
        nextE = E + (Me - E + ecc * sin(E))/(1 - ecc * cos(E));
        
        delta = nextE - E;

        E = nextE;

        iterations = iterations + 1;
    
    end

    %fprintf("Newton's method finished after %d iterations with an accuracy of %e rad\n", iterations, delta)

end

