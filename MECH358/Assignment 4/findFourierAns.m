function [arrAn] = findFourierAns(f, N, L)
    arrAn = zeros(N+1,1);
    %assuming xStar in the general case = x/(ub-lb)
    %iF = intermediate function for convience
    %iF1 returns a function handle (nested function)
    iF1 = @(n, L, x) @(x) f(x/L).*cos(n*pi*x/L); 
    for i = 0:N
        %iF2 is only a function of x now
        iF2 = iF1(i, L);
        arrAn(i+1) = 2 * integral(iF2, L);
    end
end