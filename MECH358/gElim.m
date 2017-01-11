%MECH 358 - 2017
%ASSIGNMENT #1
%Arash Outadi

%Q2 -  Gaussian elimination with pivoting
function U = gElim(A)
    %Assume A is square NxN
    [N,~] = size(A);
    U = A;
    P = eye(N);
    L = zeros(N);
    
    
    c = 1; %Start on column 1
    for r = 1:(N-1)
        if U(r,c) == 0
            %Find largest element in column
            colVector = U(r:end,c);
            [~, iMax] = max(colVector);
            iMax = iMax + r - 1;
            %Swap rows!
            U([r iMax],:) = U([iMax r],:);
            P([r iMax],:) = P([iMax r],:);
            %In the first pass nothing is in L, will this be an issue?
            L([r iMax],:) = L([iMax r],:); 
        end
        
        for i = r+1:N
            %Determine elimination factor if required
            if U(i,c) ~= 0
                f = U(i,c)/U(r,c);
                %Apply to U
                U(i,:) = U(i,:) - f * U(r,:);
                %Add to L
                L(i,c) = f;
            end
        end
        c = c + 1;
    end
    U
    P
    L = L + eye(N)
end