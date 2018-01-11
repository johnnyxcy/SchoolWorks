# PreLab 6
# 4 Sampling Distribution of the Sample Mean and Median
# 4.1 Sampling Distribution of the Mean
# 4.1.1 Normal Population
N <- 100000 # Let N be the population size
pop <- rnorm(N, 1, 2) # random sample
pop.mean <- mean(pop) # mu, the population mean
pop.sd <- sd(pop) # sigma, the pop standard deviation
pop.median <- median(pop) # Get the population median
c(pop.mean, pop.sd, pop.median) # Print
hist(pop, breaks = 400) # Show that the population is normal

# Experiment underlying the sampling distribution
n.trial <- 10000 # Take 10000 samples
sample.size <- 10 # size 10 from the population
sample.stat <- numeric(n.trial) # Create space to store

for (i in 1:n.trial) {
  # Take a sample with replacement
  samp <- sample(pop, sample.size, replace = T)
  sample.stat[i] <- mean(samp) # Compute each sample's mean
}
mean(sample.stat) # Compare mean of sample means
pop.mean # with the population mean
sd(sample.stat) # Compare the sd of sample means
pop.sd # with population sd
pop.sd / sqrt(sample.size) # Compare with (popsd)/sqrt(n)

hist(sample.stat, breaks = 40)
qqnorm(sample.stat) # Normal-like

# 4.1.2 Non-normal Population
N <- 100000
pop <- rgamma(N, 1, 1)
pop.mean <- mean(pop)
pop.sd <- sd(pop)
pop.median <- median(pop)
c(pop.mean, pop.sd, pop.median)

hist(pop, breaks = 400) # Non-normal-like
n.trial <- 10000 # Take 10000 samples of 
sample.size <- 10 # size 10 from the population
sample.stat <- numeric(n.trial) # Create space to store

for (i in 1:n.trial) {
  samp <- sample(pop, sample.size, replace = T)
  sample.stat[i] <- mean(samp)
}
mean(sample.stat) # Compare mean of sample means
pop.mean # with population mean
sd(sample.stat) # Compare the sd of sample means
pop.sd # with population sd
pop.sd / sqrt(sample.size)
hist(sample.stat, breaks = 40)
qqnorm(sample.stat, cex = 0.5)


# 4.2 Sampling Distribution of Median
# 4.2.1 Non-normal Population
N <- 100000
pop <- rgamma(N, 1, 1)
pop.mean <- mean(pop)
pop.sd <- sd(pop)
pop.median <- median(pop)
c(pop.mean, pop.sd, pop.median)
hist(pop, breaks = 400)
n.trial <- 10000 # Take 10000 samples of
sample.size <- 10 # size 10 from the population
sample.stat <- numeric(n.trial) # Space to store
for (i in 1:n.trial) {
  samp <- sample(pop, sample.size, replace = T)
  sample.stat[i] <- median(samp)
}
mean(sample.stat) # Compare mean of sample means
pop.mean # with population mean
sd(sample.stat) # Compare the sd of sample means
pop.sd # with population sd
pop.sd / sqrt(sample.size)
hist(sample.stat, breaks = 40)
qqnorm(sample.stat, cex = 0.5)

# 5 Confidence Interval and Bootstrapping
# 5.1 Confidence Interval for Population Mean
# Create a normal population
rm(list = ls(all = TRUE))
set.seed(1)
N <- 100000 # Sample size = 100000
pop <- rnorm(N, 1, 2) # Draw N samples from a normal
                      # distribution with mu = 1 and
                      # sigma = 2.
pop.mean <- mean(pop)
pop.sd <- sd(pop)
pop.median <- median(pop)
c(pop.mean, pop.sd, pop.median)
hist(pop, breaks = 400)
sample.size <- 200 # Sample size
sample.trial <- sample(pop, sample.size, replace = T)

# 5.1.1 Calculating CI Using Formula
sample.stat <- mean(sample.trial) # Sample mean
std.err <- sd(sample.trial) / sqrt(sample.size) # Standard error
sample.stat - abs(qnorm(.05 / 2)) * std.err # z_star
sample.stat + abs(qnorm(.05 / 2)) * std.err # Sign

# 5.1.2 Calculating CI Using Built-in Function
t.test(sample.trial, alternative = "tow.sided",
       conf.level = 0.95)
# Sample.trial contains the data/measurements of x
# "two-sided" specifies a 2-sided CI, and 0.95 is the confidence level

# To get the confidence interval, use the following command
t.test(sample.trial)$conf.int[1:2]

# 5.2 Converage of a Confidence Interval
rm(list = ls(all = TRUE))
set.seed(1)
N <- 100000
pop <- rnorm(N, 1, 2) 
pop.mean <- mean(pop)
pop.sd <- sd(pop)
pop.median <- median(pop)
c(pop.mean, pop.sd, pop.median)
hist(pop, breaks = 400, main = 'Histogram of Population')
n.trial <- 100 # Number of samples to draw from population
sample.size <- 90 # Size of each sample = 90
CI <- matrix(nrow = n.trial, ncol = 2) # Space to store

for (i in 1:n.trial) {
  sample.trial <- sample(pop, sample.size) # For each sample/trial
  # Then compute and keep CI only
  CI[i, ] <- t.test(sample.trial)$conf.int[1:2]
}
count <- 0 # Count number of CIs that cover mu
for(i in 1:n.trial) {
  if (CI[i, 1] <= pop.mean && CI[i, 2] >= pop.mean) {
    count <- count + 1
  }
}
count
attend <- c(9.0, 14.0, 15.0, 12.5, 13.5, 14.5, 12.5, 8.5,
            17.5, 9.5, 12.0, 11.0, 14.0, 14.5, 14.0, 21.5,
            12.5, 10.5, 17.5, 5.0, 10.5, 17.5, 16.5, 19.0,
            18.0, 15.5, 13.5, 21.5, 10.5, 17.0, 18.5, 12.0,
            15.0, 17.5, 11.5, 15.5, 17.0, 17.0, 20.0, 15.5, 
            12.0, 13.0, 23.0, 11.5, 14.0, 13.0, 22.5, 8.5, 
            11.0, 9.5, 11.5, 17.0, 11.5, 17.5, 7.5, 8.0, 14.5,
            9.5, 19.0, 16.5, 18.5, 10.5, 16.5, 14.5, 13.5, 
            14.5, 12.0, 17.0, 13.0, 11.0, 12.5, 9.0, 19.0, 
            15.0, 16.0, 11.0, 7.0, 22.0, 13.0, 7.5, 14.5, 
            9.5, 19.0, 16.5, 18.5, 10.5, 16.5, 14.5, 13.5, 
            14.5, 12.0, 17.0, 13.0, 11.0, 12.5, 9.0, 19.0, 
            15.0, 16.0, 11.0, 7.0, 22.0, 13.0, 7.5, 14.5, 
            13.0, 18.5, 13.0, 18.5, 10.0, 20.5, 10.5, 17.5, 
            13.0, 19.5, 10.0, 13.0, 19.5, 10.5, 14.5, 11.0, 
            14.5, 11.0, 14.5, 7.0, 7.0, 9.0, 16.0, 13.0, 19.5, 
            15.0, 17.0, 18.0, 10.5, 15.0, 8.5, 10.0, 14.0, 
            16.0, 12.5, 13.5, 17.0)
non.attend <- c(3.0, 12.5, 8.5, 18.5, 5.5, 18.5, 7.5, 13.5, 
                6.5, 17.0, 11.5, 13.0, 13.0)
t.test(attend, non.attend, alternative = "greater", 
       conf.level = 0.95)

# 5.5 Bootstrap: CI without Formulas
# Example: Producing the Correct CI for Mean
rm(list = ls(all = TRUE))
set.seed(1)
N <- 100000
pop <- rgamma(N, 2, 3) # Draw from gamma instead of normal
pop.mean <- mean(pop)
pop.sd <- sd(pop)
pop.median <- median(pop)
c(pop.mean, pop.sd, pop.median)
hist(pop, breaks = 400, main = 'Histogram of Population')
n.trial <- 100
sample.size <- 90
CI <-matrix(nrow = n.trial, ncol = 2)
for (i in 1:n.trial) {
  sample.trial <- sample(pop, sample.size) # Take a sample
  # Now, the bootstrap block:
  # For each sample, take a bootstrap sample, and compute
  # the sampling distribution of the sample means.
  # The appropriate quantiles of this sampling distribution
  # give the confidence interval.
  n.boot <- 100 # Number of bootstrap samples
  boot.stat <- numeric(n.boot)
  for (j in 1:n.boot) {
    boot.sample <- sample(sample.trial, sample.size, replace = T)
    # With replacement
    boot.stat[j] <- mean(boot.sample) # Store
  }
  CI[i, ] <-quantile(boot.stat, c(0.05/ 2, (1 - 0.05 / 2)))
}
count <- 0
for (i in 1:n.trial) {
  if (CI[i, 1] <= pop.mean && CI[i, 2] >= pop.mean) {
    count <- count + 1
  }
}
count

plot(c(1, 1), CI[1, ], ylim = c(0.3, 1.2), xlim = c(0, 101),
     ylab = "CI", xlab = '', type = "l")
for(i in 2:n.trial) {
  lines(c(i, i), CI[i, ]) # draw CIs(vertically)
}
abline(h = pop.mean, col = "red", lwd = 2)

# 5.5.1 Confidence Interval for Sample Median
n.trial <- 100
sample.size <- 90
CI <- matrix(0, n.trial, 2)
for (i in 1:n.trial) {
  sample.trial <- sample(pop, sample.size, replace = T)
  n.boot <- 100
  boot.stat <- numeric(n.boot)
  for (j in 1:n.boot) {
    boot.sample <- sample(sample.trial, sample.size, replace = T)
    boot.stat[j] <- median(boot.sample) # median
  }
  CI[i, ] <- quantile(boot.stat, c(0.05/ 2, (1 - 0.05 / 2)))
}
count <- 0
for (i in 1:n.trial) {
  if (CI[i, 1] <= pop.median && CI[i, 2] >= pop.median) {
    count <- count + 1
  }
}
count
plot(c(1, 1), CI[1, ], ylim = c(0.4, 1), xlim = c(0, 101), 
     xlab = '', ylab = "CI", type = "l")
for (i in 2:n.trial) {
  lines(c(i, i), CI[i, ])
  abline(h = pop.median, col = "red", lwd = 2)
}