# The format is dbinom(x, b, pi)
# x = number of heads out of n tosses of a coin
# pi = prob of head, e.g.
dbinom(0, 100, 0.005)

dbinom(0:3, 100, 0.005)

sum(dbinom(0:3, 100, 0.005))

# Plotting
x <- 0:3
y <- dbinom(0:3, 100, 0.005)
plot(x, y, type = "b") # type = "b" means for "both"
					   # b connects the points with lines

# Plotting the mass function for different values of n and pi
# Note the n and pi values that produce mornal-looking distributions,
# and those that produce Poisson-looking distributions.
par(mfrow = c(3, 4))	# a 3 by 4 matrix of figures
x <- 0:20
plot(x, dbinom(x, 5, 0.01), type = "b")	# n = 5, pi = 0.01
plot(x, dbinom(x, 5, 0.1), type = "b") #n = 5, pi = 0.1
plot(x, dbinom(x, 5, 0.5), type = "b") #n = 5, pi = 0.5
plot(x, dbinom(x, 5, 0.9), type = "b") #n = 5, pi = 0.9
plot(x, dbinom(x, 10, 0.01), type = "b") #n = 10, pi = 0.01
plot(x, dbinom(x, 10, 0.1), type = "b") #n = 10, pi = 0.1
plot(x, dbinom(x, 10, 0.5), type = "b") #n = 10, pi = 0.5
plot(x, dbinom(x, 5, 0.9), type = "b") #n = 5, pi = 0.9
plot(x, dbinom(x, 20, 0.01), type = "b") #n = 20, pi = 0.01
plot(x, dbinom(x, 20, 0.1), type = "b") #n = 20, pi = 0.1
plot(x, dbinom(x, 20, 0.5), type = "b") #n = 20, pi = 0.5
plot(x, dbinom(x, 20, 0.9), type = "b") #n = 20, pi = 0.9

#....................#


# Poisson distribution
par(mfrow = c(1,1))
x <- 0:10
plot(x, dpois(x, 1), type = "b")

lines(x, dpois(x, 4), type = "b", col=2, main='lambda = 4')	# Use up-arrow
lines(x, dpois(x, 6), type = "b", col=3, main='lambda = 6')	#lines() adds lines on exsisting plot
legend('topright', c(expression(lambda == 1), expression(lambda == 4), expression(lambda == 6), text.col = c(1, 2 ,3), bty = 'n'))

# Similarly, dnorm(x, mu, sigma) produces the density function Normal(mu, sigma)
#---------------------------------------------------------------------------------------------------------------------------------------#

# Simulation from Mass and Density Functions
rbinom(200, 10, 0.5) # rbinom(number of tosses, n, pi)

# Put "r" before generates random numbers
# e.g. generate 100 numbers from the poisson distribution, rpois(n, a)
# each of these 100 numbers is the number of people come to Odegard per hour <--- n = 100
# with an average of 4 people per hour <--- a = 4
rpois(100, 4)

# Similarly, a sample of size 10000 from a normal distribution with mu = 0, and sigma = 1
x <- rnorm(10000, 0, 1)
hist(x, breaks = 200)
#------------------------------------------------------------------------------------------#

# Boxplots

x <- rnorm(10000, 0, 1)
par(mfrow = c(1, 2))
boxplot(x, cex = 0.7)	# Circles at the end of boxplots are outliers according to some criterion
boxplot(x, range = 0) 	# Supresses outliers

# E.g.
dat <- read.table("www.stat.washington.edu/marzban/390/winter17/hist_dat.txt", header = F)
x <- dat[, 1]
x_1 <- x[1:100] # Put 1st 100 cases of x in x_1
x_2 <- x[101:200] # Put remain cases in x_2
par(mfrow = c(1, 2))
hist(x, breaks = 20)
boxplot(x_1, x_2)

dat <- read.table("www.stat.washington.edu/marzban/390/winter17/attend_dat.txt", header = T)
x <- dat$attendance
y <- dat$Gender

par(mfrow = c(2, 2))

hist(x[y == 0], main = "Boys' Attendance", xlab = 'Attendance')
hist(x[y == 1], main = "Girls' Attendance", xlab = 'Attendance')
boxplot(x[y == 0], x[y == 1])

# Find means and medians first
mean(x[y == 0])
mean(x[y == 1])

median(x[y == 0])
median(x[y == 1])

# Measures of locations. But we do need spreads also
sd(x[y == 0])
sd(x[y == 1])

quantile(x[y == 0], prob = c(0, 0.25, 0.5, 0.75, 1))
quantile(x[y == 0], prob = c(0, 0.25, 0.5, 0.75, 1))

# Overlaying histograms
dat <- read.table("www.stat.washington.edu/marzban/390/winter17/hist_dat.txt", header = F)
x <- dat[, 1]
x_1 <- x[1:100]
x_2 <- x[101:200]
a <- hist(x_1, plot = F)
b <- hist(x_2, plot = F)
x.lim <- range(c(a$mids, b$mids))
plot(a$mids, a$counts, type = "h", xlim = x.lim, xlab = 'mids', ylab = 'counts')
lines(b$mids + 0.1, b$counts, type = "h", col = "red") # Shift of 0.1 avoids overlapping

# Or you can do
hist(x_1, breaks = 20, xlim = range(x_1, x_2), xlab = 'mids', ylab = 'counts', main = ' ')
hist(x_2, breaks = 20, add = T, border = 2)
