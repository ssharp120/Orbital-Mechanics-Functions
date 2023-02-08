function rho = curtisAtmosphereExponentialModel(z)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 6 November 2022

if (z < 100)
    rho = 9.708e-8;
    warning("Altitude below 100 km")
    return
end

vh_0 = [linspace(100,150,6), 180, linspace(200,500,7), linspace(600,1000,5)];
vH = [5.703 6.782 9.973 13.243 16.322 ...
21.652 27.974 34.934 43.342 49.755 54.513 58.019 ...
60.980 65.654 76.377 100.587 147.203 208.020 208.020];
vrho_0 = [5.606e-7 9.708e-8 2.222e-8 8.152e-9 3.831e-9 ...
2.076e-9 5.194e-10 2.541e-10 6.073e-11 1.916e-11 7.014e-12 2.803e-12 ...
1.184e-12 5.215e-13 1.137e-13 3.070e-14 1.136e-14 5.759e-15 3.561e-15];

i = find(vh_0 < z);
j = i(end);

rho = vrho_0(j) * exp(-(z - vh_0(j)) / vH(j));

end