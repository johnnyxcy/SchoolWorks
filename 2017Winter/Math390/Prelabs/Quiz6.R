# Quiz 6 Chongyi Xu 1531273 Section AB
ntrial = 1000
n = 100 # sample size = 100
xbar = numeric(ntrial) # Space to Store
for (trial in 1:ntrial) {
  x = rnorm(n, 5, 10) # N(5, 10)
  xbar[trial] = mean(x)
}
hist(xbar, breaks = 40)

# a) Construct the sampling distribution of the sample maximum
x.max = numeric(ntrial)
for (trial in 1:ntrial) {
  x = rnorm(n, 5, 10)
  x.max[trial] = max(x)
}
hist(x.max, breaks = 40)

# b)
# The mode of the histogram in part(a) is 32, which means 
# the 32 is the maximum that appears the most.

# c)
# Yes, I think it is reasonable.

set.seed(15)
N = 10 # Let N denote the population size
X = rnorm(10, 0, 1)
X

# d)
n = 5
xbar = numeric(N)

for (i in 1:N) {
  samp = sample(X, n, replace = F)
  xbar[i] = mean(samp)
}

# e)
qqnorm(xbar)
yintercept = mean(X)
slope = sd(X) / sqrt(n)
abline(yintercept, slope, col = "blue")

# f)
fpc = sqrt((N - n) / (N - 1))
slope = slope * fpc
abline(yintercept, slope, col = "red")

# g)
# The confidence interval without replacement can be written as
# mu +- sqrt((N - n) / (n - 1)) * (pop std deviation) / sqrt(n)

# since fpc is less than 1, the sampling with replacement will
# be wider than the sampling without replacement