import numpy as np
import matplotlib.pyplot as plt

# MCSB Bootcamp
# VStudent - Project 3.1 Discrete logistic

# simulation parameters
ntMax = 1000
nParam = 1000

# model parameters to sweep through
rArray = np.linspace(0.1,2.99,nParam)

# data collection
xSS = np.zeros((nParam,300))

# loop through parameters
for iParam in range(nParam):
    
    # model parameters
    r = rArray[iParam]
    K = 0.6
   
    x = np.zeros(ntMax)
    
    # initial condition
    x[0] = 0.5
    
    # loop through time
    for nt in range(ntMax-1): # note that in python array index starts from 0, thus ntMax-1
        x[nt+1] = x[nt] + r*(1-x[nt]/K)*x[nt]
    
    # data analysis and collection
    if False: # equivalent to if 0 in MATLAB
        plt.figure(1)
        plt.plot(x[0:100], 'ok') # '-ok' not recognized in python matplotlib
        plt.xlabel('Time')
        plt.ylabel('Population')
        plt.grid(True) # equivalent to box on in MATLAB
        plt.show() # equivalent to figure(1); clf; hold on;
    
    xSS[iParam,:] = x[-300:] # equivalent to x((end-size(xSS,2)+1):end)

# save the data to a binary file in NumPy `.npy` format
np.save('xSS.npy', xSS)

# analysis

# load the data from the binary file
xSS = np.load('xSS.npy')

# plot parameter-sweep diagram
plt.figure(2)
plt.plot(rArray, xSS, '.') # note that '.' is the equivalent of '.' in MATLAB
plt.ylabel('Population')
plt.xlabel('Growth rate r')
plt.grid(True) # equivalent to box on in MATLAB
plt.show()
