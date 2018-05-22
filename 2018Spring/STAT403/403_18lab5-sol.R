## -------------------------------------------------------------
## Stat/Q Sci 403 Lab 5 | Spring 2018 | University of Washington
## -------------------------------------------------------------
###                                        ###
### Part 1: Linear Regression - Simulation ###
###                                        ###
n = 50
X1 = rnorm(n)

Y = 2+3*X1 +rnorm(n, sd=1)

plot(X1,Y)

fit = lm(Y~X1)
summary(fit)

fit$coefficients

summary(fit)$coefficients[2,]



## check the randomness
n = 2000
N = 100
fit_coeff = matrix(NA, nrow=N, ncol=2)
colnames(fit_coeff) = c("Intercept","Slope")
for(i in 1:N){
  X1 = rnorm(n)
  Y = 2+3*X1 +rnorm(n, sd=2)
  fit = lm(Y~X1)
  
  fit_coeff[i,] = fit$coefficients
}

plot(fit_coeff, xlim=c(1,3),ylim=c(2,4),main=paste("n =",n))
points(x=2,y=3, col="red", pch=3, cex=3, lwd=3)
  # the red cross is the actual value


## make an animation
tmp = 1
N = 100
while(tmp>0){
  for(n in c(25,50,100,200,500,1000, 2000, 5000, 10000)){
    fit_coeff = matrix(NA, nrow=N, ncol=2)
    colnames(fit_coeff) = c("Intercept","Slope")
    for(i in 1:N){
      X1 = rnorm(n)
      Y = 2+3*X1 +rnorm(n, sd=2)
      fit = lm(Y~X1)
      fit_coeff[i,] = fit$coefficients
    }
    plot(fit_coeff, xlim=c(1,3),ylim=c(2,4),main=paste("n =",n))
    points(x=2,y=3, col="red", pch=3, cex=3, lwd=3)
    Sys.sleep(1)
  }
}


### multiple linear regression
n = 50
X = matrix(rnorm(n*5),ncol=5)

beta1 = c(2,1,5,3,4,2)
  # the first element is intercept

Y = beta1[1]+beta1[2]*X[,1]+beta1[3]*X[,2]+beta1[4]*X[,3]+
  +beta1[5]*X[,4]+beta1[6]*X[,5]+rnorm(n, sd=2)

Y = beta1[1] + X %*% beta1[2:6] + rnorm(n,sd=2)

fit = lm(Y~X)
summary(fit)

fit$coefficients


## Monte Carlo simulation
n = 50
N = 100
fit_coeff = matrix(NA, nrow=N, ncol=6)
colnames(fit_coeff) = c("Intercept","X1", "X2","X3","X4","X5")
for(i in 1:N){
  X = matrix(rnorm(n*5),ncol=5)
  Y = beta1[1] + X %*% beta1[2:6] + rnorm(n,sd=2)
  fit = lm(Y~X)
  fit_coeff[i,] = fit$coefficients
}

fit_coeff

boxplot(fit_coeff, col="palegreen")

fit_err = t(t(fit_coeff)-beta1)
  # errors of each coeff

boxplot(fit_err, ylim=c(-1.0,1.0), col="palegreen",
        main=paste("n =",n), ylab="Error of each coefficient")
abline(h=0, lwd=3, col="purple")


## animation
while(tmp>0){
  for(n in c(25,50,100,200,500,1000, 2000)){
    fit_coeff = matrix(NA, nrow=N, ncol=6)
    colnames(fit_coeff) = c("Intercept","X1", "X2","X3","X4","X5")
    for(i in 1:N){
      X = matrix(rnorm(n*5),ncol=5)
      Y = beta1[1] + X %*% beta1[2:6] + rnorm(n,sd=2)
      fit = lm(Y~X)
      fit_coeff[i,] = fit$coefficients
    }
    fit_err = t(t(fit_coeff)-beta1)
    boxplot(fit_err, ylim=c(-1.0,1.0), col="palegreen",
            main=paste("n =",n), ylab="Error of each coefficient")
    abline(h=0, lwd=3, col="purple")
    Sys.sleep(1)
  }
}

#### Exercise 1:
#### We use Monte Carlo simulation to investigate the effect of "design"
#### on the quality of estimation error. 
#### The design is the distribution of covariate.
#### (1) Consider sample size n = 100. First generate X1~N(0,1), X2~N(0,4),
####     and X3~N(0,9). And then generate Y =1+1*X1+1*X2+1*X3+ N(0,1). 
{
  n = 100
  X = cbind(rnorm(n), rnorm(n,sd=2), rnorm(n,sd=3))
  beta1 = c(1,1,1,1)
  Y = beta1[1]+beta1[2]*X[,1]+beta1[3]*X[,2]+beta1[4]*X[,3]+rnorm(n, sd=1)
}

#### (2) Now fit the linear regression. What are the fitted coefficients?
{
  fit = lm(Y~X)
  summary(fit)
}

#### (3) Repeat the entire process N=1000 times, use boxplot to show
####     the distribution of fitted coefficients. Which coefficient has
####     the lowest variance and which has the highest?
{
  N = 1000
  fit_coeff = matrix(NA, nrow=N, ncol=4)
  colnames(fit_coeff) = c("Intercept","X1", "X2","X3")
  for(i in 1:N){
    X = cbind(rnorm(n), rnorm(n,sd=2), rnorm(n,sd=3))
    Y = beta1[1]+beta1[2]*X[,1]+beta1[3]*X[,2]+beta1[4]*X[,3]+rnorm(n, sd=1)
    fit = lm(Y~X)
    fit_coeff[i,] = fit$coefficients
  }
  boxplot(fit_coeff, col="palegreen")
}
#### (4) Now increase the sample size n to 500 and 1000. Does the conclusion
####     change?
{
  for(n in c(25,50,100,200,500,1000)){
    fit_coeff = matrix(NA, nrow=N, ncol=4)
    colnames(fit_coeff) = c("Intercept","X1", "X2","X3")
    for(i in 1:N){
      X = cbind(rnorm(n), rnorm(n,sd=2), rnorm(n,sd=3))
      Y = beta1[1]+beta1[2]*X[,1]+beta1[3]*X[,2]+beta1[4]*X[,3]+
        rnorm(n, sd=1)
      fit = lm(Y~X)
      fit_coeff[i,] = fit$coefficients
    }
    boxplot(fit_coeff, col="orchid", ylim=c(0.5,1.5),
            main=paste("n =",n))
    abline(h=1, lwd=4, col="limegreen")
    Sys.sleep(1)
  }
}


###                                             ###
### Part 2: Linear Regression - Model Selection ###
###                                             ###
### Errors in regression
set.seed(15)
n = 200
d = 20
X = matrix(rnorm(n*d), nrow=n)

Y = 1*X[,1]+2*X[,2]+3*X[,3] + rnorm(n,sd=0.5)
true_coeff = c(0,1,2,3,rep(0,17))

true_coeff

fit = lm(Y~X)
summary(fit)

sum(summary(fit)$residuals^2)
# sum of Sqrt of Residuals--the lack of fitting

err_coeff = sum((summary(fit)$coeff[,1]-true_coeff)^2)
err_coeff



info_fit = matrix(NA, nrow=20, ncol=2)
colnames(info_fit) = c("Sum of Sqrt Res.", "Error in Coeff")
for(i in 1:20){
  fit = lm(Y~X[,1:i])
  info_fit[i,1] = sum(summary(fit)$residuals^2)
  fit_coeff = rep(0, 21)
  fit_coeff[1:(i+1)] = summary(fit)$coeff[,1]
  
  err_coeff = sum((fit_coeff-true_coeff)^2)
  info_fit[i,2] = err_coeff
}

info_fit

plot(x=1:20, y=info_fit[,1], type="l", lwd=2, ylab="Sum of Sqrt Res.",
     xlab="# of covariates")

plot(x=1:20, y=info_fit[,1], type="l", lwd=2, ylab="Sum of Sqrt Res.",
     xlab="# of covariates", ylim=c(50,70))
# more variables: a better fitting


plot(x=1:20, y=info_fit[,2], type="l", lwd=2, 
     ylab="Sum of MSE of all variables",
     xlab="# of covariates")


plot(x=1:20, y=info_fit[,2], type="l", lwd=2, 
     ylab="Sum of MSE of all variables",
     xlab="# of covariates", ylim=c(0,0.03))
# when we include more "useless variables", the errors of coefficients
# go up!


### model selection
dat = data.frame(Y,X)

fit_full = lm(Y~.,data=dat)

fit_null = lm(Y~1,data=dat)

## AIC
F_fit = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
             direction="forward")

B_fit = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
             direction="backward")

T_fit = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
     direction="both")


## BIC
F_fit_bic = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
             direction="forward", k=log(nrow(dat)))

B_fit_bic = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
             direction="backward", k=log(nrow(dat)))

T_fit = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
             direction="both", k=log(nrow(dat)))



### apply to a real data
data0 = read.table("abalone.data", sep=",")
head(data0)

names(data0) = c("Sex","Length","Diameter","Height","Whole weight",
                 "Shucked weight", "Viscera weight","Shell weight","Rings")

head(data0)

fit_full = lm(Rings~., data=data0)

fit_null = lm(Rings~1, data=data0)



## AIC
F_fit = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
     direction="forward")

B_fit = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
             direction="backward")



## BIC
B_fit_bic = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
     direction="backward", k=log(nrow(data0)))
F_fit_bic = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
     direction="forward", k=log(nrow(data0)))


## both
step(fit_full, scope=list(lower=fit_null), 
     direction="both")


step(fit_full, scope=list(lower=fit_null), 
     direction="both", k=log(nrow(data0)))
  # BIC

#### Exercise 2:
#### We will analyze the dataset, 'attitude', using model selection.
#### 'attitude' is a built-in dataset in R.
#### (1) Set 'data1 <- attitude' and then use function head() and summary()
####     to examine the basic properties of this dataset.
{
  data1 = attitude
  head(data1)
  summary(data1)
}
#### (2) Fit a linear regression using Y=rating and the other variables
####     being the covariates. What are the fitted coefficients of each
####     variable? 
{
  fit = lm(rating~., data=data1)
  summary(fit)
}

#### (3) Assume we use AIC as the model selection criterion. What are the
####     variables selected by the forward, backward selection method?
{
  fit_full = lm(rating~.,data=data1)
  fit_null = lm(rating~1,data=data1)
  
  F_fit = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
               direction="forward")
  B_fit = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
               direction="backward")
  # both select 'complaints' and 'learning'
}
  
#### (4) Now change the model selection criterion to BIC. What are the 
####     variables being selected?
{
  F_fit_bic = step(fit_null, scope=list(lower=fit_null,upper=fit_full), 
               direction="forward", k=log(nrow(data1)))
  B_fit_bic = step(fit_full, scope=list(lower=fit_null,upper=fit_full), 
               direction="backward", k=log(nrow(data1)))
  # both select 'complaints' only
}

###                              ###
### Part 3: Logistic Regression  ###
###                              ###
D = read.csv("binary.csv")

head(D)

summary(D)


xtabs(~admit + rank, data = D)
  # 2-way contingency table

D_logistic = glm(admit ~ gre + gpa + rank, 
               data = D, family = "binomial")
D_logistic

summary(D_logistic)

confint(D_logistic, level = 0.9)
  # using the se


## treat each rank as different categories
D$rank = factor(D$rank)
D_logistic_r = glm(admit ~ gre + gpa + rank, 
               data = D, family = "binomial")

summary(D_logistic_r)

confint(D_logistic_r, level = 0.9)


predict(D_logistic_r, type="response")
  # type="response": predicting the probability

## making 90% CI for different values of gre
alpha_CI = 0.95
multiplier = qnorm(alpha_CI)
  
D_gre1 = data.frame(gre=seq(from=200,to=800, by=4),
                   gpa=mean(D$gpa), rank=factor(1))
head(D_gre1)
D_gre_fit = predict(D_logistic_r, type="response", newdata=D_gre1,
                   se=T)

D_gre1$p = D_gre_fit$fit
D_gre1$p_U = D_gre_fit$fit+multiplier*D_gre_fit$se.fit
D_gre1$p_L = D_gre_fit$fit-multiplier*D_gre_fit$se.fit

head(D_gre1)

## plot
plot(x=D_gre1$gre, y=D_gre1$p, ylim=c(0,0.7), type="l", lwd=6, xlim=c(200,800),
     col="blue", xlab="GRE", ylab="Probability of Getting Admission")
lines(x=D_gre1$gre, y=D_gre1$p_U, col="dodgerblue", lwd=3,
      lty=2)
lines(x=D_gre1$gre, y=D_gre1$p_L, col="dodgerblue", lwd=3,
      lty=2)
  # for the rank-1 school student


## CF: rank-2 school
D_gre2 = data.frame(gre=seq(from=200,to=800, by=4),
                    gpa=mean(D$gpa), rank=factor(2))
D_gre_fit = predict(D_logistic_r, type="response", newdata=D_gre2,
                    se=T)
D_gre2$p = D_gre_fit$fit
D_gre2$p_U = D_gre_fit$fit+multiplier*D_gre_fit$se.fit
D_gre2$p_L = D_gre_fit$fit-multiplier*D_gre_fit$se.fit

head(D_gre2)

plot(x=D_gre1$gre, y=D_gre1$p, ylim=c(0,0.7), type="l", lwd=6,
     col="blue", xlab="GRE", ylab="Probability of Getting Admission")
lines(x=D_gre1$gre, y=D_gre1$p_U, col="dodgerblue", lwd=3,lty=2)
lines(x=D_gre1$gre, y=D_gre1$p_L, col="dodgerblue", lwd=3,lty=2)
lines(x=D_gre2$gre, y=D_gre2$p, lwd=6, col="limegreen")
lines(x=D_gre2$gre, y=D_gre2$p_U, col="palegreen", lwd=3,lty=2)
lines(x=D_gre2$gre, y=D_gre2$p_L, col="palegreen", lwd=3,lty=2)


#### Exercise 3:
#### We will use logistic regression to analyze the 'attitude' data again.
#### But now we define a new variable "class" such that those observations
#### (clerks) wit 'rating' > 65 belong to "class 1" and the others are in
#### "class 0". Namely,
Y = attitude$rating>65
#### (1) Fit a logistic regression with the covariate X = complaints. 
{
  X = attitude$complaints
  data1 = data.frame(rating = Y,complaints=attitude$complaints)
  fit_logistic = glm(rating ~ complaints, data=data1, family = "binomial")
  summary(fit_logistic)
}

#### (2) What are a 90% confidence interval of the parameters?
{
  confint(fit_logistic, level = 0.9)
}

#### (3) Plot the fitted P(Y=1|X=x) for x ranging from 0 to 100.
{
  data2 = data.frame(complaints = seq(from=0,to=100,by=1))
  predict_fit = predict(fit_logistic, type="response", newdata=data2,
                        se=T)
  plot(x=data2$complaints, y=predict_fit$fit,
       lwd=3, type="l", ylab="P(Y=1|Complaint)", xlab="Complaint")
  points(x=X,y=Y, pch="|", col="red",cex=2)
  legend("topleft",c("Data","Probability"), col=c("red","black"),
         lwd=3)
}

#### (4) Plot a 90% confidence interval of P(Y=1|X=x) for x ranging 
####     from 0 to 100.
{
  alpha_CI = 0.95
  multiplier = qnorm(alpha_CI)
  plot(x=data2$complaints, y=predict_fit$fit,
       lwd=3, type="l", ylab="P(Y=1|Complaint)", xlab="Complaint")
  lines(x=data2$complaints, y=predict_fit$fit+multiplier*predict_fit$se.fit,
        lty=2,lwd=2)
  lines(x=data2$complaints, y=predict_fit$fit-multiplier*predict_fit$se.fit,
        lty=2,lwd=2)
  
  ## polygon approach
  plot(x=data2$complaints, y=predict_fit$fit,
       lwd=3, type="l", ylab="P(Y=1|Complaint)", xlab="Complaint")
  
  fit_upp = predict_fit$fit+multiplier*predict_fit$se.fit
  fit_low = predict_fit$fit-multiplier*predict_fit$se.fit
  polygon(x=c(data2$complaints,rev(data2$complaints)),
          y=c(fit_upp,rev(fit_low)), col="orange")
  lines(x=data2$complaints, y=predict_fit$fit,lwd=3, col="brown")
  legend("topleft",c("fitted","90% CI"), col=c("brown","orange"),
         lwd=3)

}

#### Alternative answer:
{
  X = attitude$complaints
  fit_logistic = glm(Y ~ X, family = "binomial")
  summary(fit_logistic)

  confint(fit_logistic, level = 0.9)

  fn_logistic = function(x,beta0,beta1){
    tmp = exp(beta0+x*beta1)/(1+exp(beta0+x*beta1))
    return(tmp)
  }
  l_seq = seq(from=0, to=100, by=1)
  plot(x=l_seq, y=fn_logistic(x=l_seq,beta0=fit_logistic$coefficients[1],
                              beta1=fit_logistic$coefficients[2]),
       lwd=3, type="l", ylab="P(Y=1|Complaint)", xlab="Complaint")
  points(x=X,y=Y, pch="|", col="red",cex=2)
}


###                              ###
### Part 4: Rejection Sampling   ###
###                              ###
### We consider sampling points from a distribution f(x)~ sin(x) within
### the interval [0,pi]. In this case, the corresponding density
### f(x) = 0.5*sin(x). 
f_target = function(x){
  return(0.5*sin(x))
}

### We first try p(x)=Unif[0,pi]. We set M = 2.
M = 2
N = 50000
Y = runif(N, min=0,max=pi)
U0 = runif(N)

X = Y[which(U0<f_target(Y)/M/(1/pi))]
  # (1/pi): density of Y


hist(X, breaks=30, col="skyblue", probability = T)
l_seq = seq(from=0,to=pi,length.out=1001)
lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")

length(X)/N
  # acceptance rate


## the effect of the constant M
tmp = 1
while(tmp>0){
  for(M in seq(from=0.2, to=2, by=0.2)){
    Y = runif(N, min=0,max=pi)
    U0 = runif(N)
    X = Y[which(U0<f_target(Y)/M/(1/pi))]
    hist(X, breaks=30, col="skyblue", probability = T,
         ylim=c(0,0.6), 
         main=paste("M =",M,"; Acceptance Rate :", length(X)/N))
    lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")
    Sys.sleep(1)
  }
}
  # Samll M leads to a higher acceptance rate but it cannot be too small!


### Now we switch to p(x) = Beta distribution
M = 1
N = 50000
Y = pi*rbeta(N, shape1=2, shape2=2)
U0 = runif(N)

X = Y[which(U0<f_target(Y)/M/dbeta(Y/pi, shape1=2, shape2=2))]
  # dbeta(Y/pi, shape1=2, shape2=2): density of the transformed beta(2,2)


hist(X, breaks=30, col="skyblue", probability = T)
l_seq = seq(from=0,to=pi,length.out=1001)
lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")

length(X)/N
# acceptance rate

for(M in seq(from=0.05, to=0.5, by=0.05)){
  Y = pi*rbeta(N, shape1=2, shape2=2)
  U0 = runif(N)
  X = Y[which(U0<f_target(Y)/M/dbeta(Y/pi, shape1=2, shape2=2))]
  hist(X, breaks=30, col="skyblue", probability = T,
       ylim=c(0,0.6), 
       main=paste("M =",M,"; Acceptance Rate :", length(X)/N))
  lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")
  Sys.sleep(1)
}
#### Exercise 4:
#### Use rejection sampling to generate points from the density 
#### f(x) = cos(x) for x within [0,pi/2].
#### We will generate proposal Y from uniform distribution over [0,pi/2].
#### Note that in this case, the density of Y is 2/pi.
#### We fix the number of proposal being generated as N=50000.
#### (1) First we pick M=2. Show the points from the rejection sampling
####     using histogram and attach the desired density curve.
####     Do they match? What is the acceptance rate?
{
  f_target = function(x){
    return(cos(x))
  }
  M = 2
  N = 50000
  Y = runif(N, min=0,max=pi/2)
  U0 = runif(N)
  X = Y[which(U0<f_target(Y)/M/(2/pi))]
  
  hist(X, breaks=30, col="tan", probability = T,
       main=paste("Acceptance Rate :", length(X)/N))
  l_seq = seq(from=0,to=pi/2,length.out=1001)
  lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")
}
#### (2) Now change the value of M from 0.5 to 2.5. How does the acceptance
####     rate changes? What is the minimum value of M that leads to a 
####     correct distribution?
while(i>0){
  {
  for(M in seq(from=0.5, to=2.5, by=0.1)){
    Y = runif(N, min=0,max=pi/2)
    U0 = runif(N)
    X = Y[which(U0<f_target(Y)/M/(2/pi))]
    hist(X, breaks=30, col="skyblue", probability = T,
         ylim=c(0,1.2), 
         main=paste("M =",M,"; Acceptance Rate :", length(X)/N))
    lines(x=l_seq, y=f_target(l_seq),lwd=3, col="red")
    Sys.sleep(1)
  }
}
}



### (optional)  best subset approach in model selection
library(leaps)

fit_best = regsubsets(Rings~., data=data0)

plot(fit_best)
# can even distinguish the dummy variable!


# to verify the best model is those without SexM
BIC(lm(Rings~.-Length, data=data0))

BIC(lm(Rings~.-Length-Sex, data=data0))

Gender = rep("A", nrow(data0))
Gender[which(data0[,1]=="I")]="B"
Gender = as.factor(Gender)
data1 = cbind(data0[,-1], Gender)

BIC(lm(Rings~.-Length, data=data0))

BIC(lm(Rings~.-Length, data=data1))
# no SexM -- a lower BIC value compared to the previous one

