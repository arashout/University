h = 1/4;
x = [0:h:1];
n = length(x);

A = zeros(n,n);
b = zeros(n,1);

f = @(x) 4*pi.^2.*sin(2*pi*x)*h^2;
%diagonal entries
for i=2:n-1
    %2nd Central Finite Difference
    A(i, i-1) = -1;
    A(i,i) = 2;
    A(i, i+1) = -1;
    b(i) = f(x(i));
end
%BCs
A(1,1) = 1; b(1) = 0;
A(n,n) = 1; b(n) = 0;

u = linsolve(A, b);

