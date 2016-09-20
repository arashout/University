%Simulation Rev2
function [s_max,t,t_water] = SimFun(f,distance,D_N,K_m )
%Variables to Adjust
%D_N = 3.9/1000; %Nozzle Diameter
%f = .5; %Filling Factor
%K_m = 5; %Minor Loss Co-efficient
c_r = .011; %Rolling Co-Efficient
%distance = 100; %Maximum distance required

%Constants
m_v = 0.793787; %Mass of vehicle with empty bottle
V = 2/1000; %Volume of the a 2L bottle
g = 9.81; %Gravity
rho = 998; %Density of propellant: Water
gamma = 1.4; %Gamma for air, Cp/Cv
P0 = 101*1000; %Atmospheric Pressure

%Drag
c_d = .8; %Engineering ToolBox - Shaped Like a Bus
A_f = 5*2.54/100*6*2.54/100; %Frontal Area
rho_a = 1.2; %Air Density
C_D = c_d/2*rho_a*A_f; %One Constant for Drag, for shorthand

%%Initial Values
A_N = pi*D_N^2/4; %Area of Nozzle
P = P0 + 50*6894.75729; %Initial Absolute Pressure
Va = (1-f)*V;%Volume of air
Vw =  V*f;%Volume of water

%Air Mass
Temp0 = 25+273.15;%Temperature of Air
R = 287;%Gas Constant for Air
m_a = P*Va/(Temp0*R); %Mass of Air
m_v = m_v + m_a; %Add Mass of Air to Vehicle Mass

C = P*Va^gamma; %Isentopric constant for PV^k

%Initialize arrays changing with time
h = 1/10; %Time step in secs
t = 0; %Initial Time
t_water = 0; %Time to empty
s = 0; %Initial Position
v = 0; %Initial Velocity

m = []; %Changing Mass
vel = []; %Exit Velocity of Propellant

T = []; %Thrust
D = []; %Drag Resistance
R_r = []; %Rolling Resistance
F = []; %Net Force

a = []; %Vehicle Acceleration

%Straight Segment

for i = 1:9999
    
    t = t + h;
    m(i) = rho*Vw(i) + m_v; %New Mass of Body - Changing due to loss of water
    vel(i) = sqrt(2*(P(i)-P0)/(rho*(1+K_m))); % Via Bernoulli with Gage Pressure
    
    if Vw(i) <= 0 %If no more water
        Vw(i+1) = 0;
        Va(i+1) = 2/1000;
        P(i+1) = P0;
        
    else
        t_water = t_water + h; %Keep track of water thrust phase
        deltaV = vel(i)*A_N*h; %Volume of Water Exiting Bottle
        Vw(i+1) = Vw(i) - deltaV; %New Volume of Water
        Va(i+1) = V - Vw(i+1); %New Volume of Air
        P(i+1) = C/Va(i+1)^gamma; %New Pressure
    end

    %Forces
    T(i) = vel(i)^2*A_N*rho; %Momemtum Flux
    D(i) = C_D*v(i)^2; %Aerodynamic Drag
    R_r(i) = c_r*m(i)*g; %Rolling Resistance
    F(i) = T(i) - (D(i)+R_r(i)); %Net Force
    
    %Kinematics
    a(i) = F(i)/m(i); %Curent acceleration
    v(i+1) = v(i) + a(i)*h; %Next velocity
    s(i+1) = s(i) + v(i)*h + .5*a(i)*h^2; %Next position
    
    s_max = s(end);
    
    if s(i) >= distance %If Vehicle Reaches Required Distance
        break
    end
    
    if v(i+1) <= 0  %If Vehicle Stops Moving Forward: Break
        break
    end
    
end
s(end) = []; %Remove uncessary calculations
v(end) = []; %Remove unnecessary calculations

s_max = real(s_max); %Remove any complex stuff so you can graph

end