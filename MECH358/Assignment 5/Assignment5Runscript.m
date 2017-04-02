c1 = .1; %e_dot/(rho*c_p)
L = 1;
D_T = 10^-4;
omega = 10^-3;
T_o = @(x) 100;

tau_D = L^2/D_T;
N = 10;
h = .01;

% Find sine series co-efficient
bnCoeff = findSineCoeff(T_o, N, L);
% Find Heat generation co-efficients
snCoeff = zeros(N,1);
snFunc = @(n, t) @(t) (1 + sin(omega*t)) * -2/(n*pi) * c1 * ( (-1)^n + 1/(n^2*pi^2) * ((-1)^n -1) );
for n = 1:N
    snCoeff(n) = snFunc(n);
end


t = tau_D * [0, 1e-2, 1e-1, 1, 1e1, 1e3];
x = 0:h:L;