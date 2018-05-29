## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 8 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                           ###
### Part 1: KDE--introduction ###
###                           ###
dat = faithful$waiting
hist(dat, breaks=20, col="limegreen")

dat_kde = density(dat)
plot(dat_kde, lwd=3)

dat_kde
dat_kde$x
dat_kde$y
  # x: location of grid point where density being evaulated
  # y: the density value corresponds to the point 'x'


## adjust smoothing bandwidth
dat_kde = density(dat, bw=1)
plot(dat_kde, lwd=3)


dat_kde = density(dat, bw=10)
plot(dat_kde, lwd=3)


### How smoothing bandwidth affects the density estimate.
h_seq = c(seq(from=0.5, to=2, by=0.1), seq(from=2.5,to=7.0,by=0.5),
          seq(from=7.2, to=9, by=0.2))
h_seq
for(h0 in h_seq){
  plot(density(dat, bw=h0), lwd=3, ylim=c(0, 0.055), col="dodgerblue",
       main=paste("h =",h0), xlim=c(40,100), xlab="X")
  Sys.sleep(1)
}


## change the grid points
dat_kde = density(dat, from = 0, to=200, n=5000)
  # n: number of grid points
plot(dat_kde, lwd=3)


## different kernel
dat_kde = density(dat, kernel = "rectangular")
plot(dat_kde, lwd=3)

dat_kde = density(dat, kernel='epanechnikov')
plot(dat_kde, lwd=3)


## effect of kernel
dat_kde1 = density(dat)
dat_kde2 = density(dat, kernel = "rectangular")
dat_kde3 = density(dat, kernel='epanechnikov')

plot(dat_kde1, lwd=2, col="red")
lines(dat_kde2, lwd=2, col="black")
lines(dat_kde3, lwd=2, col="blue")
legend("topleft",c("Gaussian","Rectangular","Epanechnikov"),
       lwd=6, col=c("red","black","blue"))


## bootstrap estimate
h0 = 4
dat_kde = density(dat, from = 20, to=120, n=5000, bw=h0)
n = length(dat)

w = sample(n,n,replace=T)
dat_BT = dat[w]
dat_kde_BT = density(dat_BT, from = 20, to=120, n=5000, bw=h0)
  # need to specify the same grid points and bandwidth

plot(dat_kde, lwd=3, ylim=c(0, 0.04))
lines(dat_kde_BT, lwd=3, col="red")


for(i in 1:100){
  w = sample(n,n,replace=T)
  dat_BT = dat[w]
  dat_kde_BT = density(dat_BT, from = 20, to=120, n=5000, bw=h0)
  
  plot(dat_kde, lwd=3, ylim=c(0, 0.04))
  lines(dat_kde_BT, lwd=3, col="red")
  
  Sys.sleep(1)
}

#### Exercise 1:
#### We use the 'iris' dataset and focus on the variable 'Petal.Width'.
#### (1) Use the smoothing bandwidth h=0.2, show the KDE along with a
####     density histogram.

#### (2) Use h=0.2, change the smoothing kernel to 'triangular' and 
####     'rectangular'. Show the estimated density curves and compare to
####     the histogram

#### (3) In a single plot, show the density curves estimated by KDE with
####     h = 0.1, 0.2, 0.5. 



###                        ###
### Part 2: KDE: Bootstrap ###
###                        ###
## bootstrap variance estimate
h0 = 4
dat_kde = density(dat, from = 20, to=120, n=1000, bw=h0)
n = length(dat)


B = 10000
gr_y = matrix(NA, nrow=B, ncol=length(dat_kde$x))
for(i in 1:B){
  w = sample(n,n,replace=T)
  dat_BT = dat[w]
  dat_kde_BT = density(dat_BT, from = 20, to=120, n=1000, bw=h0)
  
  gr_y[i,] = dat_kde_BT$y
}

head(gr_y)
gr_y_var = diag(var(gr_y))
gr_y_sd = sqrt(gr_y_var)


plot(x=dat_kde$x,y=gr_y_sd, type="l", lwd=3)
  # standard error at each location

plot(dat_kde, lwd=3, col="dodgerblue")
lines(x=dat_kde$x,y=gr_y_sd, lwd=3, col="brown")
legend("topleft",c("KDE","sd of KDE"), lwd=6, col=c("dodgerblue","brown"))


## CI of the KDE -- dashed line
plot(dat_kde, lwd=3, col="blue", ylim=c(0,0.04),
     main="90% CI of the KDE using bootstrap SD")
lines(x=dat_kde$x,y=dat_kde$y+qnorm(0.95)*gr_y_sd, lwd=3, col="dodgerblue",
      lty=2)
lines(x=dat_kde$x,y=dat_kde$y-qnorm(0.95)*gr_y_sd, lwd=3, col="dodgerblue",
      lty=2)

## CI of the KDE -- "band"
plot(dat_kde, lwd=3, col="blue", ylim=c(0,0.04),
     main="90% CI of the KDE using bootstrap SD")
polygon(x=c(dat_kde$x, rev(dat_kde$x)),
        y=c(dat_kde$y+qnorm(0.95)*gr_y_sd, rev(dat_kde$y-qnorm(0.95)*gr_y_sd)),
        col='skyblue', border = 'skyblue')
lines(dat_kde,  lwd=3, col="blue")



## quantile approach and the use of sapply
q95_loop = rep(NA,1000)
q05_loop = rep(NA,1000)
for(i in 1:1000){
  q95_loop[i] = quantile(gr_y[,i], 0.95)
  q05_loop[i] = quantile(gr_y[,i], 0.05)
}

## sapply: a faster way to do a loop
help(sapply)

sapply(1:10, exp)

sapply(1:10, function(x){dnorm(1,mean=0,sd=x)})
  
q95 = sapply(1:1000, function(x){quantile(gr_y[,x], 0.95)})
  # apply to each grid point
q05 = sapply(1:1000, function(x){quantile(gr_y[,x], 0.05)})


# CI of the KDE -- dashed line
plot(dat_kde, lwd=3, col="purple", ylim=c(0,0.04),
     main="90% CI of the KDE using bootstrap SD")
lines(x=dat_kde$x,y=q95, lwd=3, col="violet",
      lty=2)
lines(x=dat_kde$x,y=q05, lwd=3, col="violet",
      lty=2)


# CI of the KDE -- "band"
plot(dat_kde, lwd=3, col="purple", ylim=c(0,0.04),
     main="90% CI of the KDE using bootstrap SD")
polygon(x=c(dat_kde$x, rev(dat_kde$x)),
        y=c(q95, rev(q05)),
        col='violet', border = 'violet')
lines(dat_kde,  lwd=3, col="purple")


#### Exercise 2:
#### Again, we will use the 'iris' dataset and variable 'Petal.Width'.
#### (1) Use the KDE with h=0.2 and find a 90% CI of the density curve.
####     Plot the estimated density curve along with the CI.

#### (2) Use the KDE with h=0.1 and find a 90% CI of the density curve.
####     Plot the estimated density curve along with the CI.


#### (3) Use the KDE with h=0.5 and find a 90% CI of the density curve.
####     Plot the estimated density curve along with the CI.


#### (4) Compared the previous three plots, which smoothing bandwidth leads to
####     a shortest CI on average? 



###                          ###
### Part 3: KDE--Uncertainty ###
###                          ###
### analyze the bias and variance
n = 1000
h0 = 0.2

rmultinom(1, 100, prob=c(0.3,0.3,0.4))
U = rmultinom(1, n, prob=c(0.3,0.3,0.4))
U

mu1 = 0
mu2 = 4
mu3 = 8
sd1 = sd2 = 1
sd3 = 1
dat1 = c(rnorm(U[1], mean=mu1,sd=sd1), rnorm(U[2], mean=mu2,sd=sd2),
         rnorm(U[3],mean=mu3,sd=sd3))

dat1
hist(dat1, breaks=30, probability = T, col="palegreen")


### KDE
dat1_kde = density(dat1, from=-5, to=15, n=1000,bw=h0)

true_density = 0.3*dnorm(dat1_kde$x,mean=mu1,sd=sd1)+
  0.3*dnorm(dat1_kde$x,mean=mu2,sd=sd2)+
  0.4*dnorm(dat1_kde$x,mean=mu3,sd=sd3)

plot(x=dat1_kde$x, y=true_density, ylim=c(0,0.35), type="l",
     lwd=3, col="blue")
lines(dat1_kde, lwd=3, col="red")
legend("topleft",c("KDE","True"),lwd=6, col=c("blue","red"))

### a realization of difference
diff = dat1_kde$y- true_density

plot(x=dat1_kde$x,diff, type="l", lwd=3, col="purple",
     ylim=c(-0.05,0.05))
abline(h=0, lwd=3, col="gray")



### Monte Carlo Estimation of the errors
N = 10000
dat1_kdey_MC = matrix(NA, nrow=N, ncol=1000)
for(i in 1:N){
  U = rmultinom(1, n, prob=c(0.30,0.30,0.4))
  dat1_MC = c(rnorm(U[1], mean=mu1,sd=sd1), rnorm(U[2], mean=mu2,sd=sd2),
              rnorm(U[3], mean=mu3,sd=sd3))
  dat1_kde_MC = density(dat1_MC, from=-5, to=15, n=1000,bw =h0)
  dat1_kdey_MC[i,] = dat1_kde_MC$y
}

dat1_kdey_var = sapply(1:1000, function(x){var(dat1_kdey_MC[,x])})
dat1_kdey_mse = colSums((t(t(dat1_kdey_MC)- true_density))^2)/N


plot(x=dat1_kde$x, y=true_density, ylim=c(0,0.35), type="l",
     lwd=3, col="blue")
lines(x=dat1_kde$x, y=sqrt(dat1_kdey_var), col="red")
lines(x=dat1_kde$x, y=sqrt(dat1_kdey_mse), col="black")


sum(dat1_kdey_var)
  # ~ integrated variance (without scaling)
sum(dat1_kdey_mse)
  # ~ MISE (without scaling)

## scaling:
sum(dat1_kdey_var)*(dat1_kde$x[2]-dat1_kde$x[1])
sum(dat1_kdey_mse)*(dat1_kde$x[2]-dat1_kde$x[1])


### What happen if we choose different h?
### Now we perform a "simulation study" to understand it.
### This is a very common approach in practice to analyze the performance
### of a certain estimator.
h0_seq = seq(from=0.1,to=0.5, by=0.05)
  # consider several possible smoothing bandwidth
N = 10000
  # size of monte carlo simulation

var_seq = rep(NA, length(h0_seq))
mise_seq = rep(NA, length(h0_seq))
for(i_MC in 1:length(h0_seq)){
  h0 = h0_seq[i_MC]
    # choose the smoothing parameter
  dat1_kdey_MC = matrix(NA, nrow=N, ncol=1000)
  for(i in 1:N){
    U = rmultinom(1, n, prob=c(0.3,0.3,0.4))
    dat1_MC = c(rnorm(U[1], mean=mu1,sd=sd1), rnorm(U[2], mean=mu2,sd=sd2),
                rnorm(U[3], mean=mu3,sd=sd3))
    dat1_kde_MC = density(dat1_MC, from=-5, to=15, n=1000,bw =h0)
    dat1_kdey_MC[i,] = dat1_kde_MC$y
  }
  dat1_kdey_var = sapply(1:1000, function(x){var(dat1_kdey_MC[,x])})
  dat1_kdey_mse = colSums((t(t(dat1_kdey_MC)- true_density))^2)/N
  
  var_seq[i_MC] = sum(dat1_kdey_var)
  mise_seq[i_MC] = sum(dat1_kdey_mse)
  print(i_MC)
  # print out each iteration
}

plot(x= h0_seq, y= mise_seq, type="l", ylim=c(0,0.2),lwd=3,
     ylab="errors", xlab="smoothing bandwidth", col="brown")
lines(x= h0_seq, y= var_seq, lwd=3, col="limegreen")
legend("bottomleft", c("MISE","Integrated VAR"), lwd=6,
       col=c("brown","limegreen"))


#### Exercise 3:
#### Perform a simulation study to analyze the MISE and integrated variance
#### of the KDE using a data generated from a Gaussian mixture model:
#### 0.35*N(0,1) + 0.65*N(4,1).
#### Namely, with a probability of 0.35, one data point is generated from
#### N(0,1) and with a probability of 0.65 this data point is genereated from
#### N(4,1). 
#### Assume the sample size n=1000. 
#### (1) First simulate a random sample from the above Gaussian mixture model.


#### (2) Apply the KDE with smoothing bandwith 0.3. Plot the KDE and the
####     true density curve from the Gaussian mixture model.

#### (3) Use Monte Carlo simulation N=10000 times to compute the MISE.

#### (4) Change the smoothing bandwidth a bit to analyze how the MISE
####     changes with respect to the smoothing bandwidth.
####     For simplicity, we consider the smoothing bandwidth withi [0.1,0.5].
####     Show the error versus smoothing bandwidth plot.
####     About what value will the smoothing bandwidth minimized the errors?

###                ###
### Part 4: 2D KDE ###
###                ###
library(KernSmooth)
data1 = cbind(iris$Sepal.Length, iris$Petal.Length)

plot(data1)

iris_kde <- bkde2D(data1, bandwidth = 0.25,
                   gridsize = c(51,51),
                   range.x=list(c(4,8),c(1,7)))
  # bandwidth: smoothing bandwidth
  # gridsize: grid size on both x,y-axis
  # range.x: a list consists of the range of x and y

contour(x=iris_kde$x1,y=iris_kde$x2,
        z=iris_kde$fhat, lwd=3, 
        main="Density Contour (Iris Data)",
        xlab="Sepal.Length", ylab="Petal.Length")

contour(x=iris_kde$x1,y=iris_kde$x2,
        z=iris_kde$fhat, lwd=3, 
        main="Density Contour (Iris Data)",
        xlab="Sepal.Length", ylab="Petal.Length",
        nlevels=20, col=c("blue"))
points(data1, col="red",pch=20)


### perspective plot
persp(x=iris_kde$x1,y=iris_kde$x2,
      z=iris_kde$fhat, col="palegreen",
      xlab="Sepal.Length", ylab="Petal.Length",
      zlab="Density", theta=150, phi=30)
  # theta: rotational angle
  # phi: vertical angle

for(w in (1:36)*10){
  persp(x=iris_kde$x1,y=iris_kde$x2,
        z=iris_kde$fhat, col="palegreen",
        xlab="Sepal.Length", ylab="Petal.Length",
        zlab="Density", theta=w, phi=40)
  Sys.sleep(0.1)
}

## a non-stopping animation
x0 = 1 
w = 10
while(x0<2){
  persp(x=iris_kde$x1,y=iris_kde$x2,
        z=iris_kde$fhat, col="palegreen",
        xlab="Sepal.Length", ylab="Petal.Length",
        zlab="Density", theta=w, phi=40)
  w= w+5
  Sys.sleep(0.1)
}

for(w in c((0:9)*10, (9:0)*10)){
  persp(x=iris_kde$x1,y=iris_kde$x2,
        z=iris_kde$fhat, col="skyblue",
        xlab="Sepal.Length", ylab="Petal.Length",
        zlab="Density", theta=10, phi=w)
  Sys.sleep(1)
}


### using the image function
image(x=iris_kde$x1,y=iris_kde$x2,
      z=iris_kde$fhat, xlab="Sepal.Length", 
      ylab="Petal.Length", main="Density (Heat Map)")
points(data1, pch=20)

## change the color using Palette
colP = colorRampPalette(c("white","dodgerblue","purple"))
image(x=iris_kde$x1,y=iris_kde$x2,
      z=iris_kde$fhat, xlab="Sepal.Length", 
      ylab="Petal.Length", main="Density (Heat Map)",
      col=colP(50))
points(data1, pch=20, cex=0.5)


### colored contour
col_tmp <- colorRampPalette(c("white","limegreen","orchid"))(10)
level_tmp <- (0:10)/10*max(c(iris_kde$fhat))
  # defining the levels and the corresponding colors 
plot(NULL, xlim=c(4,8), ylim=c(1,7),
     main="Density Contour (Iris Data)",
     xlab="Sepal.Length", ylab="Petal.Length")
  # this makes an empty plot
.filled.contour(x=iris_kde$x1,y=iris_kde$x2,
                z=iris_kde$fhat,
                levels=level_tmp, 
                col=col_tmp)
  # this filled in the colored contours
points(data1, col="black",pch=20)
  # finally we add data points

#### Exercise 4:
#### In this problem, we will analyze the 'faithful' dataset using the 
#### current eruption time versus the next eruption time:
data_new = cbind(faithful[1:271,1],faithful[2:272,1])
plot(data_new)
#### (1) Use a 2D KDE with smoothing bandwidth h=0.2. Show the contour plot
####     and attach the data points to it.

#### (2) Use a perspective plot to show how the density looks like. Change
####     'theta' and 'phi' to see the full picture of the 2D density.

#### (3) Consider the following sequence of smoothing bandwidth:
h_seq = seq(from=0.1,to=1, by=0.02)
####     Make an animation showing the 2D KDE under different values of h.
####     You can use either a contour plot or a perspective plot (or others).

