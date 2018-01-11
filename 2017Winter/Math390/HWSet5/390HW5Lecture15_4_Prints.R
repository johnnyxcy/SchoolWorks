# HW Lecture 15-2
# a) Generate a sample of size 100 from -1 to +1
set.seed(100)
x <- runif(100, -1, +1)

# b) Generat y such that y = 2 + 3x + e with e = N(0, 0.5)
y <- 2 + 3 * x + dnorm(x, 0, 0.5)

# c) Do regression on x, y and call the prediction y_precition
model <- lm(y ~ x)
y_predict <- model$coefficients[2] * x + model$coefficients[1]

# d) Compute the sum
sum = 0
for (i in 100) {
  sum = sum + (y_predict[i] - mean(y)) * (y[i] - y_predict[i])
}
sum