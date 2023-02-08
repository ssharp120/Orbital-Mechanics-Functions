function J = cylinderMoI(mass, radius, height)

J = [(mass*(height^2)/12)+(mass*(radius^2)/4), 0, 0;...
    0, (mass*(height^2)/12)+(mass*(radius^2)/4), 0;...
    0, 0, mass*(radius^2)/2];

end

