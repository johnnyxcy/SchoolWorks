## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 2 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###              ###
### Part 1: CDF  ###
###              ###
### normal distribution
pnorm(-2)
pnorm(-1)
pnorm(0)
pnorm(1)
pnorm(2)

x_base = seq(from=-4, to=4, by=0.01)
plot(x=x_base, y=pnorm(x_base), type="l")
  # this creates the CDF curve

plot(x=x_base, y=pnorm(x_base), type="l", lwd=3,
     col="blue")
abline(h=0)
  # abline(h=0): add the horizontal line at y=0


### t-distribution
x_base = seq(from=-4, to=4, by=0.01)
plot(x=x_base, y=pt(x_base, df=1), type="l")
  # pt: CDF of t-distribution
  # df=1: degree of freedom of t-distribution

plot(x=x_base, y=pt(x_base, df=1), type="l",
     ylim=c(0,1))
  # ylim=c(0,1): set the range of Y-axis
abline(h=0)


## overlay multiple curves
x_base = seq(from=-4, to=4, by=0.01)
plot(x=x_base, y=pnorm(x_base), type="l", lwd=3, col="blue")
lines(x=x_base, y=pt(x_base, df=1), lwd=3, col="red")
abline(h=0)

legend("topleft", c("Normal","T (df=1)"), lwd=3, col=c("blue","red"))
  # add a legend; please play around with each argument to
  # see its functionality.

plot(x=x_base, y=pnorm(x_base), type="l", lwd=3, col="blue")
lines(x=x_base, y=pt(x_base, df=1), lwd=3, col="red")
lines(x=x_base, y=pt(x_base, df=2), lwd=3, col="orchid")
lines(x=x_base, y=pt(x_base, df=5), lwd=3, col="purple")
abline(h=0)

legend("topleft", c("Normal","T (df=1)","T (df=2)", "T (df=5)"), 
       lwd=3, col=c("blue","red","orchid","purple"))
  # this shows that when df -> infinity, t-distribution reduces to
  # Normal distribution


### Normal distribution with different mean
x_base = seq(from=-4, to=4, by=0.01)
plot(x=x_base, y=pnorm(x_base), type="l", lwd=3, col="blue")
lines(x=x_base, y=pnorm(x_base, mean = -2), lwd=3, col="limegreen")
lines(x=x_base, y=pnorm(x_base, mean = -1), lwd=3, col="seagreen")
lines(x=x_base, y=pnorm(x_base, mean = 1), lwd=3, col="blueviolet")
lines(x=x_base, y=pnorm(x_base, mean = 2), lwd=3, col="violet")
abline(h=0)

legend("topleft", c("mean=0", "mean=-2", "mean=-1", "mean=1",
                    "mean=2"), 
       lwd=3, col=c("blue","limegreen","seagreen","blueviolet",
                    "violet"))


### Normal distribution with different variance
x_base = seq(from=-4, to=4, by=0.01)
plot(x=x_base, y=pnorm(x_base), type="l", lwd=3, col="blue")
lines(x=x_base, y=pnorm(x_base, sd=0.5), lwd=3, col="skyblue")
lines(x=x_base, y=pnorm(x_base, sd=2), lwd=3, col="tan")
lines(x=x_base, y=pnorm(x_base, sd=3), lwd=3, col="orange")
abline(h=0)

legend("topleft", c("sd=1", "sd=0.5", "sd=2", "sd=3"), 
       lwd=3, col=c("blue","skyblue","tan","orange"))


### Exercise 1.1: 
###  In one plot, show the CDF of uniform distribution over [-4,4]
###  and Exp(2) and N(0,1) for x within [-5, 5].


### Exercise 1.2: 
###  In one plot, show the CDF of Exp(1), Exp(2), Exp(5), Exp(10)
###  for x within [0, 4].


###              ###
### Part 2: EDF  ###
###              ###
x = c(1,3,4, 9,13)
x_edf = ecdf(x)

x_edf

str(x_edf)
  # 'x_edf' is a function

knots(x_edf)

x_edf(0)
x_edf(2)
x_edf(4)
x_edf(6)


## plotting EDF (it is already programmed)
plot(x_edf)

plot(x_edf, xlim=c(-5, 20), col="royalblue", lwd=3, cex=2,
     pch=2,verticals=T)
  # you can adjust many layout of it


x_base = seq(from=-2, to=15, by=0.01)
plot(x=x_base, y=x_edf(x_base), type="l", lwd=3, col="blue")
  # you can use what we have learnd to visualize it


## EDF of a randomly generated sample
data = rnorm(100)
data_edf = ecdf(data)

plot(data_edf, xlim=c(-4,4))

plot(data_edf, xlim=c(-4,4), do.points=F, col="red")
  # do.points=F: no the big bullet for data points

plot(data_edf, xlim=c(-4,4), do.points=F, col="red",
     verticals = T)
x_base = seq(from=-4, to=4, by=0.01)
lines(x=x_base, y=pnorm(x_base), col="blue")
  # compare to the CDF


## compare 10 curves
plot(x=x_base, y=pnorm(x_base), col="royalblue", type="l",
     lwd=5)
for(i in 1:10){
  data = rnorm(100)
  data_edf = ecdf(data)
  lines(data_edf, do.points=F, lwd=2, verticals=T, 
        col="gray50")
}

lines(x=x_base, y=pnorm(x_base), col="royalblue", lwd=5)

## compare 10 curves: change sample size
plot(x=x_base, y=pnorm(x_base), col="royalblue", type="l",
     lwd=5)
for(i in 1:10){
  data = rnorm(100)
  data_edf = ecdf(data)
  lines(data_edf, do.points=F, lwd=2, verticals=T, 
        col="gray50")
}
  # this shows the convergence of EDF to CDF
lines(x=x_base, y=pnorm(x_base), col="royalblue", lwd=5)


### Exercise 2.1: 
### Given 5 points 1,1,3,4,7, show the EDF curve using these points.  

### Exercise 2.2: 
### Generate 50 points from N(0,1), call it data1.
### Generate another new 50 points from Exp(1), call it data2.
### In the same plot, show two EDF curves, one is from data1 and
### the other is from data2.


### (optional) confidence interval for CDF?
n=100
data = rnorm(n)
data_edf = ecdf(data)
x_base = seq(from=-4, to=4, by=0.01)

var_edf = data_edf(x_base)*(1-data_edf(x_base))/n
se_edf = sqrt(var_edf)


# method 1
plot(data_edf, do.points=F, lwd=3, verticals=T,
     col="blue")
lines(x=x_base, y=data_edf(x_base)-qnorm(0.95)*se_edf,
     col="dodgerblue", lwd=2, lty=2)
lines(x=x_base, y=data_edf(x_base)+qnorm(0.95)*se_edf,
      col="dodgerblue", lwd=2, lty=2)
  # lty=2: dashed curves


# method 2
plot(data_edf, do.points=F, lwd=3, verticals=T,
     col="blue")
polygon(c(x_base,rev(x_base)), 
        y=c(data_edf(x_base)-qnorm(0.95)*se_edf,
            rev(data_edf(x_base)+qnorm(0.95)*se_edf)), 
        col ="lightblue", border = "dodgerblue")
  # polygon: a function to generate a polygon from points
lines(data_edf, do.points=F, lwd=3, verticals=T,
      col="blue")

lines(x=x_base, y=pnorm(x_base), col="red", lwd=2)


###                  ###
### Part 3: KS-test  ###
###                  ###
### CDF curves from different population
data1 = rnorm(100)
data2 = rexp(100, rate = 1)

data1_edf = ecdf(data1)
data2_edf = ecdf(data2)

plot(data1_edf, do.points=F, lwd=3, verticals=T,
     col="orchid", xlim=c(-3, 5))
lines(data2_edf, do.points=F, lwd=3, verticals=T,
      col="tan")


## repeat 10 times for each case
plot(NULL, xlim=c(-3, 5), ylim=c(0,1))
for(i in 1:10){
  data1 = rnorm(100)
  data2 = rexp(100, rate = 1)
  data1_edf = ecdf(data1)
  data2_edf = ecdf(data2)

  lines(data1_edf, do.points=F, lwd=2, verticals=T,
       col="orchid", xlim=c(-3, 5))
  lines(data2_edf, do.points=F, lwd=2, verticals=T,
        col="tan")
}
  # their CDF looks very different


### Two-sample test--H0: F1 = F2
# 1.
data1 = rnorm(100)
data2 = rexp(100, rate = 1)

ks.test(data1,data2)

# 2. smaller sample size
data1 = rnorm(25)
data2 = rexp(25, rate = 1)

ks.test(data1,data2)

# 3. even smaller sample size
data1 = rnorm(10)
data2 = rexp(10, rate = 1)

ks.test(data1,data2)

# 4. Case of H0 being true:
data1 = rnorm(10)
data2 = rnorm(100)

ks.test(data1,data2)

# 5. distribution of p-values: H0 is true.
p1_dis = rep(NA, 10000)
for(i in 1:10000){
  data1 = rnorm(10)
  data2 = rnorm(100)
  p1_dis[i] = ks.test(data1,data2)$p.value
}
hist(p1_dis, probability = T, col="palegreen")

# 6. distribution of p-values: H0 is false
p2_dis = rep(NA, 10000)
for(i in 1:10000){
  data1 = rnorm(10)
  data2 = rexp(100, rate = 1)
  p2_dis[i] = ks.test(data1,data2)$p.value
}
hist(p2_dis, probability = T, col="orchid")

which(p2_dis<0.05)

length(which(p2_dis<0.05))/10000


# 7. Normal versus Normal: H0 is true:
p3_dis = rep(NA, 10000)
for(i in 1:10000){
  data1 = rnorm(50)
  data2 = rnorm(50)
  p3_dis[i] = ks.test(data1,data2)$p.value
}
hist(p3_dis, probability = T, col="skyblue")


# 8. Normal versus Normal: H0 is false:
p4_dis = rep(NA, 10000)
for(i in 1:10000){
  data1 = rnorm(50)
  data2 = rnorm(50, sd=3)
  p4_dis[i] = ks.test(data1,data2)$p.value
}
hist(p4_dis, probability = T, col="tan")


### Exercise 3.1: 
### Generate 100 points from Exp(1), called it data1.
### Generate another 100 points from Exp(2), called it data2.
### Plot the EDF curves of both data in the same figure.
### Use KS-test to see the p-value; repeat this process several times.
###
### Change the sampling distribution of data2 to Exp(1) and Exp(3);
### repeat the above procedure to see how the p-value changes.


### For a given x, does EDF reduces to a Bernoulli distribution?
x0 = 2
data1 = rexp(100, rate = 1)
data1_edf = ecdf(data1)

data1_edf(x0)

#
cdf_x0 = rep(NA, 10000)
for(i in 1:10000){
  x0 = 2
  data1 = rexp(100, rate = 1)
  data1_edf = ecdf(data1)
  
  cdf_x0[i] = data1_edf(x0)
}
hist(cdf_x0, probability = T, col="lightgreen")

x_base = seq(from=0.70, to=1, by=0.001)
mu0 = pexp(2)
sd0 = sqrt(pexp(2)*(1-pexp(2))/100)
  # mean and SD of the Bernoulli distribution
lines(x=x_base, y=dnorm(x_base, mean=mu0,
                        sd= sd0), lwd=3, col="purple")
  # purple: central limit theorem
  # green: distribution we simulate


###                            ###
### Part 4: Using inverse CDF  ###
###                            ###
runif(100)
  # generates 100 random numbers from Uniform [0,1]. 

## quantile
x_base = seq(from=0.001, to=0.999, by=0.001)
plot(x=x_base, y=qnorm(x_base), type="l", lwd=3)


# two ways of generating distributions
data1 = rnorm(100)
data2 = qnorm(runif(100))

data1_edf = ecdf(data1)
data2_edf = ecdf(data2)

plot(data1_edf, do.points=F, lwd=3, verticals=T,
     col="gray30", xlim=c(-3, 5))
lines(data2_edf, do.points=F, lwd=3, verticals=T,
      col="hotpink")
legend("bottomright",c("rnorm","Inv CDF"), col=c("gray30","hotpink"),
       lwd=6)

ks.test(data1,data2)


# using opaque color
plot(NULL, xlim=c(-3,5),ylim=c(0,1), ylab="Fn(x)", xlab="X")
for(i in 1:10){
  data1 = rnorm(100, sd=1)
  data2 = qnorm(runif(100))
  
  data1_edf = ecdf(data1)
  data2_edf = ecdf(data2)
  
  lines(data1_edf, do.points=F, lwd=3, verticals=T,
       col=rgb(1,0,0,0.3), xlim=c(-3, 5))
  lines(data2_edf, do.points=F, lwd=3, verticals=T,
        col=rgb(0,0.5,1,0.3))
}
legend("bottomright",c("rnorm","Inv CDF"), 
       col=c(rgb(1,0,0,0.9),rgb(0,0.5,1,0.9)),
       lwd=6)


# another distribution
plot(NULL, xlim=c(-0.5,10),ylim=c(0,1), ylab="Fn(x)", xlab="X")
for(i in 1:10){
  data1 = rgamma(100, shape=2)
  data2 = qgamma(runif(100), shape=3)
  
  data1_edf = ecdf(data1)
  data2_edf = ecdf(data2)
  
  lines(data1_edf, do.points=F, lwd=3, verticals=T,
        col=rgb(0.5,0,1,0.3))
  lines(data2_edf, do.points=F, lwd=3, verticals=T,
        col=rgb(0,1,0,0.3))
}
legend("bottomright",c("rnorm","Inv CDF"), 
       col=c(rgb(0.5,0,1,0.9),rgb(0,1,0,0.9)),
       lwd=6)


### Exercise 4.1: 
### Generate 100 points from Exp(1), call it data1.
### Use inverse CDF method to generate 100 points from Exp(1),
### call it data2.
### (1) Plot the EDF curves of both data in the same figure.
### (2) Using for loop to display 10 curves for each case in the same
###     figure.
### (3) Change data1 to Exp(0.5) and Exp(2), repeat (1) and (2) to see
###     how the rate parameter changes the EDF.






