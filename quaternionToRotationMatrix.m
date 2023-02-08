function C = quaternionToRotationMatrix(q)

eta = q(4);
e = q(1:3);

C = eye(3).*(2 * eta^2 - 1) + 2 .* e * e' - 2 .* eta .* crossOperator(e);

end

