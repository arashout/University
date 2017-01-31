function [y] = crankNichols(f, y0, t)
%NOTE this is to solve damped pendulam
h = t(2) - t(1);
y = zeros(2,length(t));
y(:,1) = y0;
for i = 1:length(t)-1

end
end