% %MECH 358 - 2017
% %ASSIGNMENT #1
% %Arash Outadi
% 
% %Q1 - Summing Series
% oneA = approxExp(.1,10);
% oneB = approxExp(100,1000); %Probably explodes???
% oneC = @(x,N) abs(exp(x)-approxExp(x,N))/exp(x)*100; %Very small as N increases, obvs
% oneCA = oneC(.1,10);
% oneCB = oneC(100,1000);
% errorVector = zeros(1, 100 - 10);
% nVector = 10:1:100;
% i = 1;
% for N=10:1:100
%     errorVector(i) = oneC(10,N);
%     i = i + 1;
% end
% figure(1)
% oneD = plot(nVector, errorVector);
% xlabel('N');
% ylabel('%-error');
% title('Error in exponential function approximation');

% %Q2 -  Gaussian elimination with pivoting
% %twoA - twoE
% A = [2 1 0;4 2 1;0 2 4];
% b = [1; 4 ; 14];
% [P, L ,U ] = gElim(A);
% forwardSub(P, L, U, b);
% %twoF
% A = [4 8 12 -8; 1 2 -3 4; 2 3 2 1; -3 -1 1 -4];
% b = [60;3;1;5];
% [P, L ,U ] = gElim(A);
% x = forwardSub(P, L, U, b);
% %twoG
n = 10;
A = round(rand(n, n)* 10);
b = round(rand(n, 1) * 10);
[P, L ,U ] = gElim(A);
Ac = round(inv(P) * L * U);
isequal(A,Ac)
% A = [1 0  2; 1 0 7; 3 0 4];
% b = [60;3;1;5];
% [P, L ,U ] = gElim(A);
% Ac = round(inv(P) * L * U);
% U