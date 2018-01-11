'''wangyicKInARow.py
Yichao Wang
CSE 415 Assignment 5
A K-in-a-Row with Forbidden Squares game agent with mean and pride personality.
'''
import time

K = 1
sidePlaying = ""
opponent = ""
row = 0
col = 0


# prepare for the game
def prepare(initial_state, k, what_side_I_play, opponent_nickname):
    global K, sidePlaying, opponent, row, col
    K = k
    sidePlaying = what_side_I_play
    opponent = opponent_nickname
    
    row = len(initial_state[0])
    col = len(initial_state[0][0])

    return "OK"

# game agent's introduction
def introduce():
    return  '''My name is Blank. My creator is wangyic(Yichao Wang). I am mean and pride. I am invincible.'''

# game agent's nickname
def nickname():
    return  'Blank'

# make a possible move with given state. Return move, state, and remark
def makeMove(currentState, currentRemark, timeLimit=10000):
    newVal, newState = minimax(currentState, 1, time.time(), timeLimit)
    return  [[getMove(currentState, newState), newState], utterances(newVal)]

# get different coordinates between two states
def getMove(currentState, newState):
    for i in range(row):
        for j in range(col):
            if currentState[0][i][j] != newState[0][i][j]:
                return [i,j]

# minimax algorithm to find best suitable static evaluation value and state based on side playing
def minimax(state, plyLeft, startTime, timeLimit):
    if plyLeft == 0: return [staticEval(state), state]
    if sidePlaying == "X":
        provisional = -1000000000
    else:
        provisional = 1000000000
    resultState = state
    successorDict = getSuccessor(state)
    for s in successorDict:
        newVal, newState = minimax(s, plyLeft - 1, startTime, timeLimit)
        if (sidePlaying == "X" and newVal >= provisional) or (sidePlaying == "O" and newVal <= provisional):
            provisional = newVal
            resultState = newState
        if time.time() - startTime >= timeLimit * 0.9:
            return [provisional, resultState]
    return [provisional, resultState]

# get successors for the given state
from copy import deepcopy
def getSuccessor(state):
    successorList = []
    for i in range(row):
        for j in range(col):
            if state[0][i][j] == " ":
                successorBoard = deepcopy(state[0])
                successorBoard[i][j] = state[1]
                if state[1] == "X":
                    successorList.append([successorBoard, "O"])
                else:
                    successorList.append([successorBoard, "X"])
    return successorList

# return remark based on given static evaluation value
def utterances(val):
    if sidePlaying == 'O': val = -val
    if val == 0: return opponent + ", you will never win."
    if val > 0 and val < 1000: return opponent + ", you will lose soon."
    if val > 0 and val < 1000000: return opponent + ", you can give up now."
    if val >= 1000000 * K: return "That was easy."
    if val < 0 and val > -1000000: return "This should never happen."
    return "asdcfnlhu2iqn34ilhmxiluasdfhmuil213?????"

# value returned is high if the given state is good for "X";
# low if the given state is good for "O"
def staticEval(state):
    board = state[0]
    val = 0
    # consecutive count of "X" or "O"
    xCount = 0
    oCount = 0
    # occurence of "X" or "O"
    xOccur = 0 
    oOccur = 0
    # potential count of "X" or "O"
    xPotential = 0
    oPotential = 0

    # check status in each row
    if K <= row:
        for m in board:
            hasX = False
            hasO = False
            # check for rows
            for n in m: 
                if n != '-':
                    xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                        evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
                    # decide win or lose
                    if xCount == K:
                        return 1000000 * K
                    if oCount == K:
                        return -1000000 * K
            # calculate val
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6
    # check status in each column
    if K <= row:
        for i in range(col):
            hasX = False
            hasO = False
            for j in range(row):
                n = board[j][i]
                if n != '-':
                    xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                        evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
            # decide win or lose
            if xCount == K:
                return 1000000 * K
            if oCount == K:
                return -1000000 * K
            # calculate val
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6
    #check status for diagonal
    if K <= row and K <= col:
        # check diagonal
        for i in range(col-1,-1,-1):
            hasX = False
            hasO = False
            for j in range(row):
                if i + j < col:
                    n = board[j][i+j]
                    if n != '-':
                        xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                            evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
                        # decide win or lose
                        if xCount == K:
                            return 1000000 * K
                        if oCount == K:
                            return -1000000 * K
            # calculate val
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6
        for i in range(row):
            hasX = False
            hasO = False
            j = i
            for k in range(col):
                if j < row:
                    n = board[j][k]
                    if n != '-':
                        xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                            evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
                        # decide win or lose
                        if xCount == K:
                            return 1000000 * K
                        if oCount == K:
                            return -1000000 * K
                j += 1

            # calculate val
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6
        # check anti diagonal
        for i in range(col):
            hasX = False
            hasO = False
            y = i
            x = 0
            while y >= 0 and x < row:
                n = board[x][y]
                if n != '-':
                    xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                        evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
                    # decide win or lose
                    if xCount == K:
                        return 1000000 * K
                    if oCount == K:
                        return -1000000 * K
                x += 1
                y -= 1
            # calculate val
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6

        for i in range(row):
            x = i
            y = col - 1
            while x < row:
                n = board[x][y]
                if n != '-':
                    xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount = \
                        evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount)
                    # decide win or lose
                    if xCount == K:
                        return 1000000 * K
                    if oCount == K:
                        return -1000000 * K
                x += 1
                y -= 1   
            # calculate val            
            if xOccur >= K - 2 and xPotential >= K:
                val += 500 * xOccur * xPotential
            if oOccur >= K - 2 and oPotential >= K:
                val -= 500 * oOccur * oPotential
            if hasX and xPotential >= K:
                val += 10 * (K) * xOccur
            if hasO and oPotential >= K:
                val -= 10 * (K) * oOccur
            xCount, oCount, xOccur, oOccur, xPotential, oPotential = [0] * 6

    return  val

# staticEval help function
def evaluate(n, xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount):
    # check for blank
    if n == ' ':
        xPotential += 1
        oPotential += 1
    # check for X
    if n == 'X': 
        hasX = True
        xOccur += 1
        xCount += 1
        xPotential += 1
        if oPotential < K:
            oPotential = 0
    else:
        xCount = 0

    # check for O
    if n == 'O':
        hasO = True
        oOccur += 1
        oCount += 1
        oPotential += 1
        if xPotential < K:
            xPotential = 0
    else:
        oCount = 0
    
    return [xPotential, oPotential, hasX, hasO , xOccur, oOccur, xCount, oCount]