function [fourierFunction] = buildFourierHandle(arrAns, lb, ub)
    a0 = arrAns(1);
    fourierFunction = @(x) a0/2;
    nextHandle = @(an, n, lb, ub, x) @(x) an .* cos(n*pi*x/(ub-lb));
    for i = 1:length(arrAns)-1
        %Next handle only as function of x
        nextHandleX = nextHandle(arrAns(i+1), i, lb, ub);
        fourierFunction = @(x) fourierFunction(x) + nextHandleX(x);
    end
end