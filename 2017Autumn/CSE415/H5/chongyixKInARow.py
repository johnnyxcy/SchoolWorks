'''
Name: Chongyi Xu
Course: CSE 415
Homework: A5
Title: K in a row game implementation
'''

from time import *

side_map = {"O":"X", "X":"O"}
state = []
k_to_win = 0
my_side = ""
opponent = ""
height = 0
width = 0
diags = []

def prepare(intial_state, k, what_side_I_play, opponent_nickname):
    global state, k_to_win, my_side, opponent, height, width, diags
    state = intial_state
    k_to_win = k
    my_side = what_side_I_play
    opponent = opponent_nickname
    height = len(state[0])
    width = len(state[0][0])
    # Find all diagnols
    # Left-top to main-anti-diagnol
    for col in range(width):
        diag = []
        j = col
        i = 0
        while j >= 0 and i < height:
            diag.append([i, j])
            i += 1
            j -= 1
        diags.append(diag)
    # Main-anti-diagnol to right-bottom
    for row in range(1, height):
        diag = []
        i = row
        j = width - 1
        while j >= 0 and i < height:
            diag.append([i, j])
            i += 1
            j -= 1
        diags.append(diag)
    # Right-top to main-diagnol
    for col in range(width - 1, -1, -1):
        diag = []
        i = 0
        j = col
        while j < width:
            diag.append([i, j])
            i += 1
            j += 1
        diags.append(diag)
    # Main-diagnol to bottom-left
    for row in range(1, height):
        diag = []
        i = row
        j = 0
        while i < height:
            diag.append([i, j])
            i += 1
            j += 1
        diags.append(diag)
    return "OK"

def introduce():
    return("""My name is BetaGo, I am really mean 
            I was designed by Chongyi Xu, whose UWNetID is chongyix""")

def nickname():
    return "BetaGo"

def makeMove(currentState, currentRemark, timeLimit = 10000):
    board = currentState[0]
    stop_time = time() + timeLimit
    [best_state, best_score] = minimax(board, my_side, stop_time)
    best_move = findMove(board, best_state)
    return [[best_move, [best_state, side_map[my_side]]], getComment(best_score, my_side)]

def getComment(score, side):
    comment = "Listen to me, " + opponent + ", "
    if side == "O":
        score *= -1
    if score == -10 ** k_to_win:
        comment += "I'm going to lose!!! NO WAY..."
    elif score < 0:
        comment += "That is tough for me. Let'me think..."
    elif score == 0:
        comment += "It is draw right now."
    elif score == 10 ** k_to_win:
        comment += "I am the winner. That is a fact"
    elif score > 0:
        comment += "Can you follow my stratigies?"
    else:
        comment += "No comment"
    return comment

def findMove(curBoard, tarBoard):
    for i in range(len(curBoard)):
        for j in range(len(curBoard[0])):
            if curBoard[i][j] != tarBoard[i][j]:
                return [i, j]

def minimax(board, side, stop_time, plyLeft = 1):
    if side == "X":
        provisional = -float('inf')
    else:
        provisional = float('inf')
    if plyLeft == 0 or stop_time - time() < 0.01:
        return [board, staticValue(board)]
    best_move = board
    for move in successors(board, side):
        [move1, newVal] = minimax(move, side_map[side], stop_time, plyLeft - 1)
        if (side == "X" and newVal > provisional) or (side == "O" and newVal < provisional):
            provisional = newVal
            best_move = move
    return [best_move, provisional]

from copy import *
def successors(board, side):
    result = []
    for i in range(height):
        for j in range(width):
            if board[i][j] == " ":
                suc_board = deepcopy(board)
                suc_board[i][j] = side
                result.append(suc_board)
    return result

# 1
def staticValue(board):
    h = 0
    for row in range(height):
        xCount = checkRow(board, row, "X")
        oCount = checkRow(board, row, "O")
        if xCount[0] + 2 >= k_to_win and xCount[1] >= 2:
            return 10 ** k_to_win
        if oCount[0] + 2 >= k_to_win and oCount[1] >= 2:
            return -10 ** k_to_win
        if xCount[0] + xCount[1] >= k_to_win or oCount[0] + oCount[1] >= k_to_win:
            if xCount[0] + xCount[1] >= k_to_win:
                h += 10 ** (xCount[0] + xCount[1])
            if oCount[0] + oCount[1] >= k_to_win:
                h -= 10 ** (oCount[0] + oCount[1])
        else:
            h += 10 ** xCount[0] + 10 ** xCount[1]
            h -= 10 ** oCount[0] + 10 ** oCount[1]
    for col in range(width):
        xCount = checkCol(board, col, "X")
        oCount = checkCol(board, col, "O")
        if xCount[0] + 2 >= k_to_win and xCount[1] >= 2:
            return 10 ** k_to_win
        if oCount[0] + 2 >= k_to_win and oCount[1] >= 2:
            return -10 ** k_to_win
        if xCount[0] + xCount[1] >= k_to_win or oCount[0] + oCount[1] >= k_to_win:
            if xCount[0] + xCount[1] >= k_to_win:
                h += 10 ** (xCount[0] + xCount[1])
            if oCount[0] + oCount[1] >= k_to_win:
                h -= 10 ** (oCount[0] + oCount[1])
        else:
            h += 10 ** xCount[0] + 10 ** xCount[1]
            h -= 10 ** oCount[0] + 10 ** oCount[1]
    for diag in diags:
        xCount = checkDiag(board, diag, "X")
        oCount = checkDiag(board, diag, "O")
        if xCount[0] + 2 >= k_to_win and xCount[1] >= 2:
            return 10 ** k_to_win
        if oCount[0] + 2 >= k_to_win and oCount[1] >= 2:
            return -10 ** k_to_win
        if xCount[0] + xCount[1] >= k_to_win or oCount[0] + oCount[1] >= k_to_win:
            if xCount[0] + xCount[1] >= k_to_win:
                h += 10 ** (xCount[0] + xCount[1])
            if oCount[0] + oCount[1] >= k_to_win:
                h -= 10 ** (oCount[0] + oCount[1])
        else:
            h += 10 ** xCount[0] + 10 ** xCount[1]
            h -= 10 ** oCount[0] + 10 ** oCount[1]
    return h

def staticEval(state):
    board = state[0]
    return staticValue(board)


def checkRow(board, i, side):
    best = [0, 0]
    cur = 0
    space = 0
    for j in range(width):
        if board[i][j] == side_map[side] or board[i][j] == '-':
            if cur > best[0]:
                best = [cur, space]
            elif cur == best[0] and space > best[1]:
                best = [cur, space]
            cur = 0
            space = 0
        elif board[i][j] == side:
            cur += 1
        else:
            space += 1
    if cur > best[0]:
        best = [cur, space]
    elif cur == best[0] and space > best[1]:
        best = [cur, space]
    return best         


def checkCol(board, j, side):
    best = [0, 0]
    cur = 0
    space = 0
    for i in range(height):
        if board[i][j] == side_map[side] or board[i][j] == '-':
            if cur > best[0]:
                best = [cur, space]
            elif cur == best[0] and space > best[1]:
                best = [cur, space]
            cur = 0
            space = 0
        elif board[i][j] == side:
            cur += 1
        else:
            space += 1
    if cur > best[0]:
        best = [cur, space]
    elif cur == best[0] and space > best[1]:
        best = [cur, space]
    return best

def checkDiag(board, diagnol, side):
    best = [0, 0]
    cur = 0
    space = 0
    for cell in diagnol:
        i = cell[0]
        j = cell[1]
        if board[i][j] == side_map[side] or board[i][j] == '-':
            if cur > best[0]:
                best = [cur, space]
            elif cur == best[0] and space > best[1]:
                best = [cur, space]
            cur = 0
            space = 0
        elif board[i][j] == side:
            cur += 1
        else:
            space += 1
    if cur > best[0]:
        best = [cur, space]
    elif cur == best[0] and space > best[1]:
        best = [cur, space]
    return best