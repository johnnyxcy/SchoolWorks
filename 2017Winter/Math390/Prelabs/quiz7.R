# Math 390 Quiz 7, Chongyi Xu 1531273
mu = 10
sigma = 2
ntrial = 1000
n = 5
zstat = numeric(ntrial)
for(trial in 1:ntrial) {
  x = rnorm(n, mu, sigma)
  zstat[trial] = (mean(x) - mu) / (sigma / sqrt(n))
}
hist(zstat)
qqnorm(zstat)
abline(0, 1, col = 2)

# a)
tstat = numeric(ntrial)
for(trial in 1:ntrial) {
  x = rnorm(n, mu, sigma)
  tstat[trial] = (mean(x) - mu) / (sd(x) / sqrt(n))
}

# b)
X = seq(.5 / ntrial, 1 - .5 / ntrial, length = ntrial)
t = qt(X, n - 1)
plot(t, sort(tstat), cex = 0.5)
abline(0, 1, col = 2)

# c)
n = 100
lambda = 2
tstatc = numeric(ntrial)
for(trial in 1:ntrial) {
  xc = rexp(n, lambda)
  tstatc[trial] = (mean(xc) - mu) / (sd(xc) / sqrt(n))
}
hist(tstatc)
# The histogram shows that it is not a t-distribution

# paired data
mu1 = 2
sigma1 = 1
mu2 = 2.1
sigma2 = 1
ntrial = 1000
n = 100
CI = matrix(nrow = ntrial, ncol = 2)
for(i in 1:ntrial) {
  x1 = rnorm(n, mu1, sigma1)
  x2 = rnorm(n, mu2, sigma2)
  CI[i, ] = t.test(x1, x2, paired = F)$conf.int
}
cnt = 0
for(i in 1:ntrial) {
  if (CI[i, 1] <= mu1 - mu2 & CI[i, 2] >= mu1 - mu2) {
    cnt = cnt + 1
  }
}
cnt
x1 = rnorm(n, mu1, sigma1)
x2 = x1 + rnorm(n, mu2 - mu1, sigma2)
plot(x1, x2)

# d)
CI = matrix(nrow = ntrial, ncol = 2)
for(i in 1:ntrial) {
  x1 = rnorm(n, mu1, sigma1)
  x2 = x1 + rnorm(n, mu2 - mu1, sigma2)
  CI[i, ] = t.test(x1, x2, paired = T)$conf.int
}
count = 0
for(i in 1:ntrial) {
  if (CI[i, 1] <= mu1 - mu2 & CI[i, 2] >= mu1 - mu2) {
  count = count + 1
  }
}
count