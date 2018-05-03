# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw3 Problem 2

import math
import numpy as np
import matplotlib.pyplot as plt

gamma = [math.log(2), math.log(3), math.log(4)]
x = np.arange(0, 10, step=0.01)
fx = np.empty([len(gamma), len(x)])
for k in range(len(gamma)):
    fx[k,] = [gamma[k] * math.exp(-gamma[k] * xx) for xx in x]

plt.figure()
plt.plot(x, fx[0,], 'r--', label='gamma=ln(2)')
plt.plot(x, fx[1,], 'g--', label='gamma=ln(3)')
plt.plot(x, fx[2,], 'b--', label='gamma=ln(4)')
plt.xlabel('x')
plt.title('Density f(x) for different gammas')
plt.legend()
plt.show()