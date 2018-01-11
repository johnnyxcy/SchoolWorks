# Prelab 5
dat <- read.table("http://www.stat.washington.edu/marzban/390/winter17/hail_dat.txt",
                  header = T)
plot(dat)
cor(dat) # This shows the coorelations between ALL the vars in the data
size <- dat[, 3] # the 3rd column. Size is in 100th-of-an-inch
rotate <- dat[, 2]
diverg <- dat[, 1]

model.1 <- lm(size ~ diverg) # Regression of size and divergence
plot(diverg, size)
abline(model.1)
model.2 <- lm(size ~ rotate) # Regression of size and rotation
plot(rotate, size)
abline(model.2)

# Decomposing SST into SS_explained and SS_unexplained
anova(model.1)
summary(model.1)

# i.e. 27% of the variation in hail size can be attributed to divergence.
# The typical deviation of hail size about the regression line 
# is 75.99(100th-of-an-inch) ~= 0.76(in) ~= 2(cm)

# To get the PI for all the cases in a new data set
#_________________________________________________________________________#
predict(model.1, newdata = new.dat, interval = "prediction", level = 0.95)
#_________________________________________________________________________#

# OLS Regression(Ordinary Least Squares)
# 9.1 ANOVA(Analysis of Variance) in Regression
x <- c(72, 70, 65, 68, 70)
y <- c(200, 180, 120, 118, 190)
plot(x, y) # Plot the scatterplot
cor(x, y) # Correlation between x and y

model.1 <- lm(y ~ x) # Fitting the regression
anova(model.1) # Note that SS_explaine = 4942 and SSE = 1309
summary(model.1) # R-squared = 0.7906
# The R^2 is reported as "Multipled R-squared"
# Note that the R-squared from summary() agrees with 1 - (SSE / SST)
1 - (1308.9 / (4942.3 + 1308.9))

sqrt(1308.9 / (5 - 2))

# To only get R^2
summary(model.1)$r.squared
# Do the following to check R's SSE really is Sum of Squared Errors
y_hat <- predict(model.1)
y_hat
sum((y - y_hat) ^ 2)


# 9.2 Visual Assement of Goodness-of-Fit
y_hat <- predict(model.1)
# Alternatively, you can use the predictions stored in lm() iteself
y_hat <- model.1$fitted.values
# Here is the scatterplot of predicted size vs. actual size
plot(y, y_hat, cex = 0.5)
abline(0, 1, col = "red") # Draw a diagonal
abline(h = mean(y)) # Add a horizontal line at the mean of y

# Another visual assessment tool is the residual plot.
# It checks different facet of "goodness" than the above plot
# The residuals are contained in lm()
plot(y_hat, model.1$residuals, cex = 0.5)
abline(h = 0)

# In a good fit, these residuals(errors) should NOT display any
# relationship with the predicted values. One way to confirm that
# there is no relationship is to compute the correlation
cor(y_hat, model.1$residuals)

# Chapter 10 Multiple Regression and Model Comparison
# 10.1 Nonlinear Fits(Linear Regression with Higher Order Terms)
set.seed(12)
x <- seq(0, 0.9, 0.1) # Pick 10 x's between 0 and 1
y <- x + rnorm(10, 0, 0.3) # x and y are linear with error
plot(x, y)

lm.1 <- lm(y ~ x) # Fit the simplest regression model
lines(x, lm.1$fitted.values) # Compared with the expected values

lm.2 <- lm(y ~ x + I(x^2)) # Fit the model including the quadratic term
lines(x, lm.2$fitted.values, col = 2) # REMEMBER:I() is necessary!!

lm.3 <- lm(y ~ x + I(x^2) + I(x^3)) # Add another cubic term
lines(x, lm.3$fitted.values, col = 3) # The fit will be mroe curvy

lm.4 <- lm(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6)
           + I(x^7) + I(x^8) + I(x^9)) # Fit a 9th order polynomial
lines(x, lm.4$fitted.values, col = 4)
summary(lm.4)$r.squared # Find R^2
legend('bottomright', c('Lienar', 'Quadratic', 'Cubic', '9th Order'), 
       text.col = c(1, 2, 3, 4), bty = 'n')

# Note that the last model will have no predictive power
# since it overfits the data

# 10.2 Model Comparison
dat <- read.table("http://www.stat.washington.edu/marzban/390/winter17/hail_dat.txt",
                  header = T)

x_1 <- dat[, 1] # Divergence
x_2 <- dat[, 2] # Rotation
y <- dat[, 3] # Hail size in 100th-of-an-inch
# Renaming the colums in dat:
colnames(dat) <- c("x_1", "x_2", "y")

lm.1 <- lm(y ~ x_1) # Predicting the size from divergence
summary(lm.1)

lm.2 <- lm(y ~ x_2) # Predciting the size from rotation
summary(lm.2)

lm.3 <- lm(y ~ x_1 + x_2) # Predicting from both (multiple regression)
summary(lm.3)

lm.4 <- lm(y ~ x_1 + x_2 + x_1:x_2) # Multiple regression with interaction
summary(lm.4)

lm.5 <- lm(y ~ x_1 + x_2 + I(x_1 ^ 2) + I(x_2 ^ 2))
summary(lm.5)

lm.6 <- lm(y ~ x_1 + x_2 + I(x_1 ^ 2) + I(x_2 ^ 2) + x_1:x_2)
summary(lm.6)

# Here is a way of drawing the fit evn if it is nonlinear
# Suppose we pick a relatively simple quadratic model frorm above
diverg <- dat[, 1]
rotate <- dat[, 2]
size <- dat[, 3]

lm.g <- lm(size ~ rotate + I(rotate^2))
lm.g

x <- seq(min(rotate), max(rotate), 0.01)
y.fit <- lm.g$coeff[1] + lm.g$coeff[2] * x + lm.g$coeff[3] * x ^ 2
plot(rotate, size, cex = 0.5)
points(x, y.fit, col = "red", type = "l")

# Alternatively, a fancier way is 
x <- matrix(seq(min(rotate), max(rotate), 0.01), byrow = T)
colnames(x) <- "rotate" # Necessary for predict()
plot(rotate, size, cex = 0.5)
lines(x, predict(lm.g, newdata = data.frame(x)), col = 2)

# Plotting a surface that goes through the cloud of points in 3d
# Suppose we decided that the beset model is the most complex model
lm.e <- lm(size ~ diverg + rotate + I(diverg^2) + I(rotate^2) + 
	I(diverg * rotate))
# x and y simply define a grid in the x-y plane
x <- seq(min(rotate), max(rotate), length = 100)
y <- seq(min(diverg), max(diverg), length = 100)

f <- function(x, y) {
	r <- lm.e$coeff[1] + lm.e$coeff[2] * x + lm.e$coeff[3] * y +
	lm.e$coeff[4] * x ^ 2 + lm.e$coeff[5] * y ^ 2 + lm.e$coeff[6] * 
	x * y 
}
yfit <- outer(x, y, f) # y contains the "height" values of the surface
					   # over the x- y grid; that's what outer() does
library(lattice) # Load the library that contains the function cloud()
# Make a 3d plot of the points of the plane
#______?????????????___________________________________________#
cloud(y.fit, type = "p", screen = list(z = 10, x = -70, y = 0))
#______________________________________________________________#

# Note that in spite of the nonlinearity of the regression function
# itself, i.e. witht quadratic and an interaction terms, the surface
# is mostly planar in the range of our data (i.e. x and y)

# In order to prevent overfitting, we should keep the simpler model
# Principle of "Occam's Razor", which posits that one should go with
# simpler things.
anova(lm.6)
# In the anova() output, each term in the regression equation is 
# accompanied by an SS term. They are obtained from a sequential
# analysis of variance.
# SS_explained is the numerator of the sample variance of the predictions
# SS_unexplained is convented to variance when it's divided by
# n - (k + 1), where k is the number of parameters inthe regression model
y_hat <- predict(lm.6)
n <- length(y)
(n - 1) * var(predict(lm.6))


# Prediction on New Data
n <- nrow(dat) # number of cases in dat
new_1 = c(33, 8, NA) # y = NA since we don't know y for new data
new_2 = c(35, 14, NA)
# Using row-bind to attach new data to old data
new.dat = rbind(dat, new_1, new_2) 

# In the new line, we redevelop lm.4, but onthe first n cases
lm.7 <- lm(y ~ x_1 + x_2 + x_1:x_2, dat = new.dat[1:n, ])
summary(lm.7) # Same as lm.4
colnames(new.dat) <- c("x_1", "x_2", "x_1:x_2")
# Predict the last 2 cases
predict(lm.7, newdata <- new.dat[(n+1):(n+2), ])

# 10.3 Collinearity
# To that end, we will write an R function, which is nothing but
# same lines of code intended to be used over and over again

make.fit <- function(r) {
# The function first make data on x_1, x_2, and y, with collinearity
# (i.e., correlation between x_1 and x_2) equal to r
# The input of the function is r(i.e., correlation between x_1 and x_2)
# The function then fits that data using y, and returns some stats
# about the estimated regression coefficients
	library(MASS) # Load the library contains mvrnorm()
	set.seed(1)
	n <- 100
	# The R function mvrnorm() takes a sample from a multivariate
	# normal, which is a higher-dimensional analog of the normal distri.
	dat <- mvrnorm(n, rep(0, 2), matrix(c(1, r, r, 1), 2, 2))
	x_1 <- dat[, 1]
	x_2 <- dat[, 2]
	y <- 1 + 2 * x_1 + 3 * x_2 + rnorm(n, 0, 2) # Genreate y with error
	dat <- data.frame(x_1, x_2, y) # Here is the whole data
	plot(dat)
	lm.1 <- lm(y ~ x_1 + x_2) # Fit a plane through the data
	# return(lm.1) returns the whole R object lm.1
	# return(summary(lm.1)) returns only the summary results
	return(summary(lm.1$coeff)) # Returns only the regression coeff.
}
# Examing data and the regression coefficients for different amounts
# of collinearity
make.fit(0) # Not collinearity
make.fit(0.7) # Some collinearity
make.fit(0.9) # Extreme collinearity
make.fit(0.999)