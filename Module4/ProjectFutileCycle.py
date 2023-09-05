import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

# MCSB Bootcamp
# VStudent - Project X Saturated futile cycle

# Goldbeter & Koshland 1981
# https://en.wikipedia.org/wiki/Ultrasensitivity#Saturation_mechanisms_(Zero-order_ultrasensitivity)

# simulation parameters
nParam = 100

# model parameters to sweep through
KTotArray = np.logspace(-3, 2, nParam)

# data collection
A_SS = np.zeros(nParam)

# loop through parameters
for iParam in range(nParam):
    
    # model parameters to sweep through
    KTot = KTotArray[iParam]
    
    # model parameters
    ITot = 1
    PTot = 1
    konA = 10
    koffA = 10
    kcatI = 10
    konI = 10
    koffI = 10
    kcatA = 100
    
    # model equations
    def dxdt(x, t):
        A, AP, I, IK = x
        return [
            -konA * (PTot - AP) * A + koffA * AP + kcatA * IK,
            konA * (PTot - AP) * A - koffA * AP - kcatI * AP,
            -konI * (KTot - IK) * I + koffI * IK + kcatI * AP,
            konI * (KTot - IK) * I - koffI * IK - kcatA * IK,
        ]
    
    # solve system
    T = np.linspace(0, 100, 1000)
    X = odeint(dxdt, [0, 0, ITot, 0], T)
    
    if False:
        ## plot and analyze
        plt.figure(1)
        plt.plot(T, X)
        plt.legend(['A', 'AP', 'I', 'IK'])
        
        # fraction active
        plt.figure(2)
        fracA = X[:, 0] / np.sum(X, axis=1)
        plt.plot(T, fracA)
        plt.show()
    
    # data collection
    A_SS[iParam] = X[-1, 0]

## analysis

plt.figure(1)
plt.plot(KTotArray, A_SS, '-x')
plt.xlabel('Kinase concentration KTot')
plt.ylabel('Steady state in active form A')
plt.xscale('log')
plt.grid(True) # equivalent to box on in MATLAB
plt.show()
