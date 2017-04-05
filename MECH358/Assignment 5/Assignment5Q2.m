%RUNSCRIPT Q2
h = .1; % Mesh grid resolution?
xS = 0:h:1;
yS = 0:h:1;
[X,Y] = meshgrid(xS,yS);

% Find Bn terms and build total function
N = 100;
totalFunction = @(x,y) 0;
% Notice that THot has been factored out
BmFunc = @(m) 2/(pi*m)*( (-1)^(m+1) + 1 ) * 1/sinh(m*pi);
nextFunc = @(xs,ys) sin(n*pi*xs) * sinh(n*pi*ys);
for n = 1:N
    totalFunction = @(x,y) totalFunction(x,y) + nextFunc(x,y) * BmFunc(n);
end
contourf(totalFunction(X,Y));

