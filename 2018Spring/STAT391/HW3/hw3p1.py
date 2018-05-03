# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw3 Problem 1

import numpy as np
import matplotlib.pyplot as plt

# 1.
x = np.arange(0,1,step=0.01)
F = [xx**2 for xx in x]
G = np.empty([len(x), 1])
for xx in x:
    if xx <= 0.5:
        G[x==xx] = 2 * xx**2
    elif xx <= 1:
        G[x==xx] = 1 - 2 * (1 - xx)**2
G = G[:,0]
# plt.figure()
# plt.plot(x, F, 'r--', label='F(x)')
# plt.plot(x, G, 'g^', label='G(x)')
# plt.xlabel('x')
# plt.title('F(x) and G(x)')
# plt.legend()
#plt.show()

# 2.
f = [2*xx for xx in x]
g = np.empty([len(x), 1])
for xx in x:
    if xx <= 0.5:
        g[x==xx] = 4 * xx
    elif xx <= 1:
        g[x==xx] = 4 * (1-xx)
g = g[:,0]
# plt.figure()
# plt.plot(x, f, 'r--', label='f(x)')
# plt.plot(x, g, 'g^', label='g(x)')
# plt.xlabel('x')
# plt.title('Density f(x) and g(x)')
# plt.legend()
#plt.show()

#3.
import math

a = math.sqrt(2)/2
aprime = 1/2
# plt.figure()
# plt.plot(x, F, 'r--', label='F(x)')
# plt.plot(x, G, 'g^', label='G(x)')
# plt.axvline(x=a, color='r', linestyle='solid', label='a')
# plt.axvline(x=aprime,  color='g', linestyle='solid', label='a\'')
# plt.xlabel('x')
# plt.title('F(x) and G(x)')
# plt.legend()
# plt.show()


# plt.figure()
# plt.plot(x, f, 'r--', label='f(x)')
# plt.plot(x, g, 'g^', label='g(x)')
# plt.axvline(x=a, color='r', linestyle='solid', label='a')
# plt.fill_between(x, 0, f, where=a<=x, color='red', alpha=0.3)
# plt.fill_between(x, 0, f, where=a>=x, color='red', alpha=0.4)
# plt.axvline(x=aprime,  color='g', linestyle='solid', label='a\'')
# plt.fill_between(x, 0, g, where=aprime<=x, color='green', alpha=0.3)
# plt.fill_between(x, 0, g, where=aprime>=x, color='green', alpha=0.4)
# plt.xlabel('x')
# plt.title('Density f(x) and g(x)')
# plt.legend()
# plt.show()

[af, ag, bf, bg] = [-float('inf'), -float('inf'), float('inf'), float('inf')]
x = np.arange(0,1,step=0.001)
F = np.array([xx**2 for xx in x])
G = np.empty([len(x), 1])
for xx in x:
    if xx <= 0.5:
        G[x==xx] = 2 * xx**2
    elif xx <= 1:
        G[x==xx] = 1 - 2 * (1 - xx)**2
G = G[:,0]
f = np.array([2 * xx for xx in x])
g = np.empty([len(x), 1])
for xx in x:
    if xx <= 0.5:
        g[x==xx] = 4 * xx
    elif xx <= 1:
        g[x==xx] = 4 * (1-xx)
g = g[:,0]

for i in range(len(x)):
    xa = x[i]
    for j in range(i+1, len(x)):
        xb = x[j]
        if (F[x==xb] - F[x==xa] == 0.1) and\
             (xb - xa < bf - af):
            [af, bf] = [xa, xb]
        if (G[x==xb] - G[x==xa] == 0.1) and\
            (xb - xa < bg - ag):
            [ag, bg] = [xa, xb]

# print('[a_f, b_f]='+str([af,bf]))
# print('[a_g, b_g]='+str([ag,bg]))

plt.figure()
plt.plot(x, f, 'r--', label='f(x)')
plt.plot(x, g, 'g^', label='g(x)')
plt.axvline(x=af, color='r', linestyle='solid')
plt.axvline(x=bf, color='r', linestyle='solid')
plt.axvline(x=ag,  color='g', linestyle='solid')
plt.axvline(x=bg,  color='g', linestyle='solid')
plt.fill_between(x, 0, f, where=np.logical_and(x>=af, x<=bf), color='red', alpha=0.3)
plt.fill_between(x, 0, g, where=np.logical_and(x>=ag, x<=bg), color='green', alpha=0.3)
plt.xlabel('x')
plt.title('Density f(x) and g(x)')
plt.legend()
plt.show()

# print('E_f[x]=' + str(np.mean(f)))
# print('E_g[x]=' + str(np.mean(g)))