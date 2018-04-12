# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw2 Problem 2

import math

# Helper Methods
def langReader(file):
    '''
    langReader is used to read in files and compute for the probability
    for each letter

    Args:
        file: The name of the file containing the letter and probability.
    Returns:
        A dictionary containing letters as keys and probability as values
    '''
    pLang = {}
    for line in open(file):
        el = line.split(' ')
        letter = el[1].lower()
        pLang[letter] = float(el[2])/1000
    return pLang

def LetterCounter(testString):
    '''
    Counts for the number of each letter in the test string (sufficient statistics)

    Args:
        testString: The string to count
    Returns:
        A dictionary containing letters as keys and count number as values
    '''
    counter = {}
    for char in testString:
        try:
            counter[char] = counter[char] + 1
        except KeyError:
            counter[char] = 1
    return counter

# Initialize the probability map
path = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW2'
english = langReader(path + r'\english.dat')

# Read in mlk-letter-estimation.txt
txt = ''
for line in open(path + r'\hw2-mlk-letter-estimation.txt'):
    txt = txt + line
txt = ''.join(e for e in txt if e.isalnum()).lower()
counter = LetterCounter(txt)
for letter in english: # Update missing letters
    if letter not in counter:
        counter[letter] = 0
length = len(txt)

for k in counter:
    if k <= 'j':
        print('n'+k+'='+str(counter[k]))

sk = {}
for letter in counter:
    if counter[letter] not in sk:
        sk[counter[letter]] = [letter]
    else:
        sk[counter[letter]].append(letter)
print('\n')
rk = {}
for k in sk:
    rk[k] = len(sk[k])
    print('r'+str(k)+'='+str(rk[k]))

print('ML Estimation:')
ML = {}
for k in sk:
    letter = sk[k]
    for i in letter:
        ML[i] = k / length
        if letter.index(i) == 0:
            print('theta_'+i+'='+str(ML[i]))
        else:
            print('theta_'+i+'='+'theta_'+letter[0])

print('Laplace Estimation:')
lap = {}
m = 26
for k in sk:
    letter = sk[k]
    for i in letter:
        lap[i] = (k + 1) / (length + m)
        if letter.index(i) == 0:
            print('theta_'+i+'='+str(lap[i]))
        else:
            print('theta_'+i+'='+'theta_'+letter[0])

r = sum(len(sk[k]) for k in sk if k!=0)
print('Witten-Bell Estimation:')
wb = {}
for k in sk:
    letter = sk[k]
    for i in letter:
        if k != 0:
            wb[i] = k / (length + r)
        else:
            wb[i] = 1 / (m - r) * r / (length + r)
        if letter.index(i) == 0:
            print('theta_'+i+'='+str(wb[i]))
        else:
            print('theta_'+i+'='+'theta_'+letter[0])

print('Good-Turing Estimation:')
gt = {}
for k in sk:
    letter = sk[k]
    for i in letter:
        try: 
            gt[i] = ((k + 1) * rk[k+1] / rk[k]) / length
        except KeyError:
            gt[i] = 0
        if letter.index(i) == 0:
            print('theta_'+i+'='+str(gt[i]))
        else:
            print('theta_'+i+'='+'theta_'+letter[0])

print('\nNey-Essen Estimation:')
D = 0
delta = 1
for letter in counter:
    D = D + min(counter[letter], delta)
ne = {}
for k in sk:
    letter = sk[k]
    for i in letter:
        ne[i] = (k - min(k, delta) + D / m) / length
        if letter.index(i) == 0:
            print('theta_'+i+'='+str(ne[i]))
        else:
            print('theta_'+i+'='+'theta_'+letter[0])

# from decimal import Decimal
# # Helper Methods
# def computeP(counter, probMap):
#     '''
#     Compute for the probability of with given letter counter and language probability map

#     Args:
#         counter: The letter counter of the test string.
#         probMap: The probability map of the test language.
#     Returns:
#         A integer telling P(sentence)
#     '''
#     p = 1
#     for letter in counter:
#         try:
#             p = p * Decimal(probMap[letter]**counter[letter])
#         except KeyError:
#             print("The letter ", letter, " is not in this language")
#     return p

# def MaxLogLikelihood(fileName, langDict):
#     '''
#     Find the maximum log-likelihood according to the fileName and output the guess.

#     Args:
#         fileName: The file name with txt to test
#         langDict: The dictionary for all languages.
#     Output:
#         The log-likehood for each language and the best guess.
#     '''
#     print("\nConsidering the file: ", fileName)
#     # Remove spaces and punctuation
#     txt = ''
#     for line in open(path + fileName):
#         txt = txt + line
#     testStr = ''.join(e for e in txt if e.isalnum()).lower()
#     counter = LetterCounter(testStr)
#     best = [-float('inf'), '']
#     for lang in langDict:
#         p = computeP(counter, langDict[lang])
#         ll = p.ln() / Decimal(math.log(2))
#         print("The log-likelihood for ", lang, " is ", ll)
#         if best[0] < ll:
#             best = [ll, lang]
#     print("And as the result, the best guess is ", best[1], " with likelihood ", best[0], "\n")

# langDict = {'ML Estimation':ML,\
#             'Laplace Estimation':lap,\
#             'Witten-Bell Estimation':wb,\
#             'Smoothed Good-Turning Estimation':gt,\
#             'Ney-Essen Estimation':ne}

# MaxLogLikelihood(r'\hw2-mlk-letter-estimation.txt', langDict)
# MaxLogLikelihood(r'\hw2-test-letter-estimation-large.txt', langDict)