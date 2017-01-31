function [y] = crankNichol(A, y0, t)
%NOTE this is to solve damped pendulam
I = eye(size(A));
h = t(2) - t(1);
%Solve linear system Ux = b
%Where 
%U = (I - h/2 * A)
%x = y_n+1
%b = (I + h/2 * A) * y_n
y = zeros(2,length(t));
y(:,1) = y0;
for i = 1:length(t)-1
    %U = I - (h / 2) * A;
    %b = (I + (h / 2) * A) * y(:,i);
    %y(:,i+1) = b\U;
    U = (I - h * A);
    y(:,i+1) = y(:,i)\U;
end
end