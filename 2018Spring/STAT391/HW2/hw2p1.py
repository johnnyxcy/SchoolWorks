# STAT 391 HW2
# Chongyi Xu, 1531273
# This file is the Python script for hw2 Problem 1

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

# Read in lincoln_text.txt
txt = ''
for line in open(path + r'\lincoln_text.txt'):
    txt = txt + line
txt = ''.join(e for e in txt if e.isalnum()).lower()
counter = LetterCounter(txt)
length = len(txt)

# Since there might be some missing letters
lincolnEng = {}
for letter in english:
    if letter not in counter:
        counter[letter] = 0
    lincolnEng[letter] = counter[letter] / length
print(lincolnEng)

sample_count = LetterCounter(txt)    
print(sample_count)
sk = {}
for letter in sample_count:
    if sample_count[letter] not in sk:
        sk[sample_count[letter]] = [letter]
    else:
        sk[sample_count[letter]].append(letter)
print(sk)

r = sum(len(sk[k]) for k in sk)
print(r)
n = sum(k*len(sk[k]) for k in sk)
print(n)
print(len(txt))

