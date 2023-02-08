function q_21 = rotationMatrixToQuaternion(C_21)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(C_21) ~= [3, 3])
        error("Input vector must be a 3x3 rotation matrix!")
    end

    eta = sqrt(1 + trace(C_21)) / 2;
    e_1 = (C_21(2, 3) - C_21(3, 2)) / 4 / eta;
    e_2 = (C_21(3, 1) - C_21(1, 3)) / 4 / eta;
    e_3 = (C_21(1, 2) - C_21(2, 1)) / 4 / eta;

    q_21 = [e_1; e_2; e_3; eta];

end

