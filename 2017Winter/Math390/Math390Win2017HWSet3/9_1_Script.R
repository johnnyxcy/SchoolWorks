# Lecture9-1
# a) Generate a sample with given size, mu, sigma
sample <- rnorm(100, -1, 2)

# a) Compute mean and standard deviation
mean(sample)
sd(sample)

# b) Make a density scale histogram and overlay the density function
hist(sample, freq = F)
x <- seq(-5, 5, length = 100)
lines(x, dnorm(x, -1 ,2))