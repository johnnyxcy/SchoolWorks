par(mfrow = c(1,3))
a1 = 0.9
a2 = 0.1
a1prime = 4.9
a2prime = 1.1
thetas = seq(0,1,0.01)

plot(beta(thetas, c(a1,a2)) ~ thetas, type = 'l', col = 'red',
     main = 'a1 = 0.9, a2 = 0.1')
lines(beta(thetas, c(a1prime, a2prime)) ~ thetas, col = 'blue')
abline(v = 0.2, col = 'green')
legend('topright', col = c('red', 'blue', 'green'), 
       legend = c('prior', 'posterior', 'theta_2_ML'), lty = c(1,1,1), 
       lwd = c(1,1,1))

a1 = 2
a2 = 3
a1prime = 6
a2prime = 4
thetas = seq(0,1,0.01)

plot(beta(thetas, c(a1,a2)) ~ thetas, type = 'l', col = 'red',
     main = 'a1 = 2, a2 = 3')
lines(beta(thetas, c(a1prime, a2prime)) ~ thetas, col = 'blue')
abline(v = 0.2, col = 'green')
legend('topright', col = c('red', 'blue', 'green'), 
       legend = c('prior', 'posterior', 'theta_2_ML'), lty = c(1,1,1), 
       lwd = c(1,1,1))

a1 = 20
a2 = 20
a1prime = 24
a2prime = 21
thetas = seq(0,1,0.01)

plot(beta(thetas, c(a1,a2)) ~ thetas, type = 'l', col = 'red', 
     main = 'a1 = 20, a2 = 20')
lines(beta(thetas, c(a1prime, a2prime)) ~ thetas, col = 'blue')
abline(v = 0.2, col = 'green')
legend('topright', col = c('red', 'blue', 'green'), 
       legend = c('prior', 'posterior', 'theta_2_ML'), lty = c(1,1,1), 
       lwd = c(1,1,1))