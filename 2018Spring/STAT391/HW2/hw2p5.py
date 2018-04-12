from sympy import Symbol, solve, Eq
n = Symbol('n')
theta = 10**(-3)
e = 10**(-8)
f = Eq(n * math.log(1-theta), 1 * math.log(theta) - (1-theta)**(n-1) + e)
sol = solve(f, n)
print(sol)