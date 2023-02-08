function pq = quaternionMultiplication(p, q)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(p) ~= [4, 1] | size(q) ~= [4, 1])
        error("Inputs must be quaternion column vectors!")
    end

    eta_p = p(4);
    eta_q = q(4);
    e_p = p(1:3);
    e_q = q(1:3);

    eta_pq = eta_p * eta_q - e_p' * e_q;
    e_pq = eta_p * e_q + eta_q * e_p + crossOperator(e_p) * e_q;

    pq = [e_pq; eta_pq];

end

