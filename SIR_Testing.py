import numpy as np
import matplotlib.pyplot as plt

# TESTING PROGRAM DO NOT SUBMIT/COPY

# SIR parameters
beta = 0.3
gamma = 0.1

# Initial conditions
S0, I0, R0 = 0.99, 0.01, 0.0
t0, T = 0, 100  # Start and end time
h = 0.1  # Time step

# Define the system of equations
def sir_model(t, y):
    S, I, R = y
    dS = -beta * S * I
    dI = beta * S * I - gamma * I
    dR = gamma * I
    return np.array([dS, dI, dR])

# Runge-Kutta 4th order method
def rk4_step(f, t, y, h):
    k1 = h * f(t, y)
    k2 = h * f(t + h/2, y + k1/2)
    k3 = h * f(t + h/2, y + k2/2)
    k4 = h * f(t + h, y + k3)
    return y + (k1 + 2*k2 + 2*k3 + k4) / 6

# Time-stepping
times = np.arange(t0, T, h)
solution = np.zeros((len(times), 3))
solution[0] = [S0, I0, R0]

for i in range(1, len(times)):
    solution[i] = rk4_step(sir_model, times[i-1], solution[i-1], h)

# Plot results
plt.plot(times, solution[:, 0], label='S')
plt.plot(times, solution[:, 1], label='I')
plt.plot(times, solution[:, 2], label='R')
plt.xlabel('Time')
plt.ylabel('Proportion')
plt.legend()
plt.show()
