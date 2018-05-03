import math

for n in range(1000000):
    if math.factorial(n) > 10**100:
        print(n)
        break
    