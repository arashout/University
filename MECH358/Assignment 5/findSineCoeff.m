function [arrBn] = findSineCoeff(f, N, L)
    arrBn = zeros(N,1);
    nestedFunc = @(n, L) @(x) f(x) .* sin(n * pi * x ./ L) ; 
    for n = 1:N
        %bnIntegrand is only a function of x now
        bnIntegrand = nestedFunc(n, L);
        arrBn(n) = 2 / L * integral(bnIntegrand, 0, L);
    end
end