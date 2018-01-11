# Lecture 10_1

# a) Compute specific value of p(x) for all possible value of x
n = 4
pi = 1/4
x <- 1:4
p <- dbinom(x, n, pi)
p

# b) Compute E[x] = sum_allX(xp(x)), and compare the answer with the value of (npi)
E_x <- sum(x*p)
E_x
n*pi

# c) Take a sample of size 100 from p(x), compute the sample mean
x_1 <- sample(1:n, 100, replace = T)
p_100 <- dbinom(x_1, n, pi)
mean(p_100)

# The mean is close to pi