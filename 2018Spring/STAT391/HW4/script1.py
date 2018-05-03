# STAT 391 HW4
# Chongyi Xu, 1531273
# This file is the Python script for hw4 Problem 1
import statistics as stat
import numpy as np
import math
import matplotlib.pyplot as plt

# Read in files
# a) hw4-ugrad.dat
dir = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW4'
f = open(dir+r'\hw4-ugrad.dat')

xa = [float(xx) for xx in f.readline().split(' ')]

# ML mu is the mean of data
mu = stat.mean(xa)

# ML sigma is the variance of the data
sigma = stat.stdev(xa)

# print('The estimated mu is ', mu)
# print('And the estimated sigma^2 is ', sigma**2)

# b) hw4-boiler.dat
f = open(dir+r'\hw4-boiler.dat')

xb = [float(xx) for xx in f.readline().split(' ')]

step = 0.00001
n = len(xb)
iterations = 5000
ll = [0.0]*iterations
a = [0.0]*iterations
b = [0.0]*iterations
a[0] = 1

for i in range(iterations):
    ll[i] = n * math.log(a[i]) - n * b[i]
    dlda = n / a[i]
    dldb = 0
    for xi in xb:
        ll[i] += - a[i] * xi - 2 * math.log(1 + \
                    math.exp(-a[i] * xi - b[i]))
        dlda -= xi * (1 - math.exp(-a[i] * xi - b[i]))\
                    /(1 + math.exp(-a[i] * xi - b[i]))
        dldb -= (1 - math.exp(-a[i] * xi - b[i]))\
                    /(1 + math.exp(-a[i] * xi - b[i]))
    if i + 1 < iterations:
        a[i+1] = a[i] + step * dlda
        b[i+1] = b[i] + step * dldb

# plt.figure(1)
# plt.plot(np.arange(iterations), ll)
# plt.title('Log-likelihood')
# plt.xblabel('Iteration')
# plt.show()

# plt.figure(2)
# plt.plot(a,b, 'o', Linewidth=0.8)
# plt.title('Parameters a,b')
# plt.xblabel('a')
# plt.ylabel('b')
# plt.show()

i,=np.where(np.array(ll)==max(ll))
a_ML = a[i[0]]
b_ML = b[i[0]]
# print('The estimated a is ', a_ML)
# print('The estimated b is ', b_ML)

# c). hw4-coke.dat
f = open(dir+r'\hw4-coke.dat')

xc = [float(xx) for xx in f.readline().split(' ')]


# d). hw4-unknown.dat
f = open(dir+r'\hw4-unknown.dat')

x_test = [float(xx) for xx in f.readline().split(' ')]

classes = ['People', 'Furniture', 'Trash']
score = [0, 0, 0]
score[classes.index('People')] = -n/2*math.log(2*math.pi) - n/2*math.log(sigma**2)
score[classes.index('Furniture')] = n * math.log(a_ML) - n * b_ML                           
for i in range(len(x_test)):
    score[classes.index('People')] -= 1/(2*sigma**2) * (x_test[i] - mu)**2
    score[classes.index('Furniture')] += - a_ML * x_test[i] - 2 * \
                    math.log(1 + math.exp(-a_ML * x_test[i] - b_ML))
    score[classes.index('Trash')] += 1/(250*math.sqrt(2*math.pi)) * \
                                math.exp(-2 * (x_test[i]-xc[i])**2)
    
print(math.log(score[classes.index('Trash')]))