import numpy as np
import matplotlib.pyplot as plt

# How much caffeine is there in the jar?

# n - number of days
# x - fraction of caffeinated 

nMax = 20  # max number of days to simulate

N = 10  # number of scoops in each jar
x = np.zeros(nMax)  # fraction caffeinated
x[0] = 1.0  # initial fraction caffeinated

for n in range(1, nMax):
    x[n] = (1-1/N) * x[n-1]
    #x[n] = x[n-1] - 1/N*x[n-1]
    
# THE MODEL ^
# ------------------------------------------
# THE BEHAVIOR / THE OUTPUT ? 

plt.figure(1)
plt.plot(x, '-ok')
plt.ylabel('fraction caffeinated')
plt.xlabel('Days')
plt.show()
