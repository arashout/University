maxSize = 1000;
numTrials = 1;
nVector = [1:maxSize];
t = zeros(numTrials, maxSize);
for i = 1:numTrials
    for n = nVector
        A = rand(n,n);
        b = rand(n,1);
        tic;
        x = A\b;
        t(i,n) = toc;
    end
end
meanTimes = mean(t,1);
plot(log(nVector), log(meanTimes))