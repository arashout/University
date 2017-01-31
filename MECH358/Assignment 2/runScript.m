% %Assignment 1
% num = 20;
% a = randi(num);
% m = randi(num);
% n = randi(num);
% f = @(x) x^m - a^n;
% dfdx = @(x) m * x ^ (m - 1);
% [root, k] = newt(f, dfdx, 1, 0);
%Assignment 2
omega = 1;
kappa = .1;
h = .1;
t = 0:h:12;
y0 = [-pi; 1];
%First method
figure(1)
A = [0, 1; -omega^2, -kappa];
y = crankNichol(A, y0, t);
plot(t, y(1,:));
figure(2)
f = @(y1, y2) y2;
g = @(y1, y2) -omega^2 * y1 - kappa * y2;
yRK = rk4Pend(f,g,y0,t);
plot(t, yRK);

% %Non-linear crank-nicholson
% f = @(y1, y2) [y2; -omega^2 * sin(y1) - kappa * y2];
% J = @(y1,y2) [0,1.0;-omega^2*cos(y1),-kappa];
% invJ = @(y1,y2) [-kappa/(omega^2 * cos(y1)), -1/(omega^2 * cos(y1)); 1, 0];
