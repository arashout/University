function [y1, y2, x] = shootingMethod2ndOrder(f1, f2, b1, b2, x)
%Assuming Dirichet Boundary Conditions
%Use RK2 built-in during assignment 2

%Setup
tolerance = 10e-3;
iterations = 50;
%Get the step size
h = x(2) - x(1);
%Pre-allocate row vectors
y1 = zeros(length(x), 1);
y2 = zeros(length(x), 1);
%Set boundary conditions
y1(1) = b1(1);
y1(end) = b2(1);

%Note: That you need 2 guesses and 2 resulting BC
y2(1) = rand(1);
g = y(1); %For previous guess

for i=1:iterations
    initV = [y1(1), y2(1)]; %Initial Conditions
    [y1, y2] = rk2Pend(f1, f2, initV , t);
    if y1(end)^2 < tolerance
        string = sprintf('Converged in %d iterations',i);
        disp(string);
        break
    end
    %Make another guess using secant method
end
end