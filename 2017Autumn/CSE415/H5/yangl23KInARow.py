# Yang Le yangl23
# CSE 415
# Assignment 5

# This is a game agent for K-in-a-row, which is won by achieving k consecutive
# same elements in a row, a column or a diagonal. 


from copy import deepcopy
from itertools import groupby
import time

height = 0
width = 0
side = ""
win = 0
opponent = ""
state = []

def prepare(initial_state, k, what_side_I_play, opponent_nickname):
	'''Prepare the game by remembering four parameters'''
	global height
	global width
	global side
	global win
	global opponent
	global state 


	state = initial_state
	win = k
	side = what_side_I_play
	opponent = opponent_nickname
	height = len(state[0])
	width = len(state[0][0])
	
	return "OK"

def introduce():
	'''Introduce the player'''
	return '''Hello, this is Mr. Avacado. I am new to this game.
	  Hope we can have a fun game. By the way, I am a machine, 
	  LEARNING. If you have any questions, please refer to my
	  creator, Yang Le. 
		   '''


def nickname():
	'''Show the nickname for the player'''
	return "Mr. Avacado"


def makeMove(currentState, currentRemark, timeLimit=10000):
	'''Make a move based on the current state'''
	startTime = time.time()
	[score, newState] = minimax(currentState, startTime, timeLimit, 1)
	newRemark = respond(score, currentRemark)
	move = moveIt(currentState, newState)
	return [[move, newState], newRemark]

def minimax(state, start, limit, moves):
	'''Run minimax algorithm to find the best move'''
	if limit - (time.time() - start) < 0.1:
		return [staticEval(state), state]
	board = state[0]
	turn = state[1]
	newState = state
	if moves == 0:
		return [staticEval(state), state]
	if turn == 'X':
		provisional = -100000
	else:
		provisional = 100000

	for s in successorFind(state):
		[newVal, newState] = minimax(s, start, limit, moves - 1)
		if (side == 'X' and newVal > provisional) or (side == 'O' and newVal < provisional):
			provisional = newVal

	return [staticEval(newState), newState]

def successorFind(state):
	'''Generate the successors of the state'''
	board = state[0]
	turn = state[1]
	successors = []

	for i in range(height):
		for j in range(width):
			if board[i][j] == ' ':
				newBoard = deepcopy(board)
				newBoard[i][j] = turn
				if turn == 'X':
					next = 'O'
				else:
					next = 'X'
				successors.append([newBoard, next])

	return successors



def respond(score, remark):
	'''Respond the utterance'''
	respond = ""
	if 'I will win' or 'you will lose' in remark:
		respond += "Don't kid yourself. "
	if 'noob' or 'idiot' or 'stupid' in remark:
		respond += "Get ready to be stumped. "
	if score > 400:
		respond += "Remember your loss today."
	elif score > 300:
		respond += "The final push!"
	elif score > 200:
		respond += "Are you ready?"
	elif score > 100:
		respond += "Good for you."
	elif score > 0:
		respond += "Tough game! "
	elif score < -400:
		respond += "Such a bad game! "
	elif score < -300:
		respond += "Watch the miracle."
	elif score < -200:
		respond += "Wow, you are good. "
	elif score < -100:
		respond += "Good lesson for me. "
	elif score <= 0:
		respond += "Such a close game. "

	return respond


def moveIt(currentState, newState):
	'''Make move to the new state'''
	for i in range(len(currentState[0])):
		for j in range(len(newState[0])):
			if currentState[0][i][j] != newState[0][i][j]:
				return (i, j)

def staticEval(state):
	'''Calculate the advantage score of X'''
	line = getLine(state[0])
	Xscore = 0
	Oscore = 0
	Xwin = 0
	Owin = 0

	for s in line:
		Xmax = 0
		Omax = 0
		if 'XX' in s:
			Xmax = max(len(list(y)) for (c,y) in groupby(s) if c=='X')
		if 'OO' in s:
			Omax = max(len(list(y)) for (c,y) in groupby(s) if c=='O')

		Xcount = s.count('X')
		Ocount = s.count('O')

		if Xmax == win - 2 and not ('XO' in s and 'OX' in s):
			Xscore += 100
			Xwin += 1
		elif Omax == win - 2 and not ('XO' in s or 'OX' in s):
			Oscore += 100
			Owin += 1
		elif Xmax == win - 1 and ('XO' in s and 'OX' not in s) and ('XO' not in s and 'OX' in s):
			Xscore += 100
			Xwin += 1
		elif Omax == win - 1 and ('XO' in s and 'OX' not in s) and ('XO' not in s and 'OX' in s):
			Oscore += 100
			Owin += 1

		Xscore += Xmax * 10
		Oscore += Omax * 10
		Xscore += (Xmax - Xcount) * 3
		Oscore += (Omax - Ocount) * 3


	if Xwin >= 2:
		Xscore += 10000
	elif Owin >= 2:
		Oscore += 10000

	return Xscore - Oscore


def getLine(board):
	'''Get all rows, columns and diagonals represented in string'''
	line = []
	for i in range(height):
		ithRow = ""
		for j in range(width):
			ithRow += board[i][j]
		line.append(ithRow)

	for i in range(width):
		ithCol = ""
		for j in range(height):
			ithCol += board[j][i]
		line.append(ithCol)

	for i in range(0, width - win + 1):
		diag1 = ""
		col = i
		row = 0
		while row <= height - 1 and col <= width - 1:
			diag1 += board[row][col]
			row += 1
			col += 1
		line.append(diag1)

		diag2 = ""
		col = i
		row = height - 1
		while col <= width - 1 and row >= 0:
			diag1 += board[row][col]
			row -= 1
			col += 1
		line.append(diag2)

	for i in range(1, height - win + 1):
		diag1 = ""
		col = 0
		row = i
		while row <= height - 1 and col <= width - 1:
			diag1 += board[row][col]
			row += 1
			col += 1
		line.append(diag1)

		diag2 = ""
		col = 0
		row = height - i - 1
		while col <= width - 1 and row >= 0:
			diag1 += board[row][col]
			row -= 1
			col += 1
		line.append(diag2)

	return line













