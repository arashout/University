%MECH 358 - 2017
%ASSIGNMENT #1
%Arash Outadi

%Q1 - Summing Series

%Function that approximates e^x
function s = approxExp(x,n)
    s = 0;
    for i = 0:n
        numer = x^i;
        denom = factorial(i);
        s = s + numer/denom ;
    end
end