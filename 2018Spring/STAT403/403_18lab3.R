## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 3 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                                      ###
### Part 1: Monte Carlo Integration - 1  ###
###                                      ###
### simple example: exp(-x)
### --> we know the true answer
f_target = function(x){
  return(exp(-x))
}
  # target function

###
N = 100

X_uni = runif(N)
eva_uni = f_target(X_uni)
mean(eva_uni)

1-exp(-1)
  # the answer


### visualization of convergence
N_seq = c(50,100, 500,1000, 5000,10000, 5e4, 1e5, 5e5, 1e6)
mean_eva = rep(NA, length(N_seq))

for(j in 1:length(N_seq)){
  N = N_seq[j]
  X_uni = runif(N)
  eva_uni = f_target(X_uni)
  mean_eva[j] = mean(eva_uni)
}

mean_eva
1-exp(-1)


### showing the plot
plot(x=N_seq, y=mean_eva, pch=20, log="x", col="dodgerblue", cex=2)
abline(h=1-exp(-1), lwd=4, col="gray")
lines(x=N_seq, y=mean_eva, lwd=4, col="dodgerblue")


### repeat the plot
plot(NULL, ylim=c(0.6, 0.67), xlim=c(50, 1e6), log="x")
abline(h=1-exp(-1), lwd=4, col="gray")

for(i_rep in 1:10){
  mean_eva = rep(NA, length(N_seq))
  for(j in 1:length(N_seq)){
    N = N_seq[j]
    X_uni = runif(N)
    eva_uni = f_target(X_uni)
    mean_eva[j] = mean(eva_uni)
  }
  points(x=N_seq, y=mean_eva, pch=20, col="dodgerblue")
  lines(x=N_seq, y=mean_eva, lwd=2, col="dodgerblue")
}


### change the color of curves
col_new = colorRampPalette(c("red","skyblue","limegreen","tan","purple"))
  # create a color palette that mix several color
col_new
col_new(10)

plot(x=1:10,y=1:10, col=col_new(10), pch=20, cex=5)



plot(NULL, ylim=c(0.6, 0.67), xlim=c(50, 1e6), log="x")
abline(h=1-exp(-1), lwd=4, col="gray")

col_curve = col_new(10)

for(i_rep in 1:10){
  mean_eva = rep(NA, length(N_seq))
  for(j in 1:length(N_seq)){
    N = N_seq[j]
    X_uni = runif(N)
    eva_uni = f_target(X_uni)
    mean_eva[j] = mean(eva_uni)
  }
  points(x=N_seq, y=mean_eva, pch=20, col=col_curve[i_rep])
  lines(x=N_seq, y=mean_eva, lwd=2, col=col_curve[i_rep])
}


### fixed N, see the variability and bias
N = 100

X_uni = runif(N)
eva_uni = f_target(X_uni)
mean(eva_uni)


#
n_rep = 100000
mean_eva = rep(NA, n_rep)
for(i_rep in 1:n_rep){
  X_uni = runif(N)
  eva_uni = f_target(X_uni)
  mean_eva[i_rep] = mean(eva_uni)
}

mean(mean_eva)
1-exp(-1)
  # very close -- because it is unbiased!
  
sd(mean_eva)
  # this quantify the Monte Carlo Error (variability caused by N)

hist(mean_eva, probability = T, col="palegreen")
abline(v= 1-exp(-1), col="purple",lwd=4)


### exp(-x^3)
f_target = function(x){
  return(exp(-x^3))
}
# target function


#### Exercise 1:
#### Integrating the function f(x) = 5x^4-x^2 within the interval [0,1].
#### (1) Show the result using a size N=1000 Monte Carlo Simulation 
####     from a uniform distribution.

#### (2) Repeat this process for 10000 times and see the variance.
####     Show the histogram of the result of all 10000 integrations. 

#### (3) Show the result using N = 50, 100, 500, 1000, ... , 1e6. 
####     Repeat the process 10 times and display the results. 


###                                      ###
### Part 2: Monte Carlo Integration - 2  ###
###                                      ###
### comparing different sampling distributions
f_target = function(x){
  return(exp(-x))
}
N = 100
n_rep = 100000

# method 1: Uniform [0,1]
mean_eva = rep(NA, n_rep)
for(i_rep in 1:n_rep){
  X_uni = runif(N)
  eva_uni = f_target(X_uni)
  mean_eva[i_rep] = mean(eva_uni)
}

sd(mean_eva)


# method 2: Beta (2,2)
mean_eva2 = rep(NA, n_rep)
for(i_rep in 1:n_rep){
  X2 = rbeta(N, shape1=2, shape2=2)
  #eva2 = f_target(X2)/(6*X2*(1-X2))
  eva2 = f_target(X2)/dbeta(X2, shape1 = 2, shape2 = 2)
  mean_eva2[i_rep] = mean(eva2)
}

mean(mean_eva2)
1-exp(-1)
  # unbiased!

sd(mean_eva2)

sd(mean_eva)
  # method 2 is not a better method



### different range
### assume we want to evaluate 1/(1+exp(x^2)) over the entire real line
### we will use normal distribution to do this
f_target = function(x){
  return(1/(1+exp(x^2)))
}
#
N = 250

## standard normal
X3 = rnorm(N)
eva3 = f_target(X3)/dnorm(X3)
  # dnorm: the density of normal distribution
mean(eva3)
  # the actual answer is about 1.072

# see the variablility 
n_rep = 10000
mean_eva3 = rep(NA, n_rep)
for(i_rep in 1:n_rep){
  X3 = rnorm(N)
  eva3 = f_target(X3)/dnorm(X3)
  mean_eva3[i_rep] = mean(eva3)
}

sd(mean_eva3)


## change variance
X4 = rnorm(N, sd =0.5)
eva4 = f_target(X4)/dnorm(X4, sd=0.5)
  # dnorm: the density of normal distribution
mean(eva4)

# see the variablility 
n_rep = 10000
mean_eva4 = rep(NA, n_rep)
for(i_rep in 1:n_rep){
  X4 = rnorm(N, sd=0.9)
  eva4 = f_target(X4)/dnorm(X4, sd=0.9)
  mean_eva4[i_rep] = mean(eva4)
}

sd(mean_eva4)


### compare histogram
hist(mean_eva3, xlim=c(1,1.2), probability = T, ylim=c(0,40),
     col=rgb(1,0,0,0.5), main="Distribution comparison")
hist(mean_eva4, xlim=c(1,1.2), probability = T, ylim=c(0,40), add=T,
     col=rgb(0,0,1,0.5))
legend("topright", c("SD=1.0", "SD=0.9"), 
       col=c(rgb(1,0,0,0.5),rgb(0,0,1,0.5)), lwd=5)


#### Exercise 2-1:
#### Integrating the function f(x) = 5x^4-x^2 within the interval [0,1].
#### (1) Use Monte Carlo Simulation with Beta(2,2) and N=1000 realizations
####     to see the result.

#### (2) What is the variance of this estimator? Repeat (1) 10000 times to
####     estimat the Monte Carlo error.
####     Does this sampling distribution provides a smaller variance than 
####     the one from Uni[0,1]? 

#### Exercise 2-2:
#### Integrating the function f(x) = e^(-x^2) within the interval [0,infty).
#### (1) Use Exp(1) and a size N = 1000 Monte Carlo Simulation to estimate it.

#### (2) What is the variance of this estimator? Repeat (1) 10000 times to
####     estimate the Monte Carlo error.

#### (3) Think about what will be the actual value of this integration. 
####     Hint: Think about normal distribution.



###                                 ###
### Part 3: Monte Carlo Simulation  ###
###                                 ###
### -- continue from the integration problem
### we see that different SD yields a different result
### how do we roughly understand which SD is the best?

sd_seq = c(0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3)
  # we are going to analyze which SD is the best

sim_sd = rep(NA, length(sd_seq))
sim_avg = rep(NA, length(sd_seq))

for(i_sd in 1:length(sd_seq)){
  n_rep = 10000
  mean_eva5 = rep(NA, n_rep)
  for(i_rep in 1:n_rep){
    X5= rnorm(N, sd =sd_seq[i_sd])
    eva5 = f_target(X5)/dnorm(X5, sd=sd_seq[i_sd])
    mean_eva5[i_rep] = mean(eva5)
  }
  sim_sd[i_sd] = sd(mean_eva5)
  sim_avg[i_sd] = mean(mean_eva5)
}

sim_sd

plot(x=sd_seq, y=sim_sd, xlab="SD of Normal", 
     ylab="Error of integration")


plot(x=sd_seq, y=sim_sd, xlab="SD of Normal", 
     ylab="Error of integration", type="l", lwd=3, col="brown")
points(x=sd_seq, y=sim_sd, col="brown", cex=2, pch=16)
  # this tells you which method is the best one


#
plot(x=sd_seq, y=sim_avg, xlab="SD of Normal", ylim=c(0.9, 1.2),
#plot(x=sd_seq, y=sim_avg, xlab="SD of Normal", ylim=c(1.071, 1.073),
     ylab="Estimate of integration", pch=15, col="blue", cex=1)
points(x=sd_seq, y=sim_avg+sim_sd , pch="-", col="blue",
       cex=2)
points(x=sd_seq, y=sim_avg-sim_sd , pch="-", col="blue",
       cex=2)
for(i in 1:length(sd_seq)){
  segments(x0 = sd_seq[i], y0 = sim_avg[i]+sim_sd[i], 
           y1=sim_avg[i]-sim_sd[i], lwd=2, col="blue")
}
  # this gives you an idea of estimate and its errors
  # the corresponding error bars denotes the error of monte carlo simulation


### power of a test
fn_power = function(mu, n){
  return(1-pnorm(qnorm(0.95)-sqrt(n)*mu))+pnorm(-qnorm(0.95)-sqrt(n)*mu)
}

n=16
  # in our demo, we use sample size 16 as the same of lecture note

## first we try a fixed mu:
mu0 = 0.5

data =rnorm(n=16, mean = mu0)
T_stats = sqrt(n)*(abs(mean(data))-0)/1
  # test statistic
T_stats > qnorm(0.95)
  # check if test stats is greater than the threshold


## use Monte Carlo to check the power: repeat many times
N = 10000
H0_reject = rep(NA, N)
for(i in 1:N){
  data =rnorm(n=16, mean = mu0)
  T_stats = sqrt(n)*(abs(mean(data))-0)/1
  H0_reject[i] = T_stats > qnorm(0.95)
}
H0_reject

mean(H0_reject)
  # an estimate of the number of H0 being rejected

fn_power(mu0, n)
  # the answer

sd(H0_reject)/sqrt(N)
  # error of Monte Carlow Simulation



### power curve
mu_seq = seq(from=-2, to=+2, by=0.05)

plot(x=mu_seq, y= fn_power(mu_seq,n=16), type="l",lwd=3,
     col="blue", ylab="Power", xlab="mu")
  # this is the actual power curve


## using Monte Carlo Simulation to estimate the power curve
N = 1000

sim_power = rep(NA, length(mu_seq))

for(i_sim in 1:length(mu_seq)){
  H0_reject = rep(NA, N)
  mu0 = mu_seq[i_sim]
  for(i in 1:N){
    data =rnorm(n=16, mean = mu0)
    T_stats = sqrt(n)*(abs(mean(data))-0)/1
    H0_reject[i] = T_stats > qnorm(0.95)
  }
  sim_power[i_sim] = mean(H0_reject)
}

plot(x=mu_seq, y= sim_power, type="l",lwd=3,
     col="red", ylab="Power", xlab="mu", main=paste("N =", N))
lines(x=mu_seq, y=fn_power(mu_seq, n=16), lwd=3, col="blue")
legend("bottomleft", c("Simulated","True"), col=c("red","blue"), 
       lwd=6)

paste("N =", N)
  # a function combine algebra and character

plot(x=mu_seq, y= sim_power, type="l",lwd=3,
     col=rgb(1,0,0,0.7), ylab="Power", xlab="mu", main=paste("N =", N))
lines(x=mu_seq, y=fn_power(mu_seq, n=16), lwd=3, col=rgb(0,0,1,0.7))
legend("bottomleft", c("Simulated","True"), 
       col=c(rgb(1,0,0,0.9),rgb(0,0,1,0.9)), 
       lwd=6)


#### Exercise 3: 
#### What is the probability that a standard normal random variable is
#### greater than 1.5?
#### (1) Let's use Monte Carlo simulations to find this out.
####     First, we simulate N=1000 data points from N(0,1).
####     Then we compute the ratio of these points above 1.5.

#### (2) What is the size of the error of this estimate? 
####     Let's repeat the above process for 10000 times and compute the
####     standard variance of the Monte Carlo estimator.

#### (3) Use a histogram to show the distribution of this estimate.
####     Also attach a vertical line to denote the theoretical value of
####     this probability.


### Power and sample size--an illustration from chicken weight data
chickwts

chickwts[chickwts$feed=="horsebean",]

## Suppose someone claim that the average weight is 260. 
## If we want to know chicken taking meatmeal is significantly different
## from the usual chicken. Namely, we want to test
##          H0: average weight of chicken taking meatmeal = 260
## Here is how we will do the t-test:
t.test(chickwts[chickwts$feed=="meatmeal",1], mu = 260)
  # the p-value=0.40 is not significant...

## Though we do not have enough evidence, this could be caused by the low power.
## Here is the mean and SD of those chicken taking meatmeal:
mean(chickwts[chickwts$feed=="meatmeal",1])
sd(chickwts[chickwts$feed=="meatmeal",1])

length(chickwts[chickwts$feed=="meatmeal",1])

## Assume the actual weight distribution of chicken taking meatmeal is
## N(277, 65^2), which fits perfectly with our observations. 
## Under this distribution, what is the chance that we reject H0 (mean=260)
## using only 11 sample?
## Let's use Monte Carlo simulation to figure it out.
## Assume the significance level alpha=0.10.
alpha0 = 0.10
n = 11

chickwt_sim = rnorm(n, mean=277, sd=65)
t.test(chickwt_sim, mu=260)$p.value

t.test(chickwt_sim, mu=260)$p.value < alpha0

N = 10000
sim_power = rep(NA, N)
for(i in 1:N){
  chickwt_sim = rnorm(n, mean=277, sd=65)
  sim_power[i] = t.test(chickwt_sim, mu=260)$p.value < alpha0
}

mean(sim_power)
  # only about 20%... this tells us that even if H0 is incorrect, we still do
  # not have much chance to reject it under 10% significance level 


## Now suppose we increase the sample size to n = 40, do we have more chance?
n = 40

sim_power = rep(NA, N)
for(i in 1:N){
  chickwt_sim = rnorm(n, mean=277, sd=65)
  sim_power[i] = t.test(chickwt_sim, mu=260)$p.value < alpha0
}

mean(sim_power)
  # we now have about a chance of 50%!


## In what follows, we will study the "power" under various sample size:
n_seq = seq(from=10, to=100, by=10)

sim_power_seq = rep(NA, length(n_seq))
for(i_sim in 1:length(n_seq)){
  n = n_seq[i_sim]
  sim_power = rep(NA, N)
  for(i in 1:N){
    chickwt_sim = rnorm(n, mean=277, sd=65)
    sim_power[i] = t.test(chickwt_sim, mu=260)$p.value < alpha0
  }
  sim_power_seq[i_sim] = mean(sim_power)
}
sim_power_seq

plot(x=n_seq, y=sim_power_seq, ylim=c(0,1), pch=16, cex=1.5,col="red",
     xlab="Sample size", ylab = "Power")
lines(x=n_seq, y=sim_power_seq, col="red", lwd=3)


###                              ###
### Part 4: Theory of Histogram  ###
###                              ###
n = 100
n_bin = 20

for(i_dummy in 1:100){
  hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin, xlim=c(0,1), 
       col="palegreen", probability = T, ylim=c(0,2))
  abline(h=5, lwd=2, col="purple")
  
  l_seq = seq(from=0, to=1, by=0.01)
  lines(l_seq, y=dbeta(l_seq,shape1=2, shape2=2), lwd=2, col="blue")
  Sys.sleep(0.5)
}


n = 100000
#n_bin = round(n^(1/3))
n_bin = n/20

for(i_dummy in 1:100){
  hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin, xlim=c(0,1), 
       col="palegreen", probability = T, ylim=c(0,2))
  abline(h=5, lwd=2, col="purple")
  
  l_seq = seq(from=0, to=1, by=0.01)
  lines(l_seq, y=dbeta(l_seq,shape1=2, shape2=2), lwd=2, col="blue")
  Sys.sleep(0.5)
}


### Error of histogram
### Question: what is the error of a histogram under certain number of bins?
n = 1000
n_bin = 10

hist0 = hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin,plot = F)
err = hist0$density - dbeta(hist0$mids, shape1=2, shape2=2)

mean(err^2)
  # average error over all bins


## check the distribution of that error due to simulation
N = 2000

bin_err = rep(NA, N)
for(i in 1:N){
  hist0 = hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin,plot = F)
  err = hist0$density - dbeta(hist0$mids, shape1=2, shape2=2)
  bin_err[i] =mean(err^2)
}

hist(bin_err, col="tan")
  # this shows the distribution of histogram error under 10 bins


## change the bin #
n_bin = 20
bin_err2 = rep(NA, N)
for(i in 1:N){
  hist0 = hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin,plot = F)
  err = hist0$density - dbeta(hist0$mids, shape1=2, shape2=2)
  bin_err2[i] =mean(err^2)
}

hist(bin_err2, col="palegreen")


n_bin = 5
bin_err3 = rep(NA, N)
for(i in 1:N){
  hist0 = hist(rbeta(n, shape1=2, shape2=2), breaks=n_bin,plot = F)
  err = hist0$density - dbeta(hist0$mids, shape1=2, shape2=2)
  bin_err3[i] =mean(err^2)
}

hist(bin_err3, col="orchid", probability = T)


## compare
hist(bin_err3, col=rgb(0.5,0,0.5,0.7), main="Histogram Errors Distribution", 
     probability = T, xlim=c(0,0.04), xlab="Histogram Error")
hist(bin_err, col=rgb(0,1,0,0.7), main="Histogram Errors", 
     probability = T, add=T)
hist(bin_err2, col=rgb(0.5,0.5,0,0.7), main="Histogram Errors", 
     probability = T, add=T)
legend("topright",c("# of bin = 5","# of bin = 10", "# of bin = 20"), 
       col=c(rgb(0.5,0,0.5,0.7),rgb(0,1,0,0.7),rgb(0.5,0.5,0,0.7)), lwd=6)


#### Exercise 4:
#### Let's return to the chicken weight data. 
#### This time we want to see if chicken taking soybean will have a significant
#### different weight on average. Suppose the average weight is 260. So we want
#### to test
####          H0: average weight of chicken taking soybean = 260
#### Assume we will use t.test.
#### (1) Can we reject the H0 under 10% significance level?

#### (2) Assume the actual weight distribution of chicken taking soybean is
####     N(246, 54^2), which fits perfectly with our observations. 
####     Under this distribution, what is the chance that we reject 
####     H0 (mean=260) using only 14 sample?
####     Use N =10000 Monte Carlo simulations to check this probability.

#### (3) Now suppose we increase the sample size to n = 50, 
####     how much chance will we have?

#### (4) What will the power be if we are using a sample size n= 15, 25, ... 95?





### (optional) fix sample size n, check how n_bin changes the error.
N = 1000
bin_width_seq = seq(from=0.04, to=0.40, by=0.02)
bin_err_seq = rep(NA, length(bin_width_seq))

for(i_width in 1:length(bin_width_seq)){
  break_pt = seq(from=-1, to=2, by=bin_width_seq[i_width])
  bin_err = rep(NA, length(bin_width_seq))
  for(i in 1:N){
    hist0 = hist(rbeta(n, shape1=2, shape2=2), breaks=break_pt,plot = F)
    err = hist0$density - dbeta(hist0$mids, shape1=2, shape2=2)
    bin_err[i] = mean(err^2)
  }
  bin_err_seq[i_width] = mean(bin_err)
}

plot(x= bin_width_seq, y=bin_err_seq, pch=16, cex=1.5, xlab="Bin width",
     ylab="Error of Histogram")
lines(x= bin_width_seq, y=bin_err_seq)
