%Assignment 1
num = 20;
a = randi(num);
m = randi(num);
n = randi(num);
f = @(x) x^m - a^n;
dfdx = @(x) m * x ^ (m - 1);
[root, k] = newt(f, dfdx, 1, 1);
%Assignment 2
omega = 1;
kappa = .1;
h = .01;
t = 0:h:100;
y0 = [-pi; 1];
%Linearized Crank-Nichol
A = [0, 1; -omega^2, -kappa];
y = linCrankNichol(A, y0, t);
figure(1)
plot(t, y(1,:));
title('Linearized Crank-Nicholson')
xlabel('Time (s)')
ylabel('Theta (rad)')

%Non-Linear Range Kutta 4
f1 = @(y1, y2) y2;
f2 = @(y1, y2) -omega^2 * sin(y1) - kappa * y2;
yRK = rk4Pend(f1,f2,y0,t);
figure(2)
plot(t, yRK);
title('Non-linear RK4')
xlabel('Time (s)')
ylabel('Theta (rad)')

%Comparing Methods
figure(3)
plot(t, y(1,:))
hold on
plot(t, yRK)
title('Comparing Different Methods')
xlabel('Time (s)')
ylabel('Theta (rad)')
legend('Linearized Crank-Nichol','Non-Linear RK4')
hold off
