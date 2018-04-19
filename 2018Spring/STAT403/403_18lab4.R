## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 4 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                       ###
### Part 1: Getting Data  ###
###                       ###

### Example 1:
### Galaxy Data Set in Element of Statistical Learning
### https://statweb.stanford.edu/~tibs/ElemStatLearn/

### Example 2: 
### Abalone Data Set in UCI repository
### http://archive.ics.uci.edu/ml/datasets/Abalone

getwd()
  # check the current location of the console

setwd("/Users/yenchic/Desktop/STAT_403data")
  # set the location of the console to a specific place
  # you can also use "Session" > "Set Working Directory" > "Choose Directory"


data0 = read.table("abalone.data", sep=",")
  # sep: how variables are separated
  # header: T or F, controling if the first line contains the name of 
  #         the variable

head(data0)
  # check the first few lines

summary(data0)
  # a simmary describing contents in this dataset

plot(data0)
  # pairwise scatter plot

names(data0)

names(data0) = c("Sex","Length","Diameter","Height","Whole weight",
                 "Shucked weight", "Viscera weight","Shell weight","Rings")
  # set the name of the variables

head(data0)


## basic exploratory data analysis
table(data0$Sex)

hist(data0$Length, col="palegreen")

hist(data0$`Whole weight`, col="palegreen")

hist(data0$Rings, col="palegreen")
  # the goal is to predict 'Rings': a proxy of the age of the bass


#### Exercise 1:
#### (1) Go to https://statweb.stanford.edu/~tibs/ElemStatLearn/, download 
####     the dataset 'Ozone' and read the data properly in R.

#### (2) Use the function plot() to show the pairwise scatterplot of all
####     variables.

#### (3) Show the histogram of each variable. Use different colors
####     for different variable.
####     Think about a way to display 4 histograms in the same plot.
####     Hint: par(mfrow=c(2,2))

###                         ###
### Part 2: Fitting a Model ###
###                         ###
### Whole weight -- 
hist(data0$`Whole weight`, col="palegreen")
## for the variable "Whole weight", it seems to be a decaying pattern
## let's try to fit a Exponential distribution for it

lambda_est = 1/mean(data0$`Whole weight`)

lambda_est


## plot the fitted density
hist(data0$`Whole weight`, col="palegreen")
l_seq = seq(from=0, to=5, by=0.05)
lines(x=l_seq, y=dexp(l_seq,rate = lambda_est), lwd=2, col="purple")
  # problem! --> we forgot to set "probability = T"

hist(data0$`Whole weight`, col="palegreen", probability = T)
l_seq = seq(from=0, to=5, by=0.05)
lines(x=l_seq, y=dexp(l_seq,rate = lambda_est), lwd=2, col="purple")
  # kind of fitting something but not that well


### Rings (Age) -- 
hist(data0$Rings, col="palegreen")
  # looks like a normal though with a bit right-skewness

mean_fit = mean(data0$Rings)
sd_fit = sd(data0$Rings)

mean_fit
sd_fit


hist(data0$Rings, col="palegreen", probability = T)
l_seq = seq(from=0, to=30, by=0.5)
lines(x=l_seq, y=dnorm(l_seq,mean = mean_fit, sd=sd_fit), lwd=2, col="purple")
  # okay but we still somewhat suffer from the right-skewness a bit


## 90% CI of the mean?
mean_fit
sd_fit

mean_fit-qnorm(0.95)*sd_fit/sqrt(nrow(data0))
  # lower bound
mean_fit+qnorm(0.95)*sd_fit/sqrt(nrow(data0))
  # upper bound


## performing a log-transformation:
hist(log(data0$Rings), col="palegreen", probability = T)

mean_log = mean(log(data0$Rings))
sd_log = sd(log(data0$Rings))

mean_log
sd_log


hist(log(data0$Rings), col="palegreen", probability = T)
l_seq = seq(from=0, to=4, by=0.1)
lines(x=l_seq, y=dnorm(l_seq,mean = mean_log, 
                       sd=sd_log), lwd=2, col="purple")
  # seems to be a bit better fit


#### Exercise 2:
#### We now go back to the Ozone dataset. 
#### (1) For variable 'Ozone', it looks like an exponential distribution.
####     Fit an exponential distribution to it.
####     What is the fitted value of the parameter?
####     Compared the fitted density curve to the histogram, do they match?

#### (2) For variable 'Temperature', we try to model it as a normal distribution.
####     What are the fitted value of the mean and the standard deviation?
####     Compared the fitted density curve to the histogram. Do they match?

#### (3) Based on the previous result, find a 95% confidence interval of
####     the mean parameter.

#### (4) If someone claim that the mean temperature is 80, then under 
####     significance level=10%, can we reject this claim?

# Z-score:
z0 = abs(temp_mean-80)/temp_sd*sqrt(nrow(data1))

# p-value:
2*(1-pnorm(z0))
  # 2*: because we are using two-tailed test.

###                            ###
### Part 3: Linear Regression  ###
###                            ###

## X: whole weight; Y: Rings
fit_ww = lm(Rings~`Whole weight`, data=data0)

fit_ww
summary(fit_ww)


plot(x= data0$`Whole weight`, y=data0$Rings)
abline(fit_ww, col="red")
  # show the fitted line


## another way to fit (without specifying "data = xxx")
fit_ww = lm(data0$Rings~data0$`Whole weight`)

fit_ww
summary(fit_ww)


## residual plot
fit_ww$residuals

plot(x=data0$`Whole weight`, y=fit_ww$residuals)


## 90% CI of the slope--
summary(fit_ww)$coeff

slope_fit = summary(fit_ww)$coeff[2,1]
slope_fit

slope_se = summary(fit_ww)$coeff[2,2]
slope_se

slope_fit-qnorm(0.95)*slope_se
  # lower bound

slope_fit+qnorm(0.95)*slope_se
  # upper bound


### multiple linear regression
fit_2 = lm(Rings~`Whole weight`+Length, data=data0)

summary(fit_2)


##
fit_4 = lm(Rings~`Whole weight`+Length+Height+Diameter, data=data0)

summary(fit_4)
  # Whole weight becomes not significant! 


##
fit_gender = lm(Rings~`Whole weight`+Length+Height+Diameter+Sex, data=data0)

summary(fit_gender)
  # SexI: a dummy variable, it equals 1 if the gender is I
  # SexM: a dummy variable, it equals 1 if the gender is M
  # Why no SexF?  
  #     ---> because when both SexI, SexM =0, this is the case of SexF=1.
  
  # this result shows that only the gender=I is significantly different from
  # gender=F


## fit all at once
fit_all = lm(Rings~., data=data0)
summary(fit_all)
  # now the length becomes insignificant but whole weight is significant!


## 90% CI for the slope of Diameter?
summary(fit_all)$coeff

summary(fit_all)$coeff['Diameter',]

slope_fit = summary(fit_all)$coeff['Diameter',1]
slope_se = summary(fit_all)$coeff['Diameter',2]

slope_fit-qnorm(0.95)*slope_se
# lower bound

slope_fit+qnorm(0.95)*slope_se
# upper bound


#### Exercise 3:
#### Now the goal is to predict the value of Ozone based on other covariates.
#### Namely, the response variable Y = Ozone and the others are X's. 
#### (1) We first focus on the variable "Temperature". 
####     Fit a linear regression using Y = Ozone and X = Temperature. 
####     What are the fitted intercept and slope? Are they significantly 
####     different from 0?

#### (2) Based on the result of question (1), show the scatter plot and 
####     attach the fitted regression line.

#### (3) Based on the result of question (1), what is a 90% CI of the slope?

#### (4) Now we consider fitting all variables simultaneously. 
####     What are the fitted slope of each variable?
####     Are all variables significantly different from 0?

#### (5) Add an extra variable in our model: the square of temperature.
####     Again fit the model with all variables and the square of temperature.
####     Do we get the slope of every variable significantly different from 0?

###                                          ###
### Part 4: Randomness of a Parametric Model ###
###                                          ###
### Bernoulli distribution
p0 = 0.3
n = 100
X = rbinom(n=n,size = 1,prob = p0)
  # size=1: this becomes a Bernoulli distribution

X

table(X)

p0_est = mean(X)

N = 10000
p0_MC = rep(NA, N)
for(i in 1:N){
  X = rbinom(n=n,size = 1,prob = p0)
  p0_est = mean(X)
  p0_MC[i] = p0_est
}

hist(p0_MC, col="skyblue")

hist(p0_MC, col="skyblue", probability = T)
l_seq = seq(from=0,to=1,by=0.01)
CLT_seq = dnorm(l_seq, mean=p0, sd= sqrt(p0*(1-p0)/n))
lines(x=l_seq, y=CLT_seq, lwd=4, col="red")
  # as what we expected--the estimator has a normal distribution




### Exponential distribution
lambda0 = 2
n = 100
X = rexp(n, rate=lambda0)

hist(X)

lambda_est = 1/mean(X)
lambda_est


N = 10000
lambda_MC = rep(NA, N)
for(i in 1:N){
  X = rexp(n, rate=lambda0)
  lambda_est = 1/mean(X)
  lambda_MC[i] = lambda_est
}

hist(lambda_MC, col="tan")
  # looks pretty liks a normal distribution!


hist(lambda_MC, col="tan", probability = T)
l_seq = seq(from=1,to=10,by=0.01)
CLT_seq = dnorm(l_seq, mean=lambda0, sd= sqrt(lambda0^2/n))
  # an interesting fact: the variance is \lambda0^2/n
lines(x=l_seq, y=CLT_seq, lwd=4, col="purple")


### Uniform distribution
theta0 = 4
n = 100
X = runif(n, max=theta0)

hist(X)

theta_est = max(X)
theta_est


N = 10000
theta_MC = rep(NA, N)
for(i in 1:N){
  X = runif(n, max=theta0)
  theta_est = max(X)
  theta_MC[i] = theta_est
}

hist(theta_MC, col="pink")

hist(theta0-theta_MC, col="pink")
  # looks pretty liks an Exponential distribution!


hist(theta0-theta_MC, col="pink", probability = T)
l_seq = seq(from=0,to=10*theta0/n,by=0.01/n)
den_seq = dexp(l_seq, rate=n/theta0)
  # the limiting distribution is Exp(n/theta)
lines(x=l_seq, y=den_seq, lwd=4, col="purple")


#### Exercise 4:
#### We now study the distribution of the parameter SD in 
#### a Normal distribution. 
#### (1) Generate 100 data points from N(0,4). This means that the standard
####     deviation is 2. We use the sample standard deviation as the estimator.
####     What is the value of the sample standard deviation?
# 1.89
#### (2) Now use N=10000 Monte Carlo simulations to find out the distribution
####     of sample SD. Show the histogram. Does the histogram looks like normal?
#1.994
#### (3) The sample SD roughly follows a Normal distribution
####     with mean 2 and standard deviation sqrt(2/n). Compare this normal
####     curve to the histogram we generated in question (3). 
####     Actually, if the original data is from N(0, A^2), the sample SD
####     follows a Normal distribution with mean A, and standard deviation
####     A*sqrt(1/(2*n))
