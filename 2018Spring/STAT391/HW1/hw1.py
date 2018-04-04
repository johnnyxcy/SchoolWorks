# STAT 391 HW1
# Chongyi Xu, 1531273
# This file is the Python script for hw1

# Problem 1 – Practice with probability (Little Amazon)
# 0 – “War and Peace”, 1 – “Harry Potter & the Deathly Hallows, 2 – “Winnie the Pooh”, 3 – “Get
# rich NOW”, 4 – “Probability”
observations = 0
counter = {0:0, 1:0, 2:0, 3:0, 4:0}
for line in open(r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW1\hw2-little-amazon.dat').readlines():
    line = int(line.rstrip())
    counter[line] = counter[line] + 1
    observations = observations + 1

# a) Estimate θ = (θ0 . . . θ4) from the data. What are the sufficient statistics
theta = [counter[0]/observations, counter[1]/observations, \
            counter[2]/observations, counter[3]/observations, counter[4]/observations]
print(theta)
# And the sufficient statistics are 
print(counter)

# b) A customer buys 3 books. What is the probability that he buys “War and Peace”, “Harry Potter”,
# “Probability” in this order?

