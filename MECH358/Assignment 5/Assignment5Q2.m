%RUNSCRIPT Q2
res = 100;
xS = linspace(0,1, res);
yS = linspace(0,1, res);
% Accumalator Matrix
Z = zeros(res, res);
% Bn function with T_Hot factored out
N = 100;
bnFunc = @(m) 2/(pi*m)*( (-1)^(m+1) + 1 ) / sinh(m*pi);
generalFunc = @(xs, ys, n) bnFunc(n) * sin(n*pi*xs) * sinh(n*pi*ys);

%VECTORIZED NOT WORKING?
% [X,Y] = meshgrid(xS,yS);
% for n = 1:N
%     Z = Z + generalFunc(X,Y,n);
% end

for i = 1:res
    xs = xS(i);
    for j = 1:res
        ys = yS(j);
        for n = 1:N
            Z(i,j) = Z(i,j) + generalFunc(xs,ys,n);
        end
    end
end
%Transpose to fix orientation
figure(1)
contourf(xS,yS,Z');
title('Temperature as a function of x and y')
xlabel('x/L')
ylabel('y/H')
figure(2)
surf(xS,yS,Z')
