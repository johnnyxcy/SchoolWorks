# Prelab3 Math 390 Winter2017


n <- 1:100 # 100 coins
n.trial <- 1000 # roll 1000 times 

sample.mean <- numeric(100) # Generate empty vector
sample.var <- numeric(100)
for (i in n) { # loop 100 times
  #####QUESTION:why is 'i' here##################################################
  head.counts <- rbinom(n.trial, i, 0.5) # Number of heads in ith repeats
  ##############################################################################
  
  sample.mean[i] <- mean(head.counts) # Mean number of heads
  sample.var[i] <- var(head.counts) # Variance of the 1000 repeats
}
plot(n, sample.mean, cex = 0.5) # Plot mean number of heads(cex controls the size of the point)
points(n, sample.var, col = 2, cex = 0.5) # Add points of variance
legend('topleft', c('Sample Mean', 'Variance'), text.col = c('black', 'red'), bty = 'n') # bty'n' means no border


# 2.5 Sample Quantile
x <- c(-10, 50, 30, 20, 0, 40, 70, 60, -20, 80, 10)
median(x)
sort(x)
# The sequence shows 50% is less than 30 and 50% is larger than 30, which can be confirmed by finding 50th quantile
quantile(x, probs = 0.5)
# What if we are looking for 10th quantile?
quantile(x, probs = 0.1)


# 2.6 Distribution Quantile
# Find the 0.9th quantile of a standard normal distribution
qnorm(0.9, mean = 0, sd = 1, lower.tail = TRUE)
# lower.tail (TRUE(Default) = probabilities are counted from left to right in the graph)

# Similiary, we can find 0.1th to 0.9th quantiles
seq <- seq(0.1, 0.9, by = 0.1) # interval = 0.1
qnorm(seq, mean = 0, sd = 1)


# 2.7 QQ Plots
n <- 500 # Sample size = 500
# Sample from a normal distribution with mu=0, sigma=1
x <- rnorm(n, 0, 1)
qqnorm(x, cex = 0.5) # plot qq plot

# Do it by hand
# Make a sequence of n values between
# (1-0.5)/n and (n-0.5)/n
X <- seq(0.5 / n, 1 - 0.5 / n, length = n)

# Find quantiles under standard normal
Q <- qnorm(X, mean = 0, sd = 1)

# Plot the data vs. the quantiles
plot(Q, sort(x), col = 2, cex = 0.5)
# Add a line with slope 1 and intercept 0
abline(0, 1)

# Now let's consider Normal Distribution(not standard)
n <- 500 # size
x <- rnorm(n, 8, 2) # Generate data(mu=8, sigma=2)
hist(x)
# qqnorm() checks the data against a normal distribution
qqnorm(x, cex = 0.5)
abline(8, 2) # A line with slope=2, intercept=8

# Now want a sample with size 500 from 
# a exponential distribution with lambda(rate) = 1
x <- rexp(n, rate = 1)
hist(x)
qqnorm(x, cex = 0.5)
# Find out it is not Linear!
# Try qqmath() to find correct distribution
library(lattice) # contains qqmath()
x <- rexp(500, rate = 1)
hist(x)
qqmath(x, dis = qexp, cex = 0.5)
# Now this looks like linear!

# Check out this qq-plot
dat <- read.table("http://www.stat.washington.edu/marzban/390/winter17/hist_dat.txt", header = FALSE)
qqnorm(dat[, 1], cex = 0.5)
# You can see that there are two linear segments, parallel
# but different intercepts(same sigma but different mu)

