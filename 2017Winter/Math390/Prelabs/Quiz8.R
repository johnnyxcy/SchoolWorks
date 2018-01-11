# Chongyi Xu 1531273, Math 390, Quiz 8
dat = read.table("http://www.stat.washington.edu/marzban/390/winter17/11_36_dat.txt", header = T)
x1 = dat$Plastic
x2 = dat$Paper
x3 = dat$Garbage
x4 = dat$Water
y = dat$Energy
# a)
model = lm(y ~ x1 + x2 + x3 + x4)
summary(model)

# b)
F_obs = (0.9641 / 4) / ((1 - 0.9641) / (30 - 4 - 1))
F_obs
# p_value = prob(F > F_obs) = prob(F > 167.8847)
# use table8, find out p_value < 0.001 < alpha
# We reject the claim that all beta = 0 in favor of the claim that at least one of them is not 0

# c)
# if alpha = 0.01, them from the summary(), we can conclude that plastic(x1), paper(x2) and water(x3) 
# are the predictors that appear to have an effect on Energy, while garbage does not.

# d)
# summary() tells beta_garbage = 4.297, Se_garbage = 1.916
# t test
# H0: beta_garbage = 0
# H1: beta_garbage =/ 0 (beta_garbage > 0 or beta_garbage < 0)
t_obs = (4.297 - 0) / (1.916)
p_value = 2 * (1 - pt(t_obs, 25))
# p_value = 0.0340, consist with summary() output
# e)
model.paper = lm(y ~ x2)
summary(model.paper)
# if alpha = 0.01, p_value = 0.842 > alpha = 0.01
# The data does not support that Paper content alone appear to have an effect on Energy
