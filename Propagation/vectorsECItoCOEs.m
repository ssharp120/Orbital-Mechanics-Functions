function [ecc, h, inc, RAAN, w, theta] = vectorsECItoCOEs(vr, vv, mu)

    % Steven Sharp
    % AERO 452
    % Dr. Abercromby
    % 12 October 2022

    % Find the magnitudes of the radius and velocity vectors:
    r = norm(vr);
    v = norm(vv);

    % Find the projection of v onto r:
    v_r = dot(vr, vv) / r;

    % Find the angular momentum:
    vh = cross(vr, vv);
    h = norm(vh);

    % Find the inclination:
    inc = acosd(vh(3) / h);

    % Find the node line:
    vN = cross([0, 0, 1], vh);
    N = norm(vN);

    % Find the RAAN:
    if (vN(2) >= 0)
        RAAN = acosd(vN(1) / N);
    else
        RAAN = 360 - acosd(vN(1) / N);
    end

    % Find the eccentricity:
    vecc = 1 / mu * (cross(vv, vh) - mu * vr/r);
    ecc = norm(vecc);

    % Find the argument of periapse:
    if (vecc(3) >= 0)
        w = acosd(dot(vN, vecc)/(N * ecc));
    else
        w = 360 - acosd(dot(vN, vecc)/(N * ecc));
    end
    
    % Find the true anomaly:
    if (v_r >= 0)
        theta = acosd(dot(vecc, vr)/(ecc * r));
    else
        theta = 360 - acosd(dot(vecc, vr)/(ecc * r));
    end

end