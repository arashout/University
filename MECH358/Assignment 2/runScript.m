%Assignment 1
num = 20;
a = randi(num);
m = randi(num);
n = randi(num);
f = @(x) x^m - a^n;
dfdx = @(x) m * x ^ (m - 1);
[root, k] = newt(f, dfdx, 1);
%Assignment 2
omega = 1;
kappa = .1;
h = .1;
t = 0:h:12;
y0 = [-pi; 1];
%First method
% A = [0, 1; -omega^2, -kappa];
% y = crankNichol(A, y0, t);
% plot(t, y(1,:));
%Second Method
f = @(y1, y2) [y2; -omega^2 * sin(y1) - kappa * y2];
J = @(y1,y2) [0,1.0;-omega^2*cos(y1),-kappa];
invJ = @(y1,y2) [-kappa/(omega^2 * cos(y1)), -1/(omega^2 * cos(y1)); 1, 0];
