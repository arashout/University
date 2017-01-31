function [root, k, converged] = newt(f, invJ, m, verbose)
%m is the size of the vector function
tolerance = 1e-10;
maxIter = 1000;
x = zeros(m, maxIter + 1);
x(:,1) = rand(m,1);
converged = 0;

if m > 1 %For the vector cases
    for k=1:maxIter
        x_k = num2cell((x(:,k)));
        x(:,k+1) = x(:,k) - invJ(x_k{:}) * f(x_k{:});
        error = norm(x(k+1,:)) - norm(x(k,:));
        if error^2 < tolerance;
            converged = 1;
            break
        end
    end
    root = x(:,k+1);
else %For the scalar case
    dfdx = invJ; %In scalar case we just use derivative
    for k=1:maxIter
        x(k+1) = x(k) - f(x(k)) / dfdx(x(k));
        error = x(k+1) - x(k);
        if error^2 < tolerance;
            converged = 1;
            break
        end
    end
    root = x(k+1);
end

if verbose
    if converged == 0
       fprintf('Solution did not converge');
    else
       fprintf('%i Iterations to converge on: %f\n', [k,root]); 
    end
end
end