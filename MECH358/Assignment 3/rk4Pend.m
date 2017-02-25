function [y,z] = rk4Pend(f1, f2, initV, t)
h = t(2) - t(1);
%Sizes for convenience
n = length(t);

y = zeros(1, n);
z = zeros(1, n);

y(1) = initV(1);
z(1) = initV(2);

for i = 1:length(t) - 1
    k0 = h * f1(y(i), z(i), t(i));
    l0 = h * f2(y(i), z(i), t(i));
    
    k1 = h * f1(y(i) + k0*0.5, z(i) + l0*0.5, t(i) + h*0.5);
    l1 = h * f2(y(i) + k0*0.5, z(i) + l0*0.5, t(i) + h*0.5);
    
    k2 = h * f1(y(i) + k1*0.5, z(i) + l1*0.5, t(i) + h*0.5);
    l2 = h * f2(y(i) + k1*0.5, z(i) + l1*0.5, t(i) + h*0.5);
    
    k3 = h * f1(y(i) + k2, z(i) + l2, t(i) + h);
    l3 = h * f2(y(i) + k2, z(i) + l2, t(i) + h);
    
    y(i+1) = y(i) + k0/6 + k1/3 + k2/3 + k3/6;
    z(i+1) = z(i) + l0/6 + l1/3 + l2/3 + l3/6;  
end
end