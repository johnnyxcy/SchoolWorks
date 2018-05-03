# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw3 Problem 3

import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0,3,0.01)
# fx= np.zeros([len(x), 1])
# fy= np.zeros([len(x), 1])
# for xx in x:
#     if xx >= 0.75 and xx <= 1.5:
#         fy[x==xx] = 1/(1.5-0.75)
#     if xx >=1 and xx<= 3:
#         fx[x==xx] = 1/(3-1)
# fx = fx[:,0]
# fy = fy[:,0]
# plt.figure()
# plt.plot(x, fx, 'r-', label='f_X')
# plt.plot(x, fy, 'b-', label='f_Y')
# plt.xlabel('x')
# plt.title('Densities of X and Y')
# plt.legend()
# plt.show()

Fx= np.zeros([len(x), 1])
Fy= np.zeros([len(x), 1])
for xx in x:
    if xx >= 0.75 and xx <= 1.5:
        Fy[x==xx] = (4*xx-3)/3
    if xx >=1 and xx<= 3:
        Fx[x==xx] = (xx-1)/2
Fx = Fx[:,0]
Fy = Fy[:,0]
# plt.figure()
# plt.plot(x, Fx, 'r-', label='F_X')
# plt.plot(x, Fy, 'b-', label='F_Y')
# plt.xlabel('x')
# plt.title('CDF of X and Y')
# plt.legend()
# plt.show()

d = 0.5
y = np.arange(0.75,1.5,step=0.01)
pr = np.empty([len(y), 1])
for k in range(len(y)):
    try:
        pr[k] = Fx[x==round(y[k]+0.2-d,2)][0]
    except IndexError:
        i = int(round(round(y[k]+0.2-d, 2) / 0.01))
        pr[k] = Fx[i]
plt.figure()
plt.plot(y, pr)
plt.xlabel('y')
plt.title('The probability that the fox will catch the rabbit')
plt.show()