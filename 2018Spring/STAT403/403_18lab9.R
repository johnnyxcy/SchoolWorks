## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 9 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                           ###
### Part 1: Kernel Regression ###
###                           ###
### we will be using the abalone dataset again 
data0 = read.table("abalone.data", sep=",")
names(data0) = c("Sex","Length","Diameter","Height","Whole weight",
                 "Shucked weight", "Viscera weight","Shell weight","Rings")

plot(data0$Diameter, data0$`Whole weight`)

w = which(data0$Sex=="F")
X = data0$Diameter[w]
Y = data0$`Whole weight`[w]

plot(X,Y)
abline(lm(Y~X), lwd=3, col="red")
  # linear fit does not give a reasonable result


data0_reg = ksmooth(x=X,y=Y, kernel = "normal",bandwidth = 0.05)
  # kernel: smoothing kernel
  # bandwidth: the smoothing bandwidth

plot(X,Y)
lines(data0_reg, lwd=3, col="limegreen")
  # a much better fit


## effect of smoothing bandwidth
h_seq = c((1:20)/500,0.05,0.07,0.09,0.15, 0.3)
h_seq

x0 = 1
while(x0>0){
  for(h0 in h_seq){
    kernel_reg = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=h0)
    
    plot(X,Y, pch=20, main=paste("h =",h0))
    lines(kernel_reg, lwd=3, col="red")
    Sys.sleep(1)
  }
}

### Cross Validation
n = length(X)
N_cv = 100
k = 5
  # 5-fold CV
cv_lab = sample(n,n,replace=F) %% k
cv_lab

h_seq = c((1:20)/500)
h_seq

CV_err_h = rep(0,length(h_seq))
for(i_tmp in 1:N_cv){
  CV_err_h_tmp = rep(0, length(h_seq))
  cv_lab = sample(n,n,replace=F) %% k
  for(i in 1:length(h_seq)){
    h0 = h_seq[i]
    CV_err =0 
    for(i_cv in 1:k){
      w_val = which(cv_lab==(i_cv-1))
      X_tr = X[-w_val]
      Y_tr = Y[-w_val]
      X_val = X[w_val]
      Y_val = Y[w_val]
      kernel_reg = ksmooth(x = X_tr,y=Y_tr,kernel = "normal",bandwidth=h0,
                           x.points=X_val)
      CV_err = CV_err+mean((Y_val[order(X_val)]-kernel_reg$y)^2,na.rm=T)
        # WARNING! The ksmooth() function will order the x.points from smallest
        # to the largest!
        # na.rm = T: remove the case of 'NA'
    }
    CV_err_h_tmp[i] = CV_err/k
  }
  CV_err_h = CV_err_h+CV_err_h_tmp
}
CV_err_h = CV_err_h/N_cv

plot(h_seq,CV_err_h, type="b", lwd=4, col="blue", xlab="Smoothing Bandwidth",
     ylab="CV Error")
  # So we should pick h~~0.02

h_opt = h_seq[which(CV_err_h==min(CV_err_h))]
h_opt


#### Exercise 1:
#### We will use the dataset 'iris' in this problem. In particular, we choose
#### the covariate X to be 'Petal.Length' and the response Y to be 
#### 'Sepal.Length'.
#### (1) Use the kernel regression with smoothign bandwidth h =0.5.
####     Show the scatter plot of X and Y. Attach the fitted regression curve.
####     Also attach the regression line from a simple linear regression.

#### (2) Now fit the data with three different smoothing bandwidth 
####     h = 0.2, 0.5, 1. Show the scatter plot of the data along with the
####     three regression curves. 

#### (3) Using a 5-fold cross-validation to show the smoothing bandwidth
####     versus cross-validation error plot. What is the smoothing bandwidth
####     that minimizes the error?



###                             ###
### Part 2: Confidence Interval ###
###                             ###
### Assume we pick h = h_opt, how to construct a CI?
h0 = h_opt

gr_x = seq(from=0.05, to =0.65, by=0.005)
gr_y = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=h0,x.points = gr_x)$y
  # x.points: where to evaluate the value of regression

plot(X,Y)
lines(gr_x,gr_y, lwd=3, col="purple")

## here we will use the "wild bootstrap" & "empirical bootstrap"
n = length(X)
B = 10000

X_order = X[order(X)]
Y_order = Y[order(X)]
  # same X and Y but just different values

Y_predict = ksmooth(x = X_order,y=Y_order,kernel = "normal",
                    bandwidth=h0,x.points = X)$y
res =Y_order- Y_predict
  # WARNING! The ksmooth() function will order the x.points from smallest
  # to the largest!

plot(X_order, res)
  # the plot of residuals--we do observe an increasing pattern

gr_y_BT_wild = matrix(NA, nrow=B, ncol=length(gr_y))
gr_y_BT = matrix(NA, nrow=B, ncol=length(gr_y))
for(i_bt in 1:B){
  Y_BT = Y_predict+ res*rnorm(n)
  #plot(X_order, Y_BT)
  gr_y_BT_wild[i_bt,] = ksmooth(x = X_order,y=Y_BT,kernel = "normal",
                           bandwidth=h0,x.points = gr_x)$y
  
  ## empirical bootstrap
  w = sample(n,n,replace=T)
  X_BT = X[w]
  Y_BT = Y[w]
  gr_y_BT[i_bt,] = ksmooth(x = X_BT,y=Y_BT,kernel = "normal",
                                bandwidth=h0,x.points = gr_x)$y
}

gr_y_sd_wild = sapply(1:length(gr_x), function(x){
  sd(gr_y_BT_wild[,x])
})

gr_y_sd = sapply(1:length(gr_x), function(x){
  sd(gr_y_BT[,x], na.rm=T)
})


plot(X,Y, pch=20, cex=0.5)
lines(gr_x,gr_y, lwd=2, col="red")
lines(gr_x,gr_y+qnorm(0.999)*gr_y_sd_wild, lwd=2, col="red", lty=2)
lines(gr_x,gr_y-qnorm(0.999)*gr_y_sd_wild, lwd=2, col="red", lty=2)
# the error is very small!


plot(X,Y, pch=20, cex=0.5)
lines(gr_x,gr_y, lwd=2, col="purple")
lines(gr_x,gr_y+qnorm(0.999)*gr_y_sd, lwd=2, col="purple", lty=2)
lines(gr_x,gr_y-qnorm(0.999)*gr_y_sd, lwd=2, col="purple", lty=2)


## comparison
plot(X,Y, pch=20, cex=0.5, col="gray")
lines(gr_x,gr_y, lwd=2, col="black")
lines(gr_x,gr_y+qnorm(0.999)*gr_y_sd_wild, lwd=2, col="red", lty=2)
lines(gr_x,gr_y-qnorm(0.999)*gr_y_sd_wild, lwd=2, col="red", lty=2)
lines(gr_x,gr_y+qnorm(0.999)*gr_y_sd, lwd=2, col="purple", lty=2)
lines(gr_x,gr_y-qnorm(0.999)*gr_y_sd, lwd=2, col="purple", lty=2)
legend("topleft",c("Wild Bootstrap","Empirical Bootstrap"),
       col=c("red","purple"), lwd=6)


#### Exercise 2:
#### We will use the dataset 'iris' in this problem. In particular, we choose
#### the covariate X to be 'Petal.Length' and the response Y to be 
#### 'Sepal.Length'.
#### (1) Using the smoothing bandwidth h = 0.5. Apply nonparametric bootstrap
####     to find a 99% CI of the regression function.

#### (2) Using the smoothing bandwidth h = 0.5. Show the residual versus
####     covariate plot. Does the variation of residual depends on the 
####     covaraite?

#### (3) Apply the wild bootstrap to find a 99% CI of the regression function.

#### (4) Compare the two CI's. Do they agree? What regions do they disagree
####     the most.

###                                  ###
### Part 3: Prediction Errors and CV ###
###                                  ###
n = 250
X = runif(n, min=0, max=2*pi)
Y = sin(X)+rnorm(n, sd=0.3)

gr_x = seq(from=0,to=2*pi, by=0.01)
gr_y_true = sin(gr_x)


plot(X,Y, pch=20, col="gray")
kernel_reg = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=0.5)
lines(gr_x,gr_y_true, lwd=3, col="blue")
lines(kernel_reg, lwd=3, col="red")


### Errors of Estimation
h0 = 1

x0 = 1
while(x0>0){
  X = runif(n, min=0, max=2*pi)
  Y = sin(X)+rnorm(n, sd=0.3)
  plot(X,Y, pch=20, col="gray", main=paste("h =", h0),
       xlim=c(0,2*pi),ylim=c(-1.5,1.5), cex=0.5)
  kernel_reg = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=h0)
  lines(gr_x,gr_y_true, lwd=3, col="blue")
  lines(kernel_reg, lwd=3, col="red")
  Sys.sleep(0.5)
}


### Effect of h
h_seq = c((1:10)/10, 1.5, 2, 2.5, 3, 3.5, 5, 10)

x0 = 1
while(x0>0){
  for(h0 in h_seq){
    kernel_reg = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=h0)
    plot(X,Y, pch=20, main=paste("h =",h0), col="gray")
    lines(gr_x,gr_y_true, lwd=3, col="blue")
    lines(kernel_reg, lwd=3, col="red")
    Sys.sleep(1)
  }
}


### Prediction errors and CV
N = 10000
N_mc = 100
h0_seq = (1:20)/20*1

Risk_h = rep(0, length(h0_seq))
for(i_mc in 1:N_mc){
  X = runif(n, min=0, max=2*pi)
  Y = sin(X)+rnorm(n, sd=0.3)
  
  X_new = runif(N, min=0, max=2*pi)
  Y_new = sin(X_new)+rnorm(N, sd=0.3)
  Risk_h_mc = rep(NA, length(h0_seq))
  for(i in 1:length(h0_seq)){
    h0 = h0_seq[i]
    ## True Error
    kernel_reg = ksmooth(x = X,y=Y,kernel = "normal",bandwidth=h0,
                         x.points=X_new)
    Risk_h_mc[i] = mean((kernel_reg$y-Y_new[order(X_new)])^2, na.rm = T)
  }
  Risk_h = Risk_h+Risk_h_mc
  print(i_mc)
}
Risk_h = Risk_h/N_mc
Risk_h

plot(h0_seq,Risk_h, type="b", lwd=4, col="blue", xlab="Smoothing Bandwidth",
     ylab="Prediction Error")


### CV
k = 5
CV_err_h = rep(0,length(h0_seq))
for(i_tmp in 1:N_cv){
  CV_err_h_tmp = rep(0, length(h0_seq))
  cv_lab = sample(n,n,replace=F) %% k
  for(i in 1:length(h0_seq)){
    h0 = h0_seq[i]
    CV_err =0 
    for(i_cv in 1:k){
      w_val = which(cv_lab==(i_cv-1))
      X_tr = X[-w_val]
      Y_tr = Y[-w_val]
      X_val = X[w_val]
      Y_val = Y[w_val]
      kernel_reg = ksmooth(x = X_tr,y=Y_tr,kernel = "normal",bandwidth=h0,
                           x.points=X_val)
      CV_err = CV_err+mean((Y_val[order(X_val)]-kernel_reg$y)^2,na.rm=T)
      }
    CV_err_h_tmp[i] = CV_err/k
  }
  CV_err_h = CV_err_h+CV_err_h_tmp
}
CV_err_h = CV_err_h/N_cv



plot(h0_seq,Risk_h, type="b", lwd=4, col="blue", xlab="Smoothing Bandwidth",
     ylab="Predictive Error", ylim=c(0.075,0.135))
lines(h0_seq, CV_err_h, type="b", lwd=4, col="red")
legend("topright", c("True Predictive Risk","5-fold CV Risk"), 
       col=c("blue","red"), lwd=4)

#### Exercise 3:
#### We use the following model: the covariate X~Beta(2,2) and Y=exp(-2*X)+E,
#### E ~ N(0,0.1^2).
#### Assume the sample size n = 200.
#### (1) Simulate this dataset. Show the scatter plot.

#### (2) Use the kernel regression with smoothing bandwidth h=0.1. 
####     Show the scatter plot, attach the estimated regression curve and
####     the true regression curve. 

#### (3) Use the Monte Carlo Simulations to compute the true prediciton errors
####     for the following smoothing bandwidth
h0_seq = (1:20)/20*0.25
h0_seq
####



###                        ###
### Part 4: kNN Regression ###
###                        ###
library(FNN)
### going back to the abalone dataset
w = which(data0$Sex=="F")
X = data0$Diameter[w]
Y = data0$`Whole weight`[w]
plot(X,Y)

knn_reg = knn.reg(train = X, y=Y, k = 10)
plot(X,Y)
points(x=X, y=knn_reg$pred, col="red")
lines(x=X, y=knn_reg$pred, col="red")
  # this is wrong! need to order points


plot(X,Y)
lines(x=X[order(X)], y=knn_reg$pred[order(X)], col="red", lwd=3)


k_seq = (1:10)*10
x0 = 1
while(x0>0){
  for(k0 in k_seq){
    knn_reg = knn.reg(train = X, y=Y, k = k0)
    plot(X,Y, pch=20, main=paste("k =",k0))
    lines(x=X[order(X)], y=knn_reg$pred[order(X)], col="red", lwd=3)
    Sys.sleep(1)
  }
}


### CV
k_seq = (1:20)*5
k_seq
n = length(X)
k = 5
  # 5-fold CV
N_cv = 100

CV_err_k = rep(0,length(k_seq))
for(i_tmp in 1:N_cv){
  CV_err_k_tmp = rep(0, length(k_seq))
  cv_lab = sample(n,n,replace=F) %% k
  for(i in 1:length(k_seq)){
    k0 = k_seq[i]
    CV_err =0 
    for(i_cv in 1:k){
      w_val = which(cv_lab==(i_cv-1))
      X_tr = X[-w_val]
      Y_tr = Y[-w_val]
      X_val = X[w_val]
      Y_val = Y[w_val]
      knn_reg = knn.reg(train = as.matrix(X_tr), test = as.matrix(X_val),
                        y=Y_tr, k = k0)
        # as.matrix(): when using train + test, we need to transform them into
        #              matrices
        # test: where to evaluate
      CV_err = CV_err+mean((Y_val-knn_reg$pred)^2,na.rm=T)
    }
    CV_err_k_tmp[i] = CV_err/k
  }
  CV_err_k = CV_err_k+CV_err_k_tmp
}
CV_err_k = CV_err_k/N_cv

plot(k_seq,CV_err_k, type="b", lwd=4, col="brown", xlab="# of Nearest Neighbor",
     ylab="CV Error")
  # k~30 gives the best result.

k_opt = k_seq[which(CV_err_k==min(CV_err_k))]
k_opt

knn_reg = knn.reg(train = X, y=Y, k = k_opt)
plot(X,Y)
lines(x=X[order(X)], y=knn_reg$pred[order(X)], col="red", lwd=3)

#### Exercise 4:
#### We will use the dataset 'iris' in this problem. In particular, we choose
#### the covariate X to be 'Petal.Length' and the response Y to be 
#### 'Sepal.Length'.
#### (1) Use the kNN regression with smoothign bandwidth k=10.
####     Show the scatter plot of X and Y. Attach the fitted regression curve.
####     Also attach the regression line from a simple linear regression.

#### (2) Now fit the data with three different smoothing bandwidth 
####     k = 5, 10, 20. Show the scatter plot of the data along with the
####     three regression curves. 

#### (3) Using a 5-fold cross-validation to show the k vs CV error plot.
####     What is the best value of k that minimizes the error?
