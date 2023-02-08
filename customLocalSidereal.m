function [localSiderealTime] = customLocalSidereal(day, month, year, hour, minute, second, eastLongitude)
[julianNaught, ~] = customJulian(day, month, year, hour, minute, second);
timeNaught = (julianNaught - 2451545) / 36525;
thetaGreenwichNaught = mod(100.4606184 + 36000.77004 * timeNaught + 0.000387933 * timeNaught^2 - 2.58 * 10^-8 * timeNaught^3, 360);
thetaGreenwich = thetaGreenwichNaught + 360.98564724 * (hour + minute / 60 + second / 3600) / 24;
localSiderealTime = mod(thetaGreenwich + eastLongitude, 360);
end

