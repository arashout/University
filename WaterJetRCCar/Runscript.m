clear all

N = 100;
%Speed
reqD = 11.5; %Required Distance

%Interpolate Minor Loss base on physical data 
D_N_Table = [2.5,3,3.5]/1000;
K_m_Table = [1.5,3,5.1];
D_N = linspace(2.5/1000,3.5/1000,N);
K_m = interp1(D_N_Table,K_m_Table,D_N);

Fill = linspace(0,1,N);
[X,Y] = meshgrid(D_N,Fill);
d =[];
t = [];
for i = 1:length(D_N)
    for k = 1:length(Fill)
        [d(i,k),t(i,k)] = SimFun(Fill(k),reqD,D_N(i),K_m(i));
    end
end
fail = find(d < reqD);
t(fail) = 9999;
Vavg = reqD./t;
figure(1)
surf(X,Y,Vavg')
colorbar
title('Speed Round','FontSize',12,'FontWeight','bold');
xlabel('Nozzle Diameter [m]','FontSize',12,'FontWeight','bold');
ylabel('Fill Factor','FontSize',12,'FontWeight','bold');
zlabel('Average Velocity [m/s]','FontSize',12,'FontWeight','bold');
print('-dpng', 'SpeedRound' , '-r300');
savefig('SpeedRound.fig')

%Distance Round
reqD = 100;

d =[];
t = [];
for i = 1:length(D_N)
    for k = 1:length(Fill)
        [d(i,k),t(i,k)] = SimFun(Fill(k),reqD,D_N(i),K_m(i));
    end
end
figure(2)
surf(X,Y,d')
colorbar
title('Distance Round','FontSize',12,'FontWeight','bold');
xlabel('Nozzle Diameter [m]','FontSize',12,'FontWeight','bold');
ylabel('Fill Factor','FontSize',12,'FontWeight','bold');
zlabel('Distance [m]','FontSize',12,'FontWeight','bold');
print('-dpng', 'DistanceRound' , '-r300');
savefig('DistanceRound.fig')








