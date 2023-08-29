# How much caffeine is there in the jar?

# n - number of days
# x - fraction of caffeinated

nMax <- 20 # max number of days to simulate

N <- 10 # number of scoops in each jar
x <- rep(0, nMax) # fraction caffeinated
x[1] <- 1.0 # initial fraction caffeinated

for (n in 2:nMax) {
  x[n] <- (1 - 1/N) * x[n-1]
}

# THE MODEL ^
# ------------------------------------------
# THE BEHAVIOR / THE OUTPUT ? 

plot(x, type='o', pch=16, col='black', ylab='fraction caffeinated', xlab='Days')
