function C = construct2RotationMatrix(x)

C = [cosd(x), 0, sind(x);...
    0, 1, 0;
    -sind(x), 0, cosd(x)];

end

