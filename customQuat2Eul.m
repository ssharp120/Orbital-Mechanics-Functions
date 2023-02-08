function E = customQuat2Eul(q)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(1) ~= [4, 1])
        error("Input must be a quaternion column vector!")
    end
    
    eta = q(4);
    e = q(1:3);
    
    phi = atan2(2 * (eta * e(1) + e(2) * e(3)), 1 - 2 * (e(1)^2 + e(2)^2));
    theta = asin(2 * (eta * e(2) - e(3) * e(1)));
    psi = atan2(2 * (eta * e(3) + e(1) * e(2)), 1 - 2 * (e(2)^2 + e(3)^2));
    
    E = [phi; theta; psi];

end