# STAT 391 HW5
# Chongyi Xu, 1531273
# This file is the Python script for hw5 Problem 3

import statistics as stat
import numpy as np
import math

dir = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW5'
f = open(dir+r'\hw5-data2.dat')
dat = [float(xx) for xx in f]

print('muML = ', stat.mean(dat))

def MOMhelper(dat, K):
    muk = [0.]*K
    m = int(len(dat)/K)
    for k in range(K):
        muk[k] = stat.mean(dat[k*m:(k+1)*m+1])
    return muk

print('muMOM = ', stat.median(MOMhelper(dat, 56)))


# (b)
B=1000
np.random.seed(391)
datB = np.random.choice(dat, size=B, replace=True)
mom = MOMhelper(datB, 56)
print('muMLb = ', stat.mean(datB))
print('muMOMb = ', stat.mean(mom))
print('sigma(muML) = ', stat.variance(datB)/B)
print('sigma(muMOM) = ', stat.variance(mom)/B)

#(c)
print('Considering file hw5-data1.dat')
f = open(dir+r'\hw5-data1.dat')
dat = [float(xx) for xx in f]
print('muML = ', stat.mean(dat))
print('muMOM = ', stat.median(MOMhelper(dat, 20)))

B=1000
datB = np.random.choice(dat, size=B, replace=True)
mom = MOMhelper(datB, 20)
print('muMLb = ', stat.mean(datB))
print('muMOMb = ', stat.mean(mom))
print('var(muML) = ', stat.variance(datB)/B)
print('var(muMOM) = ', stat.variance(mom)/B)