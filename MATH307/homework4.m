hVector = linspace(1e-3, 1);
m = length(hVector);
nVector = zeros(m, 1);
condNumVector = zeros(m, 1);

%Q1 and Q2
for i = 1:m
    h = hVector(i); 
    x = 0:h:1;
    n = length(x);
    nVector(i) = n;
    A = makeTriDiag([-1, 2, -1], n);
    %BCs
    A(1,1) = 1;
    A(n,n) = 1;
    condNumVector(i) = cond(A);
end
figure(1)
plot(log(nVector), log(condNumVector));
coeff = polyfit(log(nVector), log(condNumVector), 1);
slope = coeff(1)
title('Size of matrix A vs condition number');
xlabel('log(n)');
ylabel('log(condition number of A)');

%Q3
clear all
hVector = linspace(1e-3, 1);
m = length(hVector);
nVector = zeros(m, 1);
condNumVector = zeros(m, 1);
k = 200;
for i = 1:m
    h = hVector(i); 
    x = 0:h:1;
    n = length(x);
    nVector(i) = n;
    c = k^2*h^2+2;
    A = makeTriDiag([-1, c, -1], n);
    %BCs
    A(1,1) = 1;
    A(n,n) = 1;
    condNumVector(i) = cond(A);
end
figure(2)
plot(log(nVector), log(condNumVector));
coeff = polyfit(log(nVector), log(condNumVector), 1);
slope = coeff(1)
title('Size of matrix A vs condition number with k = 200');
xlabel('log(n)');
ylabel('log(condition number of A)');
