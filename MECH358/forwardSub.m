function x = forwardSub(P, L, U, b)
    Pb = P * b; %Pb is a vector!!
    z = solveLowerTri(L, Pb);
    x = solveUpperTri(U,z);
end

function x = solveLowerTri(A, b)
    [n,~] = size(A);
    x = zeros(n,1);
    for i=1:n
        sumLine = b(i);
        for j=1:(i-1)
            sumLine = sumLine - A(i,j) * x(j);
        end
        x(i) = sumLine/A(i,i); 
    end
end
function x = solveUpperTri(A, b)
    [n,~] = size(A);
    x = zeros(n,1);
    for i=n:-1:1
        sumLine = b(i);
        for j=n:-1:(i+1)
            sumLine = sumLine - A(i,j) * x(j);
        end
        x(i) = sumLine/A(i,i); 
    end
end