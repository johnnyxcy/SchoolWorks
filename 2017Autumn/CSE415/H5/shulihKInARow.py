
import time
import math
INITIAL_STATE = None
SIDE = ""
OPPONENT_NAME = ""
K =0
M = 0    # height of board
N = 0 # width of board

LINES = []
lineForX = {}
lineForY = {}


def prepare(initial_state, k, side_play, opponent_name):
	global INITIAL_STATE, SIDE, OPPONENT_NAME, K, M, N, LINES, lineForX, lineForY

	INITIAL_STATE = initial_state
	
	SIDE = side_play
	
	OPPONENT_NAME = opponent_name

	K = k
	M = len(INITIAL_STATE[0])    # height of board
	N = len(INITIAL_STATE[0][0]) # width of board


	Directions  = [(0,1),(1,1),(1,0),(-1,1)]

	for direction in Directions:
		for m in range(0,M):
			for n in range(0, N):
				startPoint = [m, n]
				line = generateLine(direction, startPoint)
				if checkLine(line):
					LINES.append(line)


	#for eachLine in LINES:
	#	print(eachLine)

	return "OK"




def generateLine(direction, startPoint):
	global K
	#start point (m,n), direction(i,j)

	line = [];
	for num in range(0, K):
		point = [startPoint[0] + num * direction[0], startPoint[1] + num * direction[1]]
		line.append(point)
	return line




def checkLine(line):
	global M,N, INITIAL_STATE
	board = INITIAL_STATE[0]
	for point in line:
		if point[0] < 0 or point[0] >= M:
			return False
		if point[1] < 0 or point[1] >= N:
			return False
		if board[point[0]][point[1]] == "-":
			return False
	return True;






def introduce():
	intro = "Hello! I am a new learner and I was created by Shuling He, whose UW NETID is shulih. I am a new player who just started to learn"\
				+"this game. I hope I can play better and better as I practice more."
	return intro

def nickname():
	return "tinyBear"

def initializeDict():
	global lineForX, lineForY
	lineForX = {}
	lineForY = {}
	for eachNum in range(1, K+1):

		lineForX[eachNum] = 0
		lineForY[eachNum]= 0






def staticEval(state):
	

	global INITIAL_STATE, K, M, N, lineForX, lineForY, LINES
	board = state[0]
	initializeDict()

	for line in LINES:
		line_list = []
		for point in line:
			value = board[point[0]][point[1]]
			line_list.append(value)
		evaluate_line(line_list)


	#static Evaluation Function
	static_func_value = 0;
	for number in range(1, K+1):
		positive = 10**number * lineForX[number]
		negative = - (10**number * lineForY[number])
		static_func_value = static_func_value + positive + negative

	return static_func_value



def evaluate_line(line_list):
	if "O" not in line_list and "X" in line_list:
		occurance = line_list.count("X")
		addLineCount("X", occurance)
	elif "O" in line_list and "X" not in line_list:
		occurance = line_list.count("O")
		addLineCount("O", occurance)


def addLineCount(player, occurance):
	global K, lineForX, lineForY
	if occurance > K:
		name = K
	else: 
		name = occurance
	if player == "X":
		lineForX[name] = lineForX[name] + 1
	else: 
		lineForY[name] = lineForY[name] + 1


def movements(givenState):
	global M, N
	movelist = []
	givenBoard = givenState[0]
	for i in range(0, M):
		for j in range(0, N):
			if givenBoard[i][j] == " ":
				movelist.append([i,j])
	return movelist


DEPTHLIMIT = 2
BESTMOVE = []


def makeMove(currState, currRemark, timeLimit = 10000):
	global BESTMOVE
	couldMove = movements(currState)
	abp(currState, 0, -math.inf, math.inf)

	nextMove = BESTMOVE;
	newState = getNewState(currState, BESTMOVE)

	newRemark = comment(newState)
	return [[BESTMOVE, newState], newRemark]



def comment(state):
	if SIDE == "O":
		sign = -1;
	else :
		sign = 1;
	value = sign * staticEval(state)
	if value > 2*10 ** (K/2):
		remark = "wow So close to win! I'm so excited!"
	elif value < - (2*10 ** (K/2)):
		remark = "You seem so good at this! can you teach me later, please?"
	elif value < 0:
		remark = "I guess as a new learner I need more practice"
	else:
		remark = "That's better. Your turn."
	return remark




def abp(state, depth, alpha, beta):
	#check if it is at lowest level
	global K, M, N, lineForX, lineForY, BESTMOVE, DEPTHLIMIT
	
	if depth == DEPTHLIMIT:

		return staticEval(state)


	moveList = movements(state)

	if len(moveList) == 0:
		return staticEval(state)

	if state[1] == "X":   #maximizer

		for singleMove in moveList:
			result =  abp(getNewState(state, singleMove), depth+1, alpha, beta)
			if result > alpha:
				alpha = result
				if depth == 0: 
					BESTMOVE = singleMove

			if beta <= alpha :

				return alpha 
		return alpha
	elif state[1] == "O":

		for singleMove in moveList:
			
			result = abp(getNewState(state, singleMove), depth+1, alpha, beta)


			if result < beta:
				beta = result
				if depth == 0:
					BESTMOVE = singleMove

			if beta <= alpha:
				
				return beta
		return beta




def getNewState(currState, move):
	oldBoard = currState[0]
	board = [];
	for line in oldBoard:
		board.append(line[:])
	if board[move[0]][move[1]] != " ":
		print("already exist! Break!")
	board[move[0]][move[1]] = currState[1]
	if currState[1] == "X":
		newPlayer = "O"
	elif currState[1] == "O":
		newPlayer = "X"
	newState = [board, newPlayer]
	return newState























	