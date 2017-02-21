function [u, v, x] = shootingMethod2ndOrder(f1, f2, b1, b2, x)
%Assuming Dirichet Boundary Conditions
%Use RK4 built-in during assignment 2

%Setup
tolerance = 10e-3;
iterations = 50;
%Get the step size
h = x(2) - x(1);
%Pre-allocate row vectors
u = zeros(length(x), 1);
v = zeros(length(x), 1);
%Set boundary conditions
u(1) = b1(1); %TA(1) == 5
u(end) = b2(1); %TB(2) == 4

%Start renaming variables in same way as notes LOL
%Because i am easily confused
ul = u(end);

%Note: That you need 2 guesses and 2 resulting BC

%Guess 1
v(1) = rand;
initV = [u(1), v(1)]; %Initial Conditions
[u, v] = rk4Pend(f1, f2, initV , x);
v01 = v(1); %first guess
ul1 = u(end); %T at x=L for first guess
%Guess 2
v(1) = rand;
initV = [u(1), v(1)]; %Initial Conditions
[u, v] = rk4Pend(f1, f2, initV , x);
v02 = v(1); %second guess
ul2 = u(end); %T at x=L for second guess

for i=3:iterations
    %Make another guess using secant method
    v03 = v02 + (v02 - v01)/(ul2 - ul1)*(ul-ul2);
    %SOLVE IVP
    initV = [u(1), v03]; %Initial Conditions
    [u, v] = rk4Pend(f1, f2, initV , x);
    
    %Check if converged!
    diff = abs(u(end) - ul);
    if  diff < tolerance
        string = sprintf('Converged in %d iterations',i);
        disp(string);
        return
    end
    
    %Update guess for next secant method
    ul1 = ul2;
    ul2 = u(end);
    v01 = v02;
    v02 = v03;
end

string = sprintf('Did not converge');
disp(string);

end