function [y] = crankNichol(A, y0, t)
%NOTE this is to solve damped pendulam

%Setting up values
h = t(2) - t(1);
y = zeros(2,length(t));
y(:,1) = y0;
%For convinience
scaledA = h/2 * A;
I = eye(size(A));

sigma = inv((I - scaledA)) * (I + scaledA);

for n = 1:length(t)-1
    y(:,n+1) = sigma * y(:,n);
end

end