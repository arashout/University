path = 'C:\Users\arash\OneDrive\MECHYearThree\MECH358\Homework\';
%Q1
%f = @(x) x;
f = @(x) x.^2;
%f = @(x) x.^2.*(2.*x-3);
x0 = 0;
xL = 1;
arrN = [1,5,10,100];
arrAn = zeros(length(arrN), 1);
h = .01;
xspan = x0:h:xL;
figure(1);
plot(xspan, f(xspan))
hold on
plotLines = {'s','*','o','+'};
for i = 0:length(arrN)-1
    n = arrN(i+1);
    arrAn = findFourierAns(f, n, x0, xL);
    fourier = buildFourierHandle(arrAn, x0, xL);
    yspan = fourier(xspan);
    plot(xspan, yspan, plotLines{i+1})
end
hold off
titleString = 'Fourier Approximation for f(x)=x^2';
filenameString = strcat(path,'functionX2.png');
title(titleString)
xlabel('x')
ylabel('y')
legend('Exact Function','N=1','N=5','N=10','N=100','Location','Northwest')
saveas(1, filenameString, 'png')

%Q3
fForA1 = @(xs, ts) 1 .* cos(1*pi.*xs) .* exp(-pi^2 * 1^2 .* ts);
fForA20 = @(xs, ts) -2 .* cos(20*pi.*xs) .* exp(-pi^2 * 20^2 .* ts);
fTxt = @(xs, ts) fForA1(xs,ts) + fForA20(xs,ts);
h = .001;
xsSpan = 0:h:1;
tsArr = [0, 10^-4, 10^-3, 10^-2, 10^-1];

figure(2)
hold on
for i = 1:length(tsArr)
    tsSpan = ones(1, length(xsSpan)) * tsArr(i);
    yspan = fTxt(xsSpan, tsSpan);
    plot(xsSpan, yspan);
end
hold off
title('Fourier series vs time')
xlabel('x')
ylabel('y')
filenameString = strcat(path,'Question3c.png');
legend('tD_t/L^2=0','tD_t/L^2=10^-4','tD_t/L^2=10^-3','tD_t/L^2=10^-2', ...
        'tD_t/L^2=10^-1','Location','Southwest')
saveas(2, filenameString, 'png')