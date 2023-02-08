function [RA, DEC] = ascensionFromAzimuth(LST, lat, az, el)

% Steven Sharp
% Dr. Abercromby
% AERO 557 - Advanced Orbital Mechanics
% 31 January 2023

DEC = asind(cosd(lat) * cosd(az) * cosd(el) + sind(lat) * sind(el));

if (az >= 0 && az < 180)
    HA = 360 - acosd((cosd(lat) * sind(el) - sind(lat) * cosd(az) * cosd(el)) / cosd(DEC));
else
    HA = acosd((cosd(lat) * sind(el) - sind(lat) * cosd(az) * cosd(el)) / cosd(DEC));
end

RA = mod(LST - HA, 360);

end

