# HW Lecture 13_1
# Import data of MoE vs. Strength
MoE <- c(29.8, 33.2, 33.7, 35.3, 35.5, 36.1, 36.2, 36.3, 37.5, 
         37.7, 38.7, 38.8, 39.6, 41.0, 42.8, 42.8, 43.5, 45.6, 46.0,
         46.9, 48.0, 49.3, 51.7, 62.6, 69.8, 79.5, 80.0)
Strength <- c(5.9, 7.2, 7.3, 6.3, 8.1, 6.8, 7.0, 7.6, 6.8, 6.5,
              7.0, 6.3, 7.9, 9.0, 8.2, 8.7, 7.8, 9.7, 7.4, 7.7, 9.7, 7.8,
              7.7, 11.6, 11.3, 11.8, 10.7)
# a) Make the scatterplot
plot(MoE, Strength, cex = 0.5)
# b) boxplot
par(mfrow = c(1, 2))
boxplot(MoE)
boxplot(Strength)

# c) qqplot
qqnorm(MoE, cex = 0.5, main = "MoE QQ Plot")
qqnorm(Strength, cex = 0.5, main = "Strength QQ Plot")

# d) Find correlation
MoE.mean <- mean(MoE)
MoE.sd <- sd(MoE)
Strength.mean <- mean(Strength)
Strength.sd <- sd(Strength)
n <- length(MoE)
r <- sum(((MoE - MoE.mean) / MoE.sd)* 
           ((Strength - Strength.mean) / Strength.sd))
r = r / (n - 1)
r

# e) Compare with cor()
cor(Strength, MoE)

# f) Compute the OLS
xy.mean <- mean(MoE * Strength) # 385.426
xmean.ymean <- MoE.mean * Strength.mean # 367.208
xsquare.mean <- mean(MoE ^ 2) # 2204.178
xmean.square <- MoE.mean ^ 2 # 2034.678
# Slope
Beta = (xy.mean - xmean.ymean) / (xsquare.mean - xmean.square)
Beta



# Intercept
Alpha = Strength.mean - Beta * MoE.mean
Alpha



# g) Interpret the slope
# As MoE increase by 1 GPa, the Strength will increase by about 0.107 MPa

# h) Predit Strength when MoE is 39.0
Strength.predict <- Beta * 39.0 + Alpha
Strength.predict



# i) Compute the sum of squared error(SSE)
error <- 0
for (i in n) {
  error = error + (Strength[i] - (0.1075 * MoE[i] + 3.2925)) ^ 2
}
error 
