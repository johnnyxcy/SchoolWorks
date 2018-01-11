'''winTesterForK.py
 This function takes a state (of the form [board, whoseMove],
 a move of the form [i, j], and a parameter k.
 The move tells where the last move was made.  Any win is assumed
 to include the position of the last move.
 The parameter k tells how many Xs or Os in a row is required for a win.
 It returns either "No win" or a string describing where a win occurs.
'''

def winTesterForK(s, move, k):
    board, who = s
    moveI, moveJ = move
    whoWent = board[moveI][moveJ]
    H = len(board) # height of board = num. of rows
    W = len(board[0]) # width of board = num. of cols.
    plusDirections  = [(0,1),(1,1),(1,0),(-1,1)] # E, NE, N, NW
    minusDirections = [(0,-1),(-1,-1),(-1,0),(1,-1)] # W, SW, S, SE
    for di in range(4):
        dp = plusDirections[di]
        dm = minusDirections[di]
        # count number of Xs (or Os) in plusDirection:
        count = 1
        i = moveI
        j = moveJ
        for step in range(k-1):
            i += dp[0]
            if i < 0 or i >= H: break # off the board 
            j += dp[1]
            if j < 0 or j >= W: break #   "   "    "
            if board[i][j] != whoWent: break # the run ends.
            count += 1
        # add in the number of Xs (or Os) in minusDirection:
        i = moveI
        j = moveJ
        for step in range(k-1):
            i += dm[0]
            if i < 0 or i >= H: break # off the board 
            j += dm[1]
            if j < 0 or j >= W: break #   "   "    "
            if board[i][j] != whoWent: break # the run ends.
            count += 1
            if count==k: break
        if count==k:
            iWin = i - dm[0]
            jWin = j - dm[1]
            return "Win for "+whoWent+" at ["+str(iWin)+"]["+str(jWin)+"] in direction "+str(dp)
            
    return 'No win'

