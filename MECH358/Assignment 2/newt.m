function [root, x, k] = newt(a, M, N)
tolerance = 1e-10;
fx = @(x) x^M - a^N;
dfx = @(x) M*x^(M-1);
maxIter = 1000;
x = zeros(maxIter + 1, 1);
x(1) = rand(1) * a;
for k=1:maxIter
    x(k+1) = x(k) - fx(x(k))/dfx(x(k));
    error = x(k+1) - x(k);
    if error^2 < tolerance;
        break
    end
end
%Truncate empty zeros
x = x(1:k+1);
root = x(end);
if k == maxIter
   fprintf('Solution did not converge');
else
   fprintf('%i Iterations to converge on: %f\n', [k,root]); 
end

end