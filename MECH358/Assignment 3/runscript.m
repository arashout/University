a = @(x) -1*(x + 3)/(x + 1);
b = @(x) (x + 3)/(x + 1)^2;
f = @(x) 2*(x + 1) + 3 * b(x);
%Split 2 second order ODE into 2 first order ODEs
f1 = @(y1,y2,x) y2; %=dT/dx
f2 = @(y1,y2,x) f(x) - b(x)*y1 - a(x)*y2; %=d^2T/dx^2
%Boundary Conditions
TA = [5, 0]; %TA=5 @ x = 0
TB = [4, 2]; %TB=4 @ x = 2
%Step size and span
h = .1;
xspan = TA(2):h:TB(2);
%Question 1
[TShoot, Tprime] = shootingMethod2ndOrder(f1, f2, TA(1), TB(1), xspan);
figure(1)
plot(xspan,TShoot,'g*');
title('T vs x');
xlabel('x');
ylabel('T');
hold on
%Question 2
%Create convience functions
gamma = @(x) 1/h^2 - a(x)/(2*h);
beta = @(x) b(x) - 2/h^2;
alpha = @(x) 1/h^2 + a(x)/(2*h);
TFinite = finiteDiffDirichlet(gamma, beta, alpha, f, TA(1), TB(1), xspan);
plot(xspan,TFinite);
legend('Shooting Method','Finite Differences')
hold off