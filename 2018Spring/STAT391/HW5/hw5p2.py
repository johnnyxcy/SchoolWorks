# STAT 391 HW5
# Chongyi Xu, 1531273
# This file is the Python script for hw5 Problem 2
import statistics as stat
import numpy as np
import math

dir = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW5'
f = open(dir+r'\hw5-data1.dat')
dat = [float(xx) for xx in f]

# (a)
mu = stat.mean(dat)
print('mu = ', mu)
#(b)
n = len(dat)
sigmaML = stat.variance(dat)
stdML = stat.stdev(dat)
sigmaC = n*sigmaML/(n-1)
print('s^2ML = ', sigmaML)
print('stdML = ', stdML)
print('s^2C = ', sigmaC)
ciC = (mu-2.576*math.sqrt(sigmaC/n), mu+2.576*math.sqrt(sigmaC/n))
print('99 confidence interval ', ciC)

#(e)
B=1000
np.random.seed(391)
xB = np.random.choice(dat, size=B, replace=True)
sigmaB = stat.variance(xB)
stdB = stat.stdev(xB)
print('s^2B = ', sigmaB/n)
ciB = (mu-2.576*math.sqrt(sigmaB/n), mu+2.576*math.sqrt(sigmaB/n))
print('99 confidence interval ', ciB)

#(f)
print('The difference is ', tuple(np.subtract(ciB, ciC)))
er = abs(stdML-stdB)/stdML
print('e_r = ', er)