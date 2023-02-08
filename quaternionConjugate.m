function qstar = quaternionConjugate(q)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(1) ~= [4, 1])
        error("Input must be a quaternion column vector!")
    end

    eta_q = q(4);
    e_q = q(1:3);
    eta_qstar = eta_q;
    e_qstar = -e_q;

    qstar = [e_qstar; eta_qstar];

end

