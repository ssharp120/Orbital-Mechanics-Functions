function ad = diagOperator(a)

sz = size(a);
ad = zeros(sz(1), sz(1)*sz(2));

for (i = 0:(sz(1)-1))
    ad(i+1, (i*sz(2)+1):((i+1)*sz(2))) = a(i+1, :);
end

end