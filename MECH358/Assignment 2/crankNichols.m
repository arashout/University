function [y] = crankNichols(f , J, invJ, y0, t, m)
h = t(2) - t(1);
y = zeros(m,length(t));
y(:,1) = y0;
for i = 1:length(t)-1

end
end