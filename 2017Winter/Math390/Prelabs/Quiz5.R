# Quiz 5 Chongyi Xu 1531273
set.seed(12)
n = 100
x = runif(n, 0, 20)
y = 500 + 25 * x + rnorm(n, 0, 100)
plot(x, y)

# a) Perfrom regression on the data and report the OLs estimates
model.1 <- lm(y ~ x)
# Report the OLS estimates
model.1$coefficients

# b) make an array called alpha.values taking integer values from 1 to 1000
alpha.values <- 1:1000
# make an array called beta.values taking integer values from 1 to 50
beta.values <- 1:50
# compute all the y-values to the x values in the data and store the resulting SSE values in a matrix 1000 x 50
sse = matrix(nrow = 1000, ncol = 50)
for (i in 1:1000) {
  for (j in 1:50) {
    sse[i, j] = sum((y - alpha.values[i] - beta.values[j] * x) ^ 2)
  }
}
image(c(1:1000), c(1:50), sse, col = rainbow(100))
image(c(1:1000), c(1:50), log(sse), col = rainbow(100))


# c) find and view the matrix of values for the cross-term
crossTerm = matrix(nrow = 1000, ncol = 50)
for (i in 1:1000) {
  for (j in 1:50) {
    crossTerm[i, j] = sum((y - alpha.values[i] - beta.values[j] * x) * 
                            (alpha.values[i] + beta.values[j] * x - mean(y)))
  }
}
image(c(1:1000), c(1:50), crossTerm, col = rainbow(100))
