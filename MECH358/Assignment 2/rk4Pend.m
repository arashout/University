function [y] = rk4Pend(f, g, initV, t)
h = t(2) - t(1);
%Sizes for convenience
n = length(t);

y = zeros(1, n);
z = zeros(1, n);

y(1) = initV(1);
z(1) = initV(2);

for i = 1:length(t)-1
    k0 = h * f( y(i), z(i) );
    l0 = h * g( y(i), z(i) );
    
    k1 = h * f( y(i) + k0*0.5, z(i) + l0*0.5);
    l1 = h * g( y(i) + k0*0.5, z(i) + l0*0.5);
    
    k2 = h * f( y(i) + k1*0.5, z(i) + l1*0.5);
    l2 = h * g( y(i) + k1*0.5, z(i) + l1*0.5);
    
    k3 = h * f( y(i) + k2, z(i) + l2);
    l3 = h * f( y(i) + k2, z(i) + l2);
    
    y(i+1) = y(i) + 1/6 * (k0 + 2*k1 + 2*k2 + k3);
    z(i+1) = z(i) + 1/6 * (l0 + 2*l1 + 2*l2 + l3);  
end
end