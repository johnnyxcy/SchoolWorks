""" Welcome, contestant, to Hollywood Pentagons! Before we bring out the celebrities, in order to start the game, you must identify today's pentagon and answer a question about it.

Here is your shape to identify:

I am a convex pentagon.
My interior angle measures (in degrees) are all distinct prime numbers.
When all the digits in my interior angle measures (in degrees) are added together, they sum collectively to a perfect cube.
And now, your query: What is the product of my interior angle measures, in degrees?

Answer correctly, and you will be ready to play Hollywood Pentagons!
"""

dict = r'C:\Users\Johnnia\SchoolWorks\2018Spring\GoogleGames\pentagon'
f = open(dict+"\prime.txt")
primes = []

def is_cube(n):
    cube_root = n**(1./3.)
    if round(cube_root) ** 3 == n:
        #print('True')
        return True
    return False
    #print('False')

def findSum(list):
    total = 0
    for num in list:
        s = str(num)
        for i in range(len(s)):
            total += int(s[i])
    return total

for line in f:
    line = line.strip('\n')
    temp = line.split(' ')
    for num in temp:
        if num != '' and int(num) < 180:
            primes.append(int(num))

visit = set()
ans = None
for a in primes:
    for b in primes:
        for c in primes:
            for d in primes:
                for e in primes:
                    cur = str([a,b,c,d,e])
                    if cur not in visit:
                        visit.add(cur)
                        if a != b and b != c and c != d and d != e and\
                            a != c and b != d and c != e and\
                            a != d and b != e and\
                            a != e and (a+b+c+d+e) == 540\
                            and is_cube(findSum([a,b,c,d,e])):
                            print([a,b,c,d,e])
                            ans = a*b*c*d*e
print(ans)



