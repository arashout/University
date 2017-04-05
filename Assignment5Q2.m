%RUNSCRIPT Q2
res = 100;
xS = linspace(0,1, res);
yS = linspace(0,1, res);
[X,Y] = meshgrid(xS,yS);
% Accumalator Matrix
Z = zeros(res, res);
% Bn function with T_Hot factored out
N = 10;
bnFunc = @(m) 2/(pi*m)*( (-1)^(m+1) + 1 ) /sinh(m*pi);
generalFunc = @(xs, ys, n) bnFunc(n) * sin(n*pi*xs) * sinh(n*pi*ys);
for i = 1:res
    xs = xS(i);
    for j = 1:res
        ys = yS(j);
        for n = 1:N
            Z(i,j) = Z(i,j) + generalFunc(xs,ys,n);
        end
    end
end

contour(X,Y,Z');

