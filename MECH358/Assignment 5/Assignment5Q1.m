c1 = .1; %e_dot/(rho*c_p)
L = 1;
D_T = 10^-4;
w = 10^-3;
%T_o is f(x) for bn series
T_0 = 100;
f = @(x) T_0;
tau_D = L^2/D_T;

% Resolution parameters
N = 1000;
res = 10;

t = tau_D * [0, 1e-2, 1e-1, 1, 1e1, 1e3];
x = linspace(0,L,res);

%Convenience functions
yn = @(n) (n*pi/L)^2; %Lambda LOL

% Functions to find sine series co-efficients
bnIntegrand = @(n) @(x) f(x) .* sin(n * pi * x ./ L);
bnFunc = @(n) 2 / L * integral(bnIntegrand(n), 0, L);
sineTerm = @(n,t) bnFunc(n) * exp(-yn(n)*D_T*t);
%Functions to find heat generation co-efficients
sn = @(n,t) 4*c1*(1+sin(w*t)) * ((-1)^(n+1) + 1)/(n*pi)^3;
%Nested function so I can integrate
snIntegrand = @(n,t) @(tp) sn(n,t) * exp(-yn(n)*D_T*(t - tp));
heatTerm = @(n,t) integral(snIntegrand(n,t),0,t);

bigBn = @(n,t) sineTerm(n,t) + heatTerm(n,t);
generalT = @(n,x,t) bigBn(n,t) * sin( sqrt(yn(n)) * x);
%Make accumalator
T = zeros(res, 1);

figure(1)
for j = 1:6
    %Make accumalator
    T = zeros(res, 1);

    for i = 1:res
        for n = 1:N
            T(i) = T(i) + generalT(n, x(i), t(j));
        end
    end
    plot(x, T);
    hold on
end

hold off