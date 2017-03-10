function [arrAn] = findFourierAns(f, N, lb, ub)
    arrAn = zeros(N+1,1);
    %assuming xStar in the general case = x/(ub-lb)
    %iF = intermediate function for convience
    %iF1 returns a function handle (nested function)
    iF1 = @(n, lb, ub, x) @(x) f(x/(ub - lb)).*cos(n*pi*x/(ub - lb)); 
    for i = 0:N
        %iF2 is only a function of x now
        iF2 = iF1(i, lb, ub);
        arrAn(i+1) = 2 * integral(iF2, lb, ub);
    end
end