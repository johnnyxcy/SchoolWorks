## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 6 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                             ###
### Part 1: Empirical Bootstrap ###
###                             ###
### Getting the abalone dataset
data0 = read.table("abalone.data", sep=",")
names(data0) = c("Sex","Length","Diameter","Height","Whole weight",
                 "Shucked weight", "Viscera weight","Shell weight","Rings")

head(data0)

X = data0$`Whole weight`
hist(X, col="palegreen")
  # we will focus on the variable 'Diameter'

### Median: 
X_med = median(X)
X_med

n = length(X)
  # sample size

sample(10, 5, replace=T)
  # the sample() function allows us to sample with replacement
  # the key it to set 'replace = T'


## one run of the bootstrap
w = sample(n,n,replace=T)
X_BT = X[w]
median(X_BT)


B = 5000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_med_BT[i_BT] = median(X_BT)
    # save each bootstrap median
}

X_med_BT
  # value of the bootstrap sample

hist(X_med_BT, col="skyblue")
abline(v=X_med, lwd=3, col="red")


## Bootstrap estimate
var(X_med_BT)
  # this is the bootstrap variance (VAR)

mean((X_med_BT-X_med)^2)
  # this is the bootstrap MSE

X_med-qnorm(0.95)*sd(X_med_BT)
X_med+qnorm(0.95)*sd(X_med_BT)
  # the bootstrap 90% CI using normality

quantile(X_med_BT, c(0.05,0.95))
  # the bootstrap 90% CI using the quantile


### Bootstrap IQR (Q3-Q1):
summary(X)
X_IQR = IQR(X)

B = 5000
X_IQR_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_IQR_BT[i_BT] = IQR(X_BT)
  # save each bootstrap median
}

X_IQR_BT
# value of the bootstrap sample

hist(X_IQR_BT, col="tan")
abline(v=X_IQR, lwd=3, col="purple")


## Bootstrap estimate
var(X_IQR_BT)
  # this is the bootstrap SD

mean((X_IQR_BT-X_IQR)^2)
  # this is the bootstrap MSE

X_IQR-qnorm(0.95)*sd(X_IQR_BT)
X_IQR+qnorm(0.95)*sd(X_IQR_BT)
  # the bootstrap 90% CI using normality

quantile(X_IQR_BT, c(0.05,0.95))
  # the bootstrap 90% CI using the quantile

### maximum
X_max = max(X)

B = 5000
X_max_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_max_BT[i_BT] = max(X_BT)
  # save each bootstrap median
}

X_max_BT
# value of the bootstrap sample

hist(X_max_BT, col="tan")
abline(v=X_IQR, lwd=3, col="purple")




#### Exercise 1: 
#### We will analyze the 'quakes' dataset. It is a built-in dataset in R.
#### You can use command quakes to see this dataset.
#### In particular, we will focus on the variable 'depth'. 
#### (1) Use hist() to see the distribution of this variable.
{
  X = quakes$depth
  hist(X, col="orchid")
}

#### (2) What is the median?
{
  X_med = median(X)
  X_med
}
#### (3) Now use the bootstrap to generate B=10000 bootstrap sample and 
####     show the distribution of the bootstrap median. 
{n = length(X)
B = 10000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_med_BT[i_BT] = median(X_BT)
}

hist(X_med_BT, col="salmon")
}
#### (4) Use the bootstrap sample to estimate the variance and MSE of 
####     the median. 
{sd(X_med_BT)^2
mean((X_med_BT-X_med)^2)
}
#### (5) Use the bootstrap sample to construct a 90% CI of the median. 
####     Try both normality method and the quantile method.
{X_med-qnorm(0.95)*sd(X_med_BT)
X_med+qnorm(0.95)*sd(X_med_BT)

quantile(X_med_BT, c(0.05,0.95))
}

###                              ###
### Part 2: Parametric Bootstrap ###
###                              ###
X = data0$`Whole weight`
hist(X, col="palegreen")

n = length(X)

## Although this may sound like a bad idea, we try to fit a Normal 
## distribution to this dataset.
X_med = median(X)

X_mean = mean(X)
X_sd = sd(X)
  # these are the estimate of the mean and SD of the Normal distribution

rnorm(10, mean=X_mean, sd=X_sd)
  # this generates random points from the fitted Normal distribution

median(rnorm(n, mean=X_mean, sd=X_sd))
  # the sample 'median' of a (parametric) bootstrap sample

B = 10000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  X_BT = rnorm(n, mean=X_mean, sd=X_sd)
    # We generate new bootstrap sample from the fitted model!
  X_med_BT[i_BT] = median(X_BT)
}

hist(X_med_BT, col="violet")
abline(v= X_med, col="blue", lwd=6)
  # here you see that if we fit a wrong model to the data and use the 
  # parametric bootstrap, we are off a lot!

var(X_med_BT)
mean((X_med_BT-X_med)^2)
  # bootstrap VAR and MSE differs a lot!

X_med-qnorm(0.95)*sd(X_med_BT)
X_med+qnorm(0.95)*sd(X_med_BT)

quantile(X_med_BT, c(0.05,0.95))
  # the two CI's does not agree each other!


### Using 'iris' dataset, 'Sepal.Width'
head(iris)
hist(iris$Sepal.Width, col="orange")
  # seems to be normal

X = iris$Sepal.Width

n = length(X)

X_med = median(X)
X_mean = mean(X)
X_sd = sd(X)

X_med
X_mean
X_sd

B = 10000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  X_BT = rnorm(n, mean=X_mean, sd=X_sd)
  X_med_BT[i_BT] = median(X_BT)
}

hist(X_med_BT, col="violet", xlim=c(2.8,3.2))
abline(v= X_med, col="blue", lwd=6)
  ## still not work!

var(X_med_BT)
mean((X_med_BT-X_med)^2)
  # VAR underestimate too much about the error (MSE)

quantile(X_med_BT, c(0.05,0.95))


#### Exercise 2:
#### In this exercise, we will use the 'rock' data, a built-in dataset in R.
head(rock)
#### We focus on the variable 'area'; here is the histogram:
hist(rock$area, col="aquamarine")
#### It looks like a Normal. So we will fit a Normal distribution to it.
#### (1) What are the fitted value of the mean and SD of the Normal?
{X = rock$area
n= length(X)
X_mean = mean(X)
X_sd = sd(X)
X_mean
X_sd}

#### (2) We want to investigate the median. What is the sample median?
{X_med = median(X)
X_med
}
#### (3) To analyze the quality of the median estimator, we first try
####     a parametric bootstrap using the fitted mean and variance.
####     What are the bootstrap estimated variance and MSE of the median?
####     Do they agree each other?
{B = 10000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  X_BT = rnorm(n, mean=X_mean, sd=X_sd)
  X_med_BT[i_BT] = median(X_BT)
}
sd(X_med_BT)^2
mean((X_med_BT-X_med)^2)
}
#### (4) Use the empirical bootstrap to estimate the variance and MSE.
####     Do they agree each other?
{B = 10000
n = length(X)
X_med_BTe = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_med_BTe[i_BT] = median(X_BT)
}
sd(X_med_BTe)^2
mean((X_med_BTe-X_med)^2)
}

hist(X_med_BT, col=rgb(1,0,0,0.5), xlim=c(5000,10000), probability = T, ylim=c(0,1.5e-3))
par(new=T)
hist(X_med_BTe, col=rgb(0,0,1,0.5), xlim=c(5000,10000), probability = T, ylim=c(0,1.5e-3))


###                          ###
### Part 3: Permutation Test ###
###                          ###
data0$Sex
dataM = data0$`Whole weight`[data0$Sex=="M"]
dataF = data0$`Whole weight`[data0$Sex=="F"]
t.test(dataM, dataF)
ks.test(dataM,dataF)


## permutation test + median
dataM_med = median(dataM)

dataF_med = median(dataF)
diff_med = abs(dataM_med-dataF_med)

n_M = length(dataM)
n_F = length(dataF)
n = n_M+n_F

data_pull = c(dataM, dataF)

N_per = 10000
diff_med_per = rep(NA, N_per)
for(i_per in 1:N_per){
  w_per = sample(n, n, replace=F)
  data_per = data_pull[w_per]
  # data after permutation
  dataM_new = data_per[1:n_M]
  dataF_new = data_per[(n_M+1):n]
  # first n_M are new group M; the others are new group F
  diff_new = abs(median(dataM_new)-median(dataF_new))
  # compute the difference
  diff_med_per[i_per] = diff_new
}

which(diff_med_per>diff_med)

(length(which(diff_med_per>diff_med))+1)/N_per
# this is the p-value of permutation test


## permutation test + 10% quantile
dataM_q1 = quantile(dataM,0.1)
dataF_q1 = quantile(dataF,0.1)
diff_q1 = abs(dataM_q1-dataF_q1)

n_M = length(dataM)
n_F = length(dataF)
n = n_M+n_F

data_pull = c(dataM, dataF)

N_per = 10000
diff_q1_per = rep(NA, N_per)
for(i_per in 1:N_per){
  w_per = sample(n, n, replace=F)
  data_per = data_pull[w_per]
  dataM_new = data_per[1:n_M]
  dataF_new = data_per[(n_M+1):n]
  diff_new = abs(quantile(dataM_new,0.1)-quantile(dataF_new,0.1))
  # now we use 10% quantile difference
  diff_q1_per[i_per] = diff_new
}

hist(diff_q1_per, col="orchid")
abline(v = diff_q1, col="limegreen", lwd=6)

which(diff_q1_per>diff_q1)

(length(which(diff_q1_per>diff_q1))+1)/N_per

# very low p-value!


#### Exercise 3:
#### Again we will focus on the two sample problem of Male versus Female
#### Abalone. This time we use the variable "Shucked weight". 
#### (1) First we try to use t.test and ks.test to check if they are 
####     different. What are the corresponding p-values?
{dataM = data0$`Shucked weight`[data0$Sex=="M"]
dataF = data0$`Shucked weight`[data0$Sex=="F"]
t.test(dataM, dataF)
ks.test(dataM,dataF)
}
#### (2) Now do a permutation test using the diffrence of 10% quantile.
####     What are the p-value? Are they significantly different under
####     significance level alpha = 0.05?
{dataM_q1 = quantile(dataM,0.1)
dataF_q1 = quantile(dataF,0.1)
diff_q1 = abs(dataM_q1-dataF_q1)

n_M = length(dataM)
n_F = length(dataF)
n = n_M+n_F

data_pull = c(dataM, dataF)

N_per = 10000
diff_q1_per = rep(NA, N_per)
for(i_per in 1:N_per){
  w_per = sample(n, n, replace=F)
  data_per = data_pull[w_per]
  dataM_new = data_per[1:n_M]
  dataF_new = data_per[(n_M+1):n]
  diff_new = abs(quantile(dataM_new,0.1)-quantile(dataF_new,0.1))
  diff_q1_per[i_per] = diff_new
}

which(diff_q1_per>diff_q1)
length(which(diff_q1_per>diff_q1))/N_per
}

###                               ###
### Part 4: Bootstrap Convergence ###
###                               ###
## We now will compare the quality of bootstrap estimate.
## We first compute the error of sample median using Monte Carlo Simulation.
n = 1000
X = rnorm(n)
med0 = 0
  
X_med = median(X)
X_med

N = 10000
  # number of Monte Carlo
X_med_MC = rep(NA, N)
for(i_MC in 1:N){
  X = rnorm(n)
  X_med_MC[i_MC] = median(X)
}
X_med_VAR = var(X_med_MC)
X_med_VAR

X_med_MSE = mean((X_med_MC-med0)^2)
X_med_MSE


## bootstrap case
X = rnorm(n)
  # just one sample
X_med = median(X)
X_med

B = 10000
X_med_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  X_BT = X[w]
  X_med_BT[i_BT] = median(X_BT)
}
X_med_BT_VAR = var(X_med_BT)
X_med_BT_VAR

X_med_BT_MSE = mean((X_med_BT-X_med)^2)
X_med_BT_MSE

## comparison
X_med_BT_VAR
X_med_VAR

X_med_BT_MSE
X_med_MSE


### different sample size
N = 10000
B = 10000

n_seq = c(50, 200, 500, 1000, 2000, 5000)

info_matrix = matrix(NA, nrow=length(n_seq), ncol=4)
colnames(info_matrix) = c("VAR","MSE","VAR_BT","MSE_BT")
rownames(info_matrix) = n_seq
info_matrix


for(i_n in 1:length(n_seq)){
  n = n_seq[i_n]
  X_med_MC = rep(NA, N)
  for(i_MC in 1:N){
    X = rnorm(n)
    X_med_MC[i_MC] = median(X)
  }
  info_matrix[i_n,1] = var(X_med_MC)
  info_matrix[i_n,2] = mean((X_med_MC-med0)^2)

  X = rnorm(n)
  X_med = median(X)
  X_med_BT = rep(NA, B)
  for(i_BT in 1:B){
    w = sample(n,n,replace=T)
    X_BT = X[w]
    X_med_BT[i_BT] = median(X_BT)
  }
  info_matrix[i_n,3] = var(X_med_BT)
  info_matrix[i_n,4] = mean((X_med_BT-X_med)^2)
}

info_matrix


plot(NULL, xlim=c(0,5000),ylim=c(0.5, 2.5),
     ylab="VAR_BT / VAR", xlab="Sample size", main="Bootstrap VAR")
abline(h=1, lwd=3, col="red")
points(x=n_seq, y=info_matrix[,3]/info_matrix[,1], pch=20,
       col="slateblue", cex=2)
lines(x=n_seq, y=info_matrix[,3]/info_matrix[,1], col="slateblue", lwd=3)


plot(NULL, xlim=c(0,5000),ylim=c(0.5, 2.5),
     ylab="MSE_BT / MSE", xlab="Sample size", main="Bootstrap MSE")
abline(h=1, lwd=3, col="blue")
points(x=n_seq, y=info_matrix[,4]/info_matrix[,2], pch=20,
       col="palevioletred", cex=2)
lines(x=n_seq, y=info_matrix[,3]/info_matrix[,1], col="palevioletred", lwd=3)


#### Exercise 4:
#### Mimic the above procedure and generate data from Uni[0,1] to see
#### the convergence of bootstrap VAR and MSE of the sample IQR.
#### In this case, we know that the IQR is 0.50.
IQR0 = 0.50
#### For simplicity, we choose Monte Carlo Size N = 10000 and Bootstrap
#### size B = 10000.
N = 10000
B = 10000
#### (1) Consider n = 500. Use Monte Carlo Simulation to estimate the
####     variance and MSE of the sample IQR.
{n = 500
U_IQR_MC = rep(NA, N)
for(i_MC in 1:N){
  U = runif(n)
  U_IQR_MC[i_MC] = IQR(U)
}
U_IQR_VAR = var(U_IQR_MC)
U_IQR_VAR

U_IQR_MSE = mean((U_IQR_MC-IQR0)^2)
U_IQR_MSE}
#### (2) Consider n = 500. Generate a new sample. Use the bootstrap to
####     estimate the variance and MSE of the sample IQR Compare
####     to the variance and MSE from the Monte Carlo Simulation.
{B = 10000
U = runif(n)
U_IQR0 = IQR(U)
U_IQR_BT = rep(NA, B)
for(i_BT in 1:B){
  w = sample(n,n,replace=T)
  U_BT = U[w]
  U_IQR_BT[i_BT] = IQR(U_BT)
}
U_IQR_BT_VAR = var(U_IQR_BT)
U_IQR_BT_VAR

U_IQR_BT_MSE = mean((U_IQR_BT-U_IQR0)^2)
U_IQR_BT_MSE

U_IQR_BT_VAR/U_IQR_VAR
U_IQR_BT_MSE/U_IQR_MSE
  # comparison
}
#### (3) Change the sample size to n = 1000, 2000, repeat the same procedure.
####     Does the bootstrap estimate of the variance and MSE converge to
####     the corresponding result of the Monte Carlo Simulation?
{n_seq = c(50, 200, 500, 1000, 2000, 5000)

info_matrix = matrix(NA, nrow=length(n_seq), ncol=4)
colnames(info_matrix) = c("VAR","MSE","VAR_BT","MSE_BT")
rownames(info_matrix) = n_seq
for(i_n in 1:length(n_seq)){
  n = n_seq[i_n]
  U_IQR_MC = rep(NA, N)
  for(i_MC in 1:N){
    U = runif(n)
    U_IQR_MC[i_MC] = IQR(U)
  }
  info_matrix[i_n,1] = var(U_IQR_MC)
  info_matrix[i_n,2] = mean((U_IQR_MC-IQR0)^2)
  
  U = runif(n)
  U_IQR0 = IQR(U)
  U_IQR_BT = rep(NA, B)
  for(i_BT in 1:B){
    w = sample(n,n,replace=T)
    U_BT = U[w]
    U_IQR_BT[i_BT] = IQR(U_BT)
  }
  info_matrix[i_n,3] = var(U_IQR_BT)
  info_matrix[i_n,4] = mean((U_IQR_BT-IQR0)^2)
}

info_matrix
}


