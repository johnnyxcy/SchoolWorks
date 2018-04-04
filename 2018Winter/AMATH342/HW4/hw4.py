import numpy as np
import matplotlib.pylab as plt

# 2
t = np.arange(0, 1.005, 0.005)
z = np.exp(np.sin(t))
plt.plot(t, z)

# 3
for n in range(1, 10):
    print(n)

