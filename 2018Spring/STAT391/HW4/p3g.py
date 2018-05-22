# STAT 391 HW4
# Chongyi Xu, 1531273
# This file is the Python script for hw4 Problem 3 f(x)

import numpy as np
import math 
import matplotlib.pyplot as plt

def findLL(train, test, h):
    ll = [0.]*len(test)
    n = len(train)
    for i in range(len(test)):
        ll[i] = np.log(1/(n*h)*sum(1/math.sqrt(2*math.pi)*\
                    np.exp([-(test[i] - xi_train)**2/(2*h**2) \
                        for xi_train in train])))
    return ll


dir = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW4'
f = open(dir+r'\hw4-g-train.dat')
train = [float(xx) for xx in f]

f = open(dir+r'\hw4-g-valid.dat')
valid = [float(xx) for xx in f]

h = [0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5]
Lv = [0.]*len(h)
L = [0.]*len(h)

for k in range(len(h)):
    Lv[k] = sum(findLL(train, valid, h[k]))
    L[k] = sum(findLL(train, train, h[k]))

plt.figure(1)
plt.plot(h, Lv, label='Lv(h)')
plt.plot(h, L, label='L(h)')
plt.title('The likelihood of the data in D_v under g_h')
plt.xlabel('h')
plt.legend()
plt.show()

hmax = h[np.where(Lv==max(Lv))[0][0]]
x = np.arange(-0.5, 1.5, 0.01)
gx = np.array([0.]*len(x))
for i in range(len(x)):
    if x[i]>=0 and x[i]<=0.5:
        gx[i] = 4*x[i]
    elif x[i]>=0.5 and x[i]<= 1:
        gx[i] = 4*(1-x[i])

plt.figure(2)
plt.plot(x, np.exp(findLL(train, x, hmax)), label='g_h(x)')
plt.plot(x, gx, label='g(x)')
plt.xlabel('x')
plt.title('g(x) and g_h(x) at h* = %f'% hmax)
plt.legend()
plt.show()
