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
h = .01;
xspan = TA(2):h:TB(2);
%Question 1
[T, Tprime] = shootingMethod2ndOrder(f1, f2, TA, TB, xspan);
figure(1)
plot(xspan,T);
xlabel('x')
ylabel('T')