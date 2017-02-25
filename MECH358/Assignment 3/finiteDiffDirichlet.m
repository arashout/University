function [y] = finiteDiffDirichlet(gamma, beta, alpha, g, b1, b2, x)
%Pre-allocate required stuff
N = length(x);
A = zeros(N,N);
f = zeros(1, N);
%A*T = f

%Fill in Tridiagonal matrix (A)
A(1,1) = 1;
A(end,end) = 1;
for i = 2:N-1
    xi = x(i);
    A(i, i-1) = gamma(xi);
    A(i, i) = beta(xi);
    A(i, i+1) = alpha(xi);
end
%Fill in constant vector (f)
f(1) = b1;
f(end) = b2; 
for i = 2:N-1
    xi = x(i);
    f(i) = g(xi);
end
iA = inv(A);
y = f/A;