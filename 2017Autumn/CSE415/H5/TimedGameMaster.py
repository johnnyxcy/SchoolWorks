'''TimedGameMaster.py based on GameMaster.py which in turn is 
 based on code from RunKInARow.py

S. Tanimoto, April 29, 2015.
'''

# Specify details of a match here: 
import wangyicKInARow as player1
import chongyixKInARow as player2
#from FiveInARowGameType import K, NAME, INITIAL_STATE
from AxAGame import K, NAME, INITIAL_STATE
TIME_PER_MOVE = 1

USE_HTML = True
TURN_LIMIT = 196

from winTesterForK import winTesterForK
if USE_HTML: import gameToHTML

CURRENT_PLAYER = 'X'
N = len(INITIAL_STATE[0])    # height of board
M = len(INITIAL_STATE[0][0]) # width of board

FINISHED = False
def runGame():
    currentState = INITIAL_STATE
    print('The Gamemaster says, "Players, introduce yourselves."')
    print('     (Playing X:) '+player1.introduce())
    print('     (Playing O:) '+player2.introduce())

    if USE_HTML:
        gameToHTML.startHTML(player1.nickname(), player2.nickname(), NAME, 1)
    try:
        p1comment = player1.prepare(INITIAL_STATE, K, 'X', player2.nickname())
    except:
        report = 'Player 1 ('+player1.nickname()+') failed to prepare, and loses by default.'
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
        global CURRENT_PLAYER
        CURRENT_PLAYER = who
        if XsTurn:
            playerResult = timeout(player1.makeMove,args=(currentState, currentRemark, TIME_PER_MOVE), kwargs={}, timeout_duration=TIME_PER_MOVE, default=(None,"I give up!"));
            name = player1.nickname()
            XsTurn = False
        else:
            playerResult = timeout(player2.makeMove,args=(currentState, currentRemark, TIME_PER_MOVE), kwargs={}, timeout_duration=TIME_PER_MOVE, default=(None,"I give up!"));
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

import sys
import time
def timeout(func, args=(), kwargs={}, timeout_duration=1, default=None):
    '''This function will spawn a thread and run the given function using the args, kwargs and 
    return the given default value if the timeout_duration is exceeded 
    ''' 
    import threading
    class PlayerThread(threading.Thread):
        def __init__(self):
            threading.Thread.__init__(self)
            self.result = default
        def run(self):
            try:
                self.result = func(*args, **kwargs)
            except:
                print("Seems there was a problem with the time.")
                print(sys.exc_info())
                self.result = default

    pt = PlayerThread()
    print("timeout_duration = "+str(timeout_duration))
    pt.start()
    started_at = time.time()
    #print("makeMove started at: " + str(started_at))
    pt.join(timeout_duration)
    ended_at = time.time()
    #print("makeMove ended at: " + str(ended_at))
    diff = ended_at - started_at
    print("Time used in makeMove: %0.4f seconds" % diff)
    if pt.isAlive():
        print("Took too long.")
        print("We are now terminating the game.")
        print("Player "+CURRENT_PLAYER+" loses.")
        if USE_HTML: gameToHTML.reportResult("Player "+CURRENT_PLAYER+" took too long (%04f seconds) and thus loses." % diff)
        if USE_HTML: gameToHTML.endHTML()
        exit()
    else:
        print("Within the time limit -- nice!")
        return pt.result

    
runGame()
