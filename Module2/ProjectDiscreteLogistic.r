# MCSB Bootcamp
# VStudent - Project 3.1 Discrete logistic

# simulation parameters
ntMax <- 1000
nParam <- 1000

# model parameters to sweep through
rArray <- seq(from=0.1, to=2.99, length.out=nParam)

# data collection
xSS <- matrix(0, nrow=nParam, ncol=300)

# loop through parameters
for(iParam in 1:nParam){
  
  # model parameters
  r <- rArray[iParam]
  K <- 0.6
  
  x <- numeric(ntMax)
  
  # initial condition
  x[1] <- 0.5
  
  # loop through time
  for(nt in 1:(ntMax - 1)){
    x[nt + 1] <- x[nt] + r * (1 - x[nt]/K) * x[nt]
  }
  
  # data analysis and collection
  if(FALSE){
    plot(x[1:100], type='l', xlab='Time', ylab='Population')
  } # finished plotting time series
  
  xSS[iParam,] <- tail(x, n=300)
  
} # finished loop through parameters

# Save data to file
save(xSS, file='xSS.RData')

# Load data from file
load('xSS.RData')

# plot parameter-sweep diagram
plot(0, 0, type='n', xlim=c(min(rArray), max(rArray)), ylim=c(min(xSS), max(xSS)), xlab='Growth rate r', ylab='Population')
for(i in 1:nParam){
  points(rep(rArray[i], times=300), xSS[i,], pch='.')
}
