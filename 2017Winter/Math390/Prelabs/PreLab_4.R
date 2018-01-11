# Scatter Plots examples

par(mfrow = c(1, 2))

# Take 100 points from uniform distribution between -1 and 1
x <- runif(100, -1, 1)
hist(x) # the shape is uniform

# Generate a normal variable(the error), with mu = 0, sigma = 0.1
set.seed(20)
error <- rnorm(100, 0, 0.1)

hist(error) # the shape is normal.

y_1 <- 2 * x # Perfect linear
y_2 <- 2 * x + error # Add the errors to y
y_3 <- 2 * x + rnorm(100, 0, 0.5) # With more error added to y
y_4 <- 2 * x + rnorm(100, 0, 1.0)

par(mfrow = c(2, 2))
plot(x, y_1, cex = 0.5)
plot(x, y_2, cex = 0.5)
plot(x, y_3, cex = 0.5)
plot(x, y_4, cex = 0.5)

# Correlation
cor(x, y_1)
cor(x, y_2)
cor(x, y_3)
cor(x, y_4)
cor(y_4, x) # It will not change by changing coordinate
cor(y_4, x + 10) # It will not change by shifts
cor(x, 10 * y_4) # It will not change by scaling

# Defects of Correlation
set.seed(123)
par(mfrow = c(2,2))
x <- runif(100, 0, 1)
error <- rnorm(100, 0, 0.5)
y <- 1 + 2 * x + error
x_1 <- rnorm(100, 0, 50)
y_1 <- rnorm(100, 0, 50)
x_2 <- 1000 + x_1
y_2 <- 1000 + y_1
plot(x, y, main = 'Without Outliers', cex = 0.5)
cor(x, y)

# Effect of outliers:
# add one outlier to artificially reduce r
x[101] <- 0.2 
y[101] <- 8.0
plot(x, y, main = 'With Outlier(0.2, 8.0)', cex = 0.5)
cor(x, y)

# a different outlier to artificially increase r
x[101] <- 2.0 
y[101] <- 8.0
plot(x, y, main = 'With Outlier(2.0, 8.0)', cex = 0.5)
cor(x, y)

# Clusters can also make r meaningless
par(mfrow = c(2, 2))
plot(x_1, y_1, main = 'Cluster 1', cex = 0.5)
cor(x_1, y_1)

plot(x_2, y_2, main = 'Cluster 2', cex = 0.5)
cor(x_2, y_2) # No correlation between x and y in cluster 2

x <- c(x_1, x_2)
y <- c(y_1, y_2)
plot(x, y, main = 'Combined Clusters', cex = 0.5)
cor(x, y) # Will get an incorrect correlation


# Example: Ecological Correlation
dat <- read.table("http://www.stat.washington.edu/marzban/390/winter17/3_17_dat.txt", header = T)
x <- dat[, 1]
y <- dat[, 2]
z <- dat[, 3]
par(mfrow = c(2, 2))
plot(x, y)
cor(x, y)
# Create a space for storing the time-averaged values of x and y
xbar <- numeric(3)
ybar <- numeric(3)
xbar[1] <- mean(x[z == 1]) # This average x values only when time = 1
ybar[1] <- mean(y[z == 1])

xbar[2] <- mean(x[z == 2])
ybar[2] <- mean(y[z == 2])

xbar[3] <- mean(x[z == 3])
ybar[3] <- mean(y[z == 3])

# Scatterplot of the 3 averaged pairs
plot(xbar, ybar)
cor(xbar, ybar)

# It can be seen that how averaging tends to increase r, by
# reducing the number of points and their scatter about a line

# Look at the original data with three times
# Scatterplot for time = 1
plot(x[z == 1], y[z == 1], xlim = range(x), ylim = range(y))
points(x[z == 2], y[z == 2], col = 2) # time = 2
points(x[z == 3], y[z == 3], col = 3) # time = 3
points(xbar, ybar, col = 4)
legend('bottomright', c('time = 1', 'time = 2', 'time = 3', 'average'), 
       text.col = c(1, 2, 3, 4), bty = 'n')

# Export the graph to a PDF
pdf("ecol.pdf")
plot(x[z == 1], y[z == 1], xlim = range(x), ylim = range(y), 
     xlab = "x", ylab = "y", pch = 1, cex = 3)
points(x[z == 2], y[z == 2], col = 1, pch = 2, cex = 3)
points(x[z == 3], y[z == 3], col = 1, pch = 3, cex = 3)
dev.off()

# OLS Regression on Simulated Data
# Regression can be used for prediction. The function lm(),
# which stands for linear model does run a line fit in R.
rm(list = ls(all = TRUE)) # Start from a clean slate
set.seed(123)
x <- runif(100, 0, 1)
error <- rnorm(100, 0, 1)
y <- 10 + 2 * x + error # The true line is y = 10 + 2x
par(mfrow = c(1,1))
plot(x, y) # Plot the scatterplot
cor(x, y) # Correlation
model.1 <- lm(y ~ x) # Fitting the regresstion
model.1
abline(model.1) # Superimposes the fit on the scatterplot.

# To see what else is returned by lm(), use the names() command
names(model.1)
# To select one of the items returned in lm(), use the dollar sign
model.1$coefficients

# OLS Regression on REAL Data
x <- c(72, 70, 65, 68, 70) # Data
y <- c(200, 180, 120, 118, 190)
plot(x, y, cex = 0.5)
cor(x, y)

model.1 <- lm(y ~ x)
abline(model.1)
model.1 # will return the formula, interception, and slope
summary(model.1)
