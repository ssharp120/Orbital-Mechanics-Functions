function C = construct3RotationMatrix(x)

C = [cosd(x), -sind(x), 0;...
    sind(x), cosd(x), 0;...
    0, 0, 1];

end

