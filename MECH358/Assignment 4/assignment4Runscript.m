%Q1
%f = @(x) x;
%f = @(x) x.^2;
f = @(x) x.^2.*(2.*x-3);
x0 = 0;
xL = 1;
arrN = [1,5,10,100];
arrAn = zeros(length(arrN), 1);
h = .01;
xspan = x0:h:xL;
path = 'C:\Users\arash\OneDrive\MECHYearThree\MECH358\Homework\';
for i = 0:length(arrN)-1
    n = arrN(i+1);
    arrAn = findFourierAns(f, n, x0, xL);
    fourier = buildFourierHandle(arrAn, x0, xL);
    yspan = fourier(xspan);
    figure(1);
    plot(xspan, yspan)
    titleString = sprintf('Fourier Approximation for f(x)=x^2*(2*x-3) with N=%d',n);
    filenameString = strcat(path,sprintf('functionXPoly%d.png',n));
    title(titleString)
    xlabel('x')
    ylabel('y')
    saveas(1, filenameString, 'png')
end


