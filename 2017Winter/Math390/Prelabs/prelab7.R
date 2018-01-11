# 5.2.1 The t-distribution
pnorm(1.645, 0, 1, lower.tail = T) # Area from left to 1.645 under std normal distribution
pt(1.645, df = 5, lower.tail = F) # Area from right to 1.645 under t with df = 5

# The quantiles of the normal and t distributions are obtained in the following way
qnorm(0.05, 0, 1, lower.tail = T) # 5th percentile from left
qt(0.05, df = 5, lower.tail = T) # 5th percentile from left

# Finally, you can see what the two densities look like
x = seq(-5, 5, .1) # x going from -5 to 5 in 0.1 steps
y_1 = dnorm(x, 0, 1) # std normal density
y_2 = dt(x, 2) # t distribution with df = 2
y_3 = dt(x, 5) # t distribution with df = 5
plot(x, y_1, type = "l", ylab = 'y')
lines(x, y_2, col = 2)
lines(x, y_3, col = 4)
legend('topleft', c('standard normal', 't with df = 2', 't with df = 4'),
                    text.col = c(1, 2, 4), bty = 'n')

# 5.3 Two-sample, two-sided confidence interval
dat <- read.table("http://www.stat.washington.edu/marzban/390/winter17/attend_dat.txt", 
                  header = T)
attendence = dat[, 1]
gender = dat[, 2]
pa.boy = attendence[gender == 0] # percent of time attending class for boys
pa.girl = attendence[gender == 1] # for girls 
n.boys = length(pa.boy) # number of boys
n.grils = length(pa.girl) # number of girls
# The sample mean of these attendence rates is higher for boys than girls
mean(pa.boy)
mean(pa.girl)

t.test(pa.boy)$conf.int[1:2]
t.test(pa.girl)$conf.int[1:2]

t.test(pa.boy, pa.girl, alternative = "two.sided") # Default conf.level = 0.95
# We can be 95% confident that the difference between the true/population means
# between -7.559 and 9.891

# 5.4 Two-Sample, One-Sided Confidence Interval
t.test(pa.boy, pa.girl, alternative = "greater")
# We can be 95% confident that miu1 - miu2 is larger than -6.11

t.test(pa.boy, alternative = "greater")$conf.int[1:2]
t.test(pa.girl, alternative = "greater")$conf.int[1:2]


# 6 Hypothesis Testing, Confidence Intervals and p-values
# 6.2 Confidence Intervals and Hypothesis Tests
# 6.2.1 Example1
H = c(1.2, 0.9, 0.7, 1.0, 1.7, 1.7, 1.1, 0.9, 1.7, 1.9, 1.3, 2.1, 1.6, 1.8, 
      1.4, 1.3, 1.9, 1.6, 0.8, 2.0, 1.7, 1.6, 2.3, 2.0)
P = c(1.6, 1.5, 1.1, 2.1, 1.5, 1.3, 1.0, 2.6)
t.test(H)
t.test(P)
boxplot(H, P, names = c("high", "low"))
t.test(H, P, alternative = "two.sided")
t.test(H, P, alternative = "less")
t.test(H, P, alternative = "greater")
t.test(H, P)$p.value
print(t.test(H, P)$p.value)

# 6.22 Example2: Paired and Unpaired Two-sample t-tests
H = H[1:8]
boxplot(H, P, names = c("high", "low"))
t.test(H, P, alternative = "two.sided")
t.test(H, P, paired = T, alternative = "two.sided")
plot(H, P)

# 6.2.3 Example3
weight = c(14.6, 14.4, 19.5, 24.3, 16.3, 22.1, 23, 18.7, 19, 17, 19.1, 19.6, 
           23.2, 18.5, 15.9)
tread = c(11.3, 5.3, 9.1, 15.2, 10.1, 19.6, 20.8, 10.3, 10.3, 2.6, 16.6, 22.4, 
          23.6, 12.6, 4.4)
# Before testing, let's look at the data first
boxplot(weight, tread, names = c("weight", "treadmill"))
# Note that these data are paired; these boxplots do NOT refelct the fact
# As such, the comparison of these boxplots is very misleading, and conclusions
# can be wrong for paired data. But it is useful to look at for unpaired data.

# The scatterplot of the two variables shows a correlation
plot(weight, tread)
cor(weight, tread)

# Now, the t.test assumes that the population is normal. So let's see if our data 
# are at least consistent with that assumption
qqnorm(weight)
qqnorm(tread)

# These could look better! But with the small sample size we're dealing with, 
# they are normal enough. Also, technically, since we need to do a paired test,
# it is the differences that should have a normal distribution
qqnorm(weight - tread)

t.test(weight, tread, paired = T, alternative = "greater")

# find the CI where the difference exceeds mu
t.test(weight, tread, mu = 5, paired = T, alternative = "greater")
# Computing the last p-value "by hand". First, compute the observed statistic
t_obs = (mean(weight - tread) - 5) / (sd(weight - tread) / sqrt(15))
t_obs # Note that this agrees with t_observaed in t.test()

# According to the formulas for the paired t-test, we should find the area 
# under the t-distribution to the right of this t_observed
pt(t_obs, lower.tail = F, df = 15 - 1) # proportion of t-distribution is upper tail
