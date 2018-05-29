# Chongyi Xu
# STAT 391 HW6
# Python script for HW6 Problem 5


import matplotlib.pyplot as plt
from scipy.stats import beta
import numpy as np

x = np.arange(0,1,step=0.01)
n1 = 4
n2 = 1

# CASE 1
a1 = 0.9
a2 = 0.1
prior_1 = beta.pdf(x, a1, a2)
post_1 = beta.pdf(x, a1+n1, a2+n2)
plt.plot(x, prior_1, label='prior')
plt.plot(x, post_1, label='posterior')
plt.axvline(x=n2/(n1+n2), color='g', label='thetaML')
plt.legend()
plt.xlabel('theta')
plt.title('PDF of theta')
plt.show()

# CASE 2
a1 = 2
a2 = 3
prior_2 = beta.pdf(x, a1, a2)
post_2 = beta.pdf(x, a1+n1, a2+n2)
plt.plot(x, prior_2, label='prior')
plt.plot(x, post_2, label='posterior')
plt.axvline(x=n2/(n1+n2), color='g', label='thetaML')
plt.legend()
plt.xlabel('theta')
plt.title('PDF of theta')
plt.show()

# CASE 3
a1 = 20
a2 = 20
prior_3 = beta.pdf(x, a1, a2)
post_3 = beta.pdf(x, a1+n1, a2+n2)
plt.plot(x, prior_3, label='prior')
plt.plot(x, post_3, label='posterior')
plt.axvline(x=n2/(n1+n2), color='g', label='thetaML')
plt.legend()
plt.xlabel('theta')
plt.title('PDF of theta')
plt.show()

# e
a1 = 1
a2 = 1
prior_4 = beta.pdf(x, a1, a2)
post_4 = beta.pdf(x, a1+n1, a2+n2)
plt.plot(x, prior_4, label='prior')
plt.plot(x, post_4, label='posterior')
plt.axvline(x=n2/(n1+n2), color='g', label='thetaML')
plt.legend()
plt.xlabel('theta')
plt.title('PDF of theta')
plt.show()