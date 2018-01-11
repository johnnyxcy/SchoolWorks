# Math 390 Quiz 4, Chongyi Xu, 1531273
# Generate "data"
set.seed(9)
n = 1000 # Sample size
x = rnorm(n, 0, 5) # random sample of size from N(0,5)
y = 1 + 2 * x # Linear relationship
y = y + rnorm(n, 0, 10) # add errors

par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
plot(x, y, cex = 0.5) # Scatterplot of x and y
abline(1, 2.78, col = 2) # a line with slope of 2.78 and interception of 1
plot(x, y, cex = 0.5)
abline(0.89, 1.87, col = 2) # slope = 1.87 & y-intercept = 0.89
plot(x, y, cex = 0.5)
abline(0.86, 2.00, col = 2) # slope = 2.00 & y-intercept = 0.86

# a) Bassed on the visual inspection, I can see
# that the first one is the better fit.
y[abs(x - 5) < 1] # y values corresponding to x within 1 of 5
mean(y[abs(x - 5) < 1])

# b) approximate the conditional mean of y using binsize of 1
# Store 5 values
cond.mean <-numeric(5)
# x = -10
cond.mean[1] <- mean(y[abs(x + 10) < 1])
# x = -5
cond.mean[2] <- mean(y[abs(x + 5) < 1])
# x = 0
cond.mean[3] <- mean(y[abs(x + 0) < 1])
# x = +5
cond.mean[4] <- mean(y[abs(x - 5) < 1])
# x = +10
cond.mean[5] <- mean(y[abs(x - 10) < 1])

# c) Superimpose thte 5 pairs on the scatterplot
plot(c(-10, -5, 0, 5, 10), cond.mean, type = "b", 
     xlab = 'x = -10, -5, 0, 5, 10', ylab = 'conditional mean')

# d) add a regression line
model.1 <- lm(y ~ x)
abline(model.1, col = 2)

# e) find y intercept and the slope of the SD line
slope <- sd(y) / sd(x)
yintercept <- mean(y) - slope * mean(x)
abline(yintercept, slope, col = 3)
