# -*- coding: utf-8 -*-
"""
Created on Sat Jan 30 23:25:27 2016

@author: arash
"""
import math
import matplotlib.pyplot as plt
import pprint
import time
import numpy as np
##Experimental Variables
d_n = 0.0039 #Nozzle Diameter [m]
f = .7 #Fill Factor
k_m = 5.0 #Minor Loss Co-efficient
c_r = 0.011 #Rolling Resistance Co-efficent

##Vehicle Constants
m_v = 0.797 #Mass of vehicle [kg]
A_n = d_n**2/4*math.pi #Nozzle Area [m^2]
V_b = 0.002 #Total volume of bottle in [m^3]

##Physical Constants
g = 9.81 #Gravity [m/s^2]
rho_Propellant = 998 #Density of propellant (water) [kg/m^3]
gamma_Air = 1.4 #Heat Capacity ratio of air
P_0 = 101325 #Atmospheric Pressure [Pa]

##Estimated Drag Values
c_d = 0.8 #Drag Co-efficient of frontal area like BUS
A_f = 5*6*0.0254**2 #Frontal Area in^2 -> [m^2] 
rho_Air = 1.2 #Density of Air [kg/m^3]
CD = c_d*0.5*rho_Air*A_f #One constant for drag for shorthand

##Initial Values
t = [0] #Time for graphing [s]

P = [P_0 + 50*6894.75] #Air Pressure psi -> [Pa]
V_a = [V_b*(1-f)] #Volume of Air [m^3]
C = P[0]*V_a[0]**gamma_Air #Isentropic Constant of Air C=PV^k
V_p = [V_b*f] #Volume of Propellant (water) [m^3]
m = [m_v + rho_Propellant*V_p[0]]; #Total Mass [kg]
vel_p = [] #Propellant Exit velocity (water) [m/s]

s = [0]; #Displacement [m]
v = [0]; #Velocity [m/s]
a = []; #Acceleration [m/s^2]

T = []; #Thrust [N]
D = []; #Drag Resistance [N]
R = []; #Rolling Resistance [N]
F = []; #Net Force [N]

i = 0 #Index
plt.ion()
plt.show()
#Simulation Settings
h = 0.01; #Program Time-Step
while True:
    #If pressure too low to propel fuel
    if P[i] < P_0:
        vel_p.append(0)
    else:
        vel_p.append((2*(P[i]-P_0)/(rho_Propellant*(1+k_m)))**0.5) #Water Velocity from Bernoulli's [m/s]
    #FORCE BALANCE
    T.append(vel_p[i]**2*A_n*rho_Propellant) #Thrust from momentum flux [N]
    D.append(CD*v[i]**2) #Aerodynamic Drag [N]
    R.append(c_r*m[i]*g) #Rolling Resistance [N]
    F.append(T[i] - (D[i] + R[i])) #Net Force [N]
    
    #KINEMATICS
    a.append(F[i]/m[i]) #Current Acceleration [m/s^2]
    v.append(v[i] + a[i]*h) #New Velocity [m/s]
    s.append(s[i] + v[i]*h + 0.5*a[i]*h**2) #New Displacement [m]
    
    #
    V_p.append(V_p[i] - vel_p[i]*A_n*h) #New Volume of Water [m^3]
    V_a.append(V_b - V_p[i+1]) #New Volume of Air [m^3]
    P.append(C/V_a[i+1]**gamma_Air) #New Pressure [Pa]
    m.append(m_v + V_p[i+1]*rho_Propellant)
    t.append(t[i]+h)
    
    #If ran out of fuel
    if V_p[i+1] <= 0:
        V_p[i+1] = 0
        V_a[i+1] = V_b
        P[i+1] = P_0
    if v[i+1] <= 0:
        break
    plt.figure(1)
    plt.scatter(t[i],s[i])
    plt.figure(2)
    plt.scatter(t[i],v[i])
    i = i + 1
    plt.pause(h) 
#Make the arrays same length for plotting
vel_p.append(0)
a.append(0)
T.append(0)
D.append(0)
R.append(c_r*m[-1]*g)
F.append(c_r*m[-1]*g)
