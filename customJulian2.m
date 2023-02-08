function [julianNaught, julianDate] = customJulian2(vt)
datetime
    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 15 November 2022
    
    julianNaught = 367 * vt(1) - floor(7 * (vt(1) + floor((vt(2) + 9) / 12)) / 4) + floor(275 / 9 * vt(2)) + vt(3) + 1721013.5;
    julianDate = julianNaught + (vt(4) + vt(5) / 60 + vt(6) / 3600) / 24;

end