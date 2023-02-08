function vx = crossOperator(v)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(v) ~= [3, 1])
        error("Input vector must be a column vector of length 3!")
    end

    vx = [0, -v(3), v(2); v(3), 0, -v(1); -v(2), v(1), 0];

end

