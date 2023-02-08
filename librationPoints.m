function lagrange_points = librationPoints(mu_star)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 15 November 2022

    L1 = @(x) x + (1 - mu_star)/((x - mu_star)^2) - mu_star / ((x - mu_star + 1)^2);
    L2 = @(x) x + (1 - mu_star)/((x - mu_star)^2) + mu_star / ((x - mu_star + 1)^2);
    L3 = @(x) x - (1 - mu_star)/((x - mu_star)^2) - mu_star / ((x - mu_star + 1)^2);
    
    lagrange_points = cell(1, 5);
    
    lagrange_points{1} = [fzero(L1, 1/2), 0];
    lagrange_points{2} = [fzero(L2, 1/2), 0];
    lagrange_points{3} = [fzero(L3, 1/2), 0];
    lagrange_points{4} = [mu_star - 1/2, sqrt(3)/2];
    lagrange_points{5} = [mu_star - 1/2, -sqrt(3)/2];

end

