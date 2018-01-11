'''GameMaster.py
 based on code from RunKInARow.py
'''

USE_HTML = True

import chongyixKInARow as player2
import wangyicKInARow as player1
from winTesterForK import winTesterForK

if USE_HTML: import gameToHTML

TTT_INITIAL_STATE = \
              [[[' ',' ',' '],
                [' ',' ',' '],
                [' ',' ',' ']], "X"]

K = 3
GAME_TYPE = 'TIC-TAC-TOE'


FIVE_INITIAL_STATE = \
              [[['-',' ',' ',' ',' ',' ','-'],
                [' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' '],
                ['-',' ',' ',' ',' ',' ','-']], "X"]

K = 5
TURN_LIMIT = 45
GAME_TYPE = "Five in a Row on Eight-by-Seven Board with Corners Forbidden"

INITIAL_STATE = FIVE_INITIAL_STATE

TIME_PER_MOVE = 10

N = len(INITIAL_STATE[0])    # height of board
M = len(INITIAL_STATE[0][0]) # width of board

FINISHED = False
def runGame():
    currentState = INITIAL_STATE
    print('The Gamemaster says, "Players, introduce yourselves."')
    print('     (Playing X:) '+ player1.introduce())
    print('     (Playing O:) '+ player2.introduce())

    if USE_HTML:
        gameToHTML.startHTML(player1.nickname(), player2.nickname(), GAME_TYPE, 1)
    try:
        p1comment = player1.prepare(INITIAL_STATE, K, 'X', player2.nickname())
    except:
        report = 'Player 1 ('+player1.nickname()+' failed to prepare, and loses by default.'
        print(report)
        if USE_HTML: gameToHTML.reportResult(report)
        report = 'Congratulations to Player 2 ('+player2.nickname()+')!'
        print(report)
        if USE_HTML: gameToHTML.reportResult(report)
        if USE_HTML: gameToHTML.endHTML()
        return
    try:
        p2comment = player2.prepare(INITIAL_STATE, K, 'O', player1.nickname())
    except:
        report = 'Player 2 ('+player2.nickname()+' failed to prepare, and loses by default.'
        print(report)
        if USE_HTML: gameToHTML.reportResult(report)
        report = 'Congratulations to Player 1 ('+player1.nickname()+')!'
        print(report)
        if USE_HTML: gameToHTML.reportResult(report)
        if USE_HTML: gameToHTML.endHTML()
        return
        return
    
                    
    print('The Gamemaster says, "Let\'s Play!"')
    print('The initial state is...')

    currentRemark = "The game is starting."
    if USE_HTML: gameToHTML.stateToHTML(currentState)

    XsTurn = True
    name = None
    global FINISHED
    FINISHED = False
    turnCount = 0
    printState(currentState)
    while not FINISHED:
        who = currentState[1]
        if XsTurn:
            playerResult = player1.makeMove(currentState, currentRemark, TIME_PER_MOVE)
            name = player1.nickname()
            XsTurn = False
        else:
            playerResult = player2.makeMove(currentState, currentRemark, TIME_PER_MOVE)
            name = player2.nickname()
            XsTurn = True
        moveAndState, currentRemark = playerResult
        if moveAndState==None:
            FINISHED = True; continue
        move, currentState = moveAndState
        moveReport = "Move is by "+who+" to "+str(move)
        print(moveReport)
        utteranceReport = name +' says: '+currentRemark
        print(utteranceReport)
        if USE_HTML: gameToHTML.reportResult(moveReport)
        if USE_HTML: gameToHTML.reportResult(utteranceReport)
        possibleWin = winTesterForK(currentState, move, K)
        if possibleWin != "No win":
            FINISHED = True
            printState(currentState)
            if USE_HTML: gameToHTML.stateToHTML(currentState, finished=True)
            print(possibleWin)
            if USE_HTML: gameToHTML.reportResult(possibleWin)
            if USE_HTML: gameToHTML.endHTML()
            return
        printState(currentState)
        if USE_HTML: gameToHTML.stateToHTML(currentState)
        turnCount += 1
        if turnCount == TURN_LIMIT: FINISHED=True
    printState(currentState)
    if USE_HTML: gameToHTML.stateToHTML(currentState)
    who = currentState[1]
    print("Game over.")
    if USE_HTML: gameToHTML.reportResult("Game Over; it's a draw")
    if USE_HTML: gameToHTML.endHTML()

def printState(s):
    global FINISHED
    board = s[0]
    who = s[1]
    horizontalBorder = "+"+3*N*"-"+"+"
    print(horizontalBorder)
    for row in board:
        print("|",end="")
        for item in row:
            print(" "+item+" ", end="") 
        print("|")
    print(horizontalBorder)
    if not FINISHED:
      print("It is "+who+"'s turn to move.\n")
    
runGame()
