function vRhoHat = anglesOnlyTopocentric(RA, DEC)

% Steven Sharp
% Dr. Abercromby
% AERO 557 - Advanced Orbital Mechanics
% 31 January 2023

vRhoHat = [0, 0, 0];
vRhoHat(1) = cosd(DEC) * cosd(RA);
vRhoHat(2) = cosd(DEC) * sind(RA);
vRhoHat(3) = sind(DEC);
 
end