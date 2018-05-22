# STAT 391 HW4
# Chongyi xbu, 1531273
# This file is the Python script for hw4 Problem 2 

import numpy as np
import matplotlib.pyplot as plt
sample_size = 100
np.random.seed(123)
N = 10000
gammaML = [0.0]*N
gammaC = [0.0]*N

for i in range(N):
    x = np.random.exponential(1, sample_size)
    y = (x>1).astype(int)
    gammaML[i] = sample_size/sum(x)
    gammaC[i] = -np.log(sum(y)/sample_size)

plt.figure(1)
plt.hist(gammaC, bins=30, edgecolor='black')
plt.title('Histogram of gamma^c')
plt.xlabel('gamma^c')
plt.show()

plt.figure(2)
plt.hist(gammaML, bins=30, edgecolor='black')
plt.title('Histogram of gamma^ML')
plt.xlabel('gamma^ML')
plt.show()
