"""
A time marching simulation determine what gear ratios and parameters we should run for optimal
performance
All UNITS ARE IN METRIC UNLESS STATED OVERWISE
"""

import math
import matplotlib.pyplot as plt

# Physical Constants
g = 9.81
rho_air = 1.22

#############
# Parameters
#############

theta = 0 * math.pi / 180  # deg to rad - gradient angle
r_wheel = 23 / 2 * 2.54 / 100  # in to m - wheel radius
m_vehicle = (420 + 160) / 2.2  # lbs to kg conversion - vehicle mass

# ASSUMPTION: Engine power is constant
#P_engine = 10 * 745.7  # HP to W conversion - engine power
omega_engine = 3800 * 2 * math.pi / 60  # RPM to rad/s
T_engine = 20

# NOTE: CVT reduction will change as vehicle gains speed
cvt_reduction_high = 3
cvt_reduction_low = 0.43
cvt_reduction_current = cvt_reduction_high  # At the start we have highest reduction
cvt_efficiency = 0.90  # No source for this

# ASSUMPTION: GEARBOX REDUCTION WON'T CHANGE DURING RACE
gearbox_reduction_high = 6.5
gearbox_reduction_low = 3
gearbox_reduction = gearbox_reduction_high
gearbox_efficiency = 0.97  # Typical value

# NOTE: Change chaindrive reduction when choosing sprockets
chaindrive_reduction = 27.0 / 13  # Driven over driving
chaindrive_efficiency = .95  # Typical values

# ASSUMPTION: No losses in half-shaft
total_efficiency = cvt_efficiency * gearbox_efficiency * chaindrive_efficiency

# Rolling Resistance
c_r = 0.08  # ATV conditions is .15

# Aerodynamic Resistance
# NOTE: Since dynamic force, will determine force in loop
c_d = 2
A_frontal = 30 * 50 * 2.54 ** 2 / 100 ** 2  # in^2 to m^2

# Initialize
h = .00005 # Time-step

t = [0]
i = 0

# Kinematics
s = [0]
v = [0]
a = []

# FORCES
F_drive = []
R_grad = []
R_drag = []
R_roll = []
F_net = []

while True:
    # Compute max possible speed allowed by wheel rotation assuming no slip
    v_max = omega_engine / (cvt_reduction_current * gearbox_reduction * chaindrive_reduction) * r_wheel

    # Adjust CVT as speed increases
    if v[i] > v_max - 1 and cvt_reduction_current > cvt_reduction_low:
        cvt_reduction_current = cvt_reduction_current - .01
        v_max = omega_engine / (cvt_reduction_current * gearbox_reduction * chaindrive_reduction) * r_wheel
    else:
        pass

    # Force Balance
    total_reduction = cvt_reduction_current * gearbox_reduction * chaindrive_reduction
    T_wheel = T_engine * total_reduction * total_efficiency  # Torque for both wheels
    F_drive.append(T_wheel / r_wheel)  # Driving force per wheel
    R_drag.append(0.5 * c_d * rho_air * A_frontal * v[i] ** 2)
    R_roll.append(m_vehicle * g * c_r)  # ASSUMPTION: Rolling resistance is static
    R_grad.append(m_vehicle * g * math.sin(theta))  # ASSUMPTION: grade is constant

    # Hard-coded for vehicle top speed
    if v[i] >= v_max and F_net[i] > 0:
        F_drive[i] = R_roll[i] + R_grad[i] + R_drag[i]

    F_net.append(F_drive[i] - (R_roll[i] + R_grad[i] + R_drag[i]))
    a.append(F_net[i] / m_vehicle)

    # BREAK POINTS
    error = 5
    if v[i] < 0: break
    if s[i] > 100: break
    if t[i] > 2000: break
    if F_net[i] < 0 + error : break

    v.append(v[i] + a[i] * h)
    s.append(s[i] + v[i] * h + 0.5 * a[i] * h ** 2)
    t.append(t[i] + h)

    i = i + 1

print("{0}m in {1} secs".format(s[-1], t[-1]))
# PLOT KINEMATICS
ax = plt.gca()
plt.figure(1)
plt.subplot(311)
plt.plot(t, a, 'r.')
plt.title('Acceleration, Velocity and Displacement Plots')
plt.ylabel(r'Acceleration $[m/s^2]$')
plt.gca().grid(True)
plt.subplot(312)
#v = [speed * 3.6 * 0.621371 for speed in v]
#s = [distance * 3.28084 for distance in s]
plt.plot(t, v, 'g.')
plt.ylabel(r'Velocity $[m/s]$')
plt.gca().grid(True)
plt.subplot(313)
plt.plot(t, s, 'b.')
plt.xlabel('Time $[s]$')
plt.ylabel(r'Displacement $[m]$')
plt.gca().grid(True)
plt.figure(2)
plt.title('Forces vs Time')
plt.xlabel('Time $[s]$')
plt.ylabel('Force $[N]$')
plt.plot(t, F_net, 'k.', label="F_net")
plt.plot(t, F_drive, 'g', label="F_drive")
plt.plot(t, R_roll, 'orange', label="R_roll")
plt.plot(t, R_drag, 'red', label="R_drag")
plt.legend(loc='upper right')
plt.gca().grid(True)
plt.figure(3)
plt.title("Velocity vs Distance")
plt.xlabel("Distance $[m]$")
plt.ylabel("Velocity $[m/s]$")
plt.plot(s,v)
plt.gca().grid(True)
plt.show()
