# 3.44
# a) Based on the scatter plot, would you summerize the relationship
# between the two variables by fitting a straight line?
# Import Data
x <- c(303.2, 313.1, 323.5, 323.1, 333.1, 340.1, 343.1, 353.7, 353.1,
       364.6)
y <- c(.9625, .8373, .7260, .7376, .6558, .6009, .5875, .5234, .5300, 
       .4685)
plot(x, y, cex = 0.5)
# Yes. The scatter plot looks familiar with a "linear" relationship.
# So it can be appropraite to fit two variables with a straight line.


# b) Plot ln(y) against 1/x
plot(1/x, log(y), cex = 0.5)
# This plot suggests that there is a linear relationship between them
# after the transformation.

# c) Fit a straight line to the transformed data
xt <- 1/x
yt <- log(y)
beta = (mean(xt * yt) - mean(xt) * mean(yt)) / (mean(xt ^ 2) - mean(xt) ^ 2)
alpha = mean(yt) - beta * mean(xt)
abline(alpha, beta)
# Predict y when  is 325K
y.predit <- exp (alpha + beta * 1 / 325)
print(y.predit)