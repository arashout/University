function [y] = crankNichol(A, y0, t)
%NOTE this is to solve damped pendulam
I = eye(size(A));
h = t(2) - t(1);
%Solve linear system Ax = b
%Where 
%A = (I - h/2 * A)
%x = y_n+1
%b = (I + h/2 * A) * y_n
y = zeros(2,length(t));
y(:,1) = y0;
scaledA = h/2 * A; %I have to repeat this operation a lot
for i = 1:length(t)-1
    pretend_A = (I - scaledA);
    pretend_b = (I + scaledA) * y(:,i);
    y(:, i + 1) = pretend_b' / pretend_A;
end
end