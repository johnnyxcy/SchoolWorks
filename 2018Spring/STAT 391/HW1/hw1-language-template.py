#!/usr/bin/env python

import numpy as np


# Read the language statistics

def readLangStats( filename ):
    # first version
    peng = np.zeros( 26, dtype = float )
    i = 0
    for line in open( filename ):
        dum = line.split( ' ' )
        pdum = float( dum[ 2 ] )/1000.
        peng[ i ] = pdum
        i = i+1
    #second and simpler version
    pengi = []

    for line in open( filename ):
        dum = line.split( ' ' )
        pdum = float( dum[ 2 ] )/1000.
        pengi.append( pdum )

    peng = np.array( pengi )
    return peng

def normalize( vec):
    svec = sum( vec )
    vec = vec / svec
    return None  #optional


# main 

peng = readLangStats( 'english.dat' )
pger = readLangStats( 'german.dat' )
pfr = readLangStats( 'french.dat' )
psp = readLangStats( 'spanish.dat' )

alphabet = 'abcdefghijklmnopqrstuvwxyz'
nletters = len(alphabet)
languages = ['English', 'German ', 'Spanish', 'French ' ] #space added to make them all equal length

while True:
    sentence = raw_input('Enter a sentence:' )
    sentence = sentence.lower()

    #
    #  put your code here
    #

    # print results
    print 'Log-likelihoods (in bits)'
    for z in zz:
        print z
    ilang = ll.argmax()
    print 'The most likely language of %s is %s' %(sentence, languages[ ilang ])

    
    




