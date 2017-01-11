% %MECH 358 - 2017
% %ASSIGNMENT #1
% %Arash Outadi
% 
% %Q1 - Summing Series
% oneA = approxExp(.1,10)
% oneB = approxExp(100,1000) %Probably explodes???
% oneC = @(x,N) abs(exp(x)-approxExp(x,N))/exp(x)*100; %Very small as N increases, obvs
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

%Q2 -  Gaussian elimination with pivoting
A = [2 1 0;4 2 1;0 2 4];
A = [2 1 0 2; 4 2 1 1; 0 2 4 4; 5 6 7 8];
gElim(A)
