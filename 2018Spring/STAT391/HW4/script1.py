# STAT 391 HW4
# Chongyi Xu, 1531273
# This file is the Python script for hw4 Problem 1
import statistics as stat
from scipy.stats import norm
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

# xb = [float(xx) for xx in f.readline().split(' ')]

# step = 0.000001
# n = len(xb)
# iterations = 50000
# ll = [0.0]*(iterations-1)
# a = [0.0]*iterations
# b = [0.0]*iterations
# tol = 0.00001
# a[0] = 1

# def ll_logistic(a, b, x, n):
#     return n*np.log(a) - a*sum(x) - n*b - \
#             2*sum(np.log(1 + np.exp([-a*xi-b for xi in x])))
# def grad_a(a, b, x, n):
#     return n/a - sum([xi*(1-np.exp(-a*xi-b))\
#                     /(1+np.exp(-a*xi-b)) for xi in x])
# def grad_b(a, b, x):
#     return -sum((1-np.exp([-a*xi-b for xi in x]))\
#                     /(1+np.exp([-a*xi-b for xi in x])))

# for i in range(iterations-1):
#     ll[i] = ll_logistic(a[i], b[i], xb, n)
#     ga = grad_a(a[i], b[i], xb, n)
#     gb = grad_b(a[i], b[i], xb)
#     if (abs(ga) < tol and abs(gb) < tol):
#         break
#     a[i+1] = a[i] + step*ga
#     b[i+1] = b[i] + step*gb
    
# index,=np.where(np.array(ll)==max(ll))
# ll = ll[0:index[0]+1]
a_ML = 0.142120071559142
b_ML = -1.992443901848966
# print('The index is ', index[0])
# print('The estimated a is ', a_ML)
# print('The estimated b is ', b_ML)

# plt.figure(1)
# plt.plot(np.arange(index[0]+1), ll)
# plt.title('Log-likelihood')
# plt.xlabel('Iteration')
# plt.show()

# plt.figure(2)
# plt.plot(a,b, 'o', Linewidth=0.8)
# plt.title('Parameters a,b')
# plt.xlabel('a')
# plt.ylabel('b')
# plt.show()

# c). hw4-coke.dat
f = open(dir+r'\hw4-coke.dat')
h = 0.5
xc = [float(xx) for xx in f.readline().split(' ')]
n = len(xc)


# d). hw4-unknown.dat
f = open(dir+r'\hw4-unknown.dat')

x_test = [float(xx) for xx in f.readline().split(' ')]

def ll_people(x_test, mu, sigma):
    return np.log(norm.pdf(x_test, mu, sigma))

def ll_fur(x_test, a_ML, b_ML):
    return [np.log(a_ML*np.exp(-a_ML*xi-b_ML)/\
            (1+np.exp(-a_ML*xi-b_ML))) for xi in x_test]

def ll_trash(x_test, x_train, n, h):
    ll = [0.0]*len(x_test)
    k = 0
    for xi in x_test:
        ll[k] = np.log(1/(n*h)*sum(1/math.sqrt(2*math.pi)*\
                    np.exp([-(xi-xci)**2/(2*(h**2)) for xci in x_train])))
        k = k+1
    return ll

classes = ['People', 'Furniture', 'Trash']
score = [0]*len(classes)

score[classes.index('People')] = sum(ll_people(x_test, mu, sigma))
score[classes.index('Furniture')] = sum(ll_fur(x_test, a_ML, b_ML))
score[classes.index('Trash')] = sum(ll_trash(x_test, xc, n, h))

print('The Log-Likelihood Score for People is ', score[classes.index('People')])
print('The Log-Likelihood Score for Furniture is ', score[classes.index('Furniture')])
print('The Log-Likelihood Score for Trash is ', score[classes.index('Trash')])
print('The Best Score is ', classes[score.index(max(score))], ' with ', max(score))


# e
new_x = np.arange(0,20,0.01)
plt.figure(3)
people, = plt.plot(new_x, np.exp(ll_people(new_x, mu, sigma)), label='People')
fur, = plt.plot(new_x, np.exp(ll_fur(new_x, a_ML, b_ML)), label='Furniture')
trash, = plt.plot(new_x, np.exp(ll_trash(new_x, xc, n, h)), label='Trash')
unknown = plt.scatter(x_test, [0]*len(x_test), label='Unknown', marker='*', s=2)
plt.legend(handles=[people,fur,trash])
plt.xlabel('x')
plt.ylabel('density')
plt.title('Plot of densities for 4 data')
plt.show()