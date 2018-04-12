from __future__ import division
# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw2 Problem 4
import numpy as np
import math
import matplotlib.pyplot as plt

n = 100
p = 0.3141

log_P = [0]*101
for i in range(0, 101): # using ln-gamma to avoid overflow
    log_P[i] = math.log(math.gamma(n+1)) - math.log(math.gamma(i+1)) -\
            math.log(math.gamma(n-i+1)) + i*math.log(p) + (n-i)*math.log(1-p)
theta = [math.exp(log_P[i]) for i in range(len(log_P))]

x = np.arange(0, 1.01, step=0.01)
plt.stem(x, theta)
plt.xlabel('theta_1')
plt.title('Probability of theta_1')
plt.show()

plt.stem(x, theta)
plt.xlabel('theta_1')
plt.title('Probability of theta_1')
plt.xlim([0.195, 0.405])
plt.show()

e = 0.02
print('P{Abosulte Error > 0.02} =',\
    sum(theta[i] for i in np.where(abs(x - p) > e)[0]))
print('P{Related Error > 0.02} =',\
    sum(theta[i] for i in np.where(abs(((x - p) / p)) > e)[0]))

i = 0
epsilons = np.arange(0, 1, step=0.005)
delta = [0]*len(epsilons)
for e in epsilons:
    delta[i] = sum(theta[i] for i in np.where(abs(x - p) > e)[0])
    i = i + 1
plt.plot(epsilons, delta)
plt.xlabel('epsilon')
plt.title('Delta(epsilon) vs. epsilon')
plt.show()

# Simulation
np.random.seed(999)
y = sum(np.random.binomial(1, p, n))
theta_1 = y / n
print('Absolute Error of Simulation = ', abs(theta_1 - p))
print('Relative Error of Simualtion = ', abs((theta_1 - p) / p))

observations = 1000

yy = np.repeat(0, n+1)
for k in range(observations):
    yi = sum(np.random.binomial(1, p, n))
    yy[yi] = yy[yi] + 1

theta = [yy[i] / observations for i in range(0, n+1)]
x = np.arange(0, 1.01, step=0.01)
plt.stem(x, theta)
plt.xlabel('Simulated theta_1')
plt.title('Probability distribution of simulated theta_1')
plt.show()

e = 0.02
print('P{Abosulte Error > 0.02} =',\
        sum(theta[i] for i in np.where(abs(x - p) > e)[0]))
print('P{Related Error > 0.02} =',\
        sum(theta[i] for i in np.where(abs((x - p) / p) > e)[0]))

#==========================================================#
# Use the guess theta
p = theta_1

log_P = [0]*101
for i in range(0, 101): # using ln-gamma to avoid overflow
    log_P[i] = math.log(math.gamma(n+1)) - math.log(math.gamma(i+1)) -\
            math.log(math.gamma(n-i+1)) + i*math.log(p) + (n-i)*math.log(1-p)
y = [math.exp(log_P[i]) for i in range(len(log_P))]
plt.stem(y)
plt.xlabel('k')
plt.title('Probability of observing outcome 1 with k times')
plt.show()

theta = [y[i] / n for i in range(0, n+1)]
x = np.arange(0, 1.01, step=0.01)
plt.stem(x, theta)
plt.xlabel('theta_1')
plt.title('Probability of theta_1')
plt.show()

e = 0.02
print('P{Abosulte Error > 0.02}=',\
        sum(theta[i] for i in np.where(abs(x - p) > e)[0]))
print('P{Related Error > 0.02}=',\
        sum(theta[i] for i in np.where(abs((x - p) / p) > e)[0]))

i = 0
epsilons = np.arange(0, 1, step=0.005)
delta = [0]*len(epsilons)
for e in epsilons:
    delta[i] = sum(theta[i] for i in np.where(abs(x - p) > e)[0])
    i = i + 1
plt.plot(epsilons, delta)
plt.xlabel('epsilon')
plt.title('Delta(epsilon) vs. epsilon')
plt.show()

# Simulation
np.random.seed(999)
y = sum(np.random.binomial(1, p, n))
theta = y / n
print('Absolute Error of Simulation = ', abs(theta - p))
print('Relative Error of Simualtion = ', abs((theta - p) / p))