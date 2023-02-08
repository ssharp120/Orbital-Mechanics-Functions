function Me = boundMeanAnomaly(Me)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

    % Ensure mean anomaly is between -2 * pi and 2 * pi rad
    if (Me > 2 * pi || Me < -2 * pi)
        Me = mod(Me, sign(Me) * 2 * pi);
    end

end

