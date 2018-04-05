# STAT 391 HW1
# Chongyi Xu, 1531273
# This file is the Python script for hw1 Problem 3

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

def computeP(counter, probMap):
    '''
    Compute for the probability of with given letter counter and language probability map

    Args:
        counter: The letter counter of the test string.
        probMap: The probability map of the test language.
    Returns:
        A integer telling P(sentence)
    '''
    p = 1
    for letter in counter:
        try:
            p = p * probMap[letter]**counter[letter]
        except KeyError:
            print("The letter ", letter, " is not in this language")
    return p

def MaxLogLikelihood(testStr, langDict):
    '''
    Find the maximum log-likelihood according to the testStr and output the guess.

    Args:
        testStr: The string to test
        langDict: The dictionary for all languages.
    Output:
        The log-likehood for each language and the best guess.
    '''
    print("Considering the sentence: ", testStr)
    testStr = ''.join(e for e in testStr if e.isalnum()).lower()
    counter = LetterCounter(testStr)
    best = [-float('inf'), '']
    for lang in langDict:
        ll = math.log(computeP(counter, langDict[lang]), 2)
        print("The log-likelihood for ", lang, " is ", ll)
        if best[0] < ll:
            best = [ll, lang]
    print("And as the result, the best guess is ", best[1], " with likelihood ", best[0], "\n")


# Initialize the probability map
path = r'C:\Users\johnn\Documents\UW\SchoolWorks\2018Spring\STAT391\HW1'

english = langReader(path + r'\english.dat')
french = langReader(path + r'\french.dat')
german = langReader(path + r'\german.dat')
spanish = langReader(path + r'\spanish.dat')

langs = {'English': english, 'French': french, 'German': german, 'Spanish': spanish}

#===========================================================================#
# Case 1
MaxLogLikelihood("La verite vaut bien qu'on passe quelques annees sans la trouver.", langs)

# Case 2
MaxLogLikelihood("Chi po, non vo; chi vo, non po; chi sa, non fa; chi fa, non sa; \
e cosi, male il mondo va.", langs)
# Case 3:
MaxLogLikelihood("As far as the laws of mathematics refer to reality, they are not certain,\
 as far as they are certain, they do not refer to reality.", langs)
 
# Case 4:
MaxLogLikelihood("``Las cuentas, claras, y el chocolate, espeso''", langs)

# Case 5:
MaxLogLikelihood("`` Wir finden in den Buchern immer nur uns selbst. Komisch, \
 dass dann allemal die Freude gross ist und wir den Autor zum Genie erklaren.''", langs)
#===========================================================================#