function A = makeTriDiag(v, n)
    if length(v) ~= 3
        error('Vector is not length 3')
    end
    A = zeros(n,n);
    for i=2:n-1
        A(i, i-1) = v(1);
        A(i,i) = v(2);
        A(i, i+1) = v(3);
    end
end