# STAT 391 HW4
# Chongyi Xu, 1531273
# This file is the Python script for hw4 Problem 1

dir = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW4'
f = open(dir+r'\hw4-coke.dat')

x = [float(xx) for xx in f.readline().split(' ')]
print(len(x))