import numpy as np

dict = r'C:\Users\Johnnia\SchoolWorks\2018Spring\GoogleGames\LuckyStair'
f = open(dict+'\input.txt')

x = int(f.readline().split(' ')[1].strip('\n'))
y = int(f.readline().split(' ')[1].strip('\n'))
m = np.zeros([y,x])

count = 0
for lines in f:
    el = lines.strip('\n').split(' ')
    m[count,:] = el
    count += 1


        
