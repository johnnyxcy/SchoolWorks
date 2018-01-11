'''EightPuzzleWithHeuristics.py

'''
#<METADATA>
QUIET_VERSION = "0.1"
PROBLEM_NAME = "EightPuzzle"
PROBLEM_VERSION = "0.1"
PROBLEM_AUTHORS = ['C. Xu']
PROBLEM_CREATION_DATE = "19-OCT-2017"
PROBLEM_DESC=\
'''
Standard 8 puzzle problem. The goal is to move
the puzzles by swapping tile with the free space (0)
only to reach the goal state.
'''
#</METADATA>

#<COMMON_CODE>
SIZE = 3 # A 3 by 3 puzzle board
GOAL = [0, 1, 2, 3, 4, 5, 6, 7, 8]
'''
Goal State
+--------+
|0  1   2|
|3  4   5|
|7  8   9|
+--------+

'''

class State:
    def __init__(self, list):
        self.list = list

    def __eq__(self,s2):
        for i in range(len(self.list)):
            if self.list[i] != s2.list[i]:
                return False;  
        return True

    def __str__(self):
        # Produces a textual description of a state.
        # Might not be needed in normal operation with GUIs.
        txt = "["
        count = 0
        while count < len(self.list):
            if count % SIZE == 0:
                txt += "["
            if count % SIZE == SIZE - 1:
                txt += str(self.list[count]) + "], "
            else:
                txt += str(self.list[count]) + ", "
            count += 1
        return txt[:-2]+"]"

    def __hash__(self):
        return (self.__str__()).__hash__()

    def copy(self):
        # Performs an appropriately deep copy of a state,
        # for use by operators in creating new states.
        new = State([])
        for i in range(len(self.list)):
            new.list.append(self.list[i])
        return new

    def can_move(self,From,To):
        '''Tests whether it's legal to move a tile from
        current position to desired position.'''
        try:
            From_col = From % SIZE + 1
            From_row = From // SIZE + 1
            To_col = To % SIZE + 1
            To_row = To // SIZE + 1

            if self.list[To] != 0: return False
            if From_col == To_col:
                if (To_row == From_row + 1) or (From_row == To_row + 1):
                    return True
            if From_row == To_row:
                if (To_col == From_col + 1) or (From_col == To_col + 1):
                    return True
            return False
        except (Exception) as e:
            print(e)

    def move(self,From,To):
        '''Assuming it's legal to make the move, this computes
        the new state resulting from moving the tile from given
        position to desired position'''
        new = self.copy() # start with a deep copy.
        tile = self.list[From]
        new.list[From] = 0
        new.list[To] = tile
        return new # return new state

import math
def h_euclidean(mid_state):
    '''
    Compute the euclidean distance for each tile from its 
    location in mid_state to its location in the goal state.
    And add up thos distance

    Parameters
    ----------
    mid_state: current mid point

    Returns
    ---------
    h_e: the sum of euclidean distance
    '''
    h_e = 0
    mid_state = mid_state.list
    for i in range(len(mid_state)):
        goal_row = i // 3 + 1
        goal_col = i % 3 + 1
        row = mid_state[i] // 3 + 1
        col = mid_state[i] % 3 + 1
        h_e += math.sqrt(abs(row - goal_row) ** 2 + abs(col - goal_col) ** 2)
    return h_e
        
def h_hamming(mid_state):
    '''
    determine the number of tiles that, in mid_state, are not 
    where they should end up in the goal state.

    Parameters
    ----------
    mid_state: current mid point

    Returns
    ---------
    h_h: the sum of hamming distance
    '''
    h_h = 0
    mid_state = mid_state.list
    for i in range(len(mid_state)):
        if mid_state[i] != i:
            h_h += 1
    return h_h

def h_manhattan(mid_state):
    '''
    find, for each tile, how many rows it is away from 
    its goal state row plus how many columns it is away 
    from its goal state column

    Parameters
    ----------
    mid_state: current mid point

    Returns
    ---------
    h_h: the sum of manhattan distance
    '''
    h_m = 0
    mid_state = mid_state.list
    for i in range(len(mid_state)):
        goal_row = i // 3 + 1
        goal_col = i % 3 + 1
        row = mid_state[i] // 3 + 1
        col = mid_state[i] % 3 + 1
        h_m += abs(row - goal_row) + abs(col - goal_col)
    return h_m

def h_custom(mid_state):
    '''
    find, for each tile, how many rows it is away from 
    its goal state row and how many columns it is away 
    from its goal state column. Pick the greater value
    and add it to the total distance

    Parameters
    ----------
    mid_state: current mid point

    Returns
    ---------
    h_c: the sum of distance    
    '''
    h_c = 0
    mid_state = mid_state.list
    for i in range(len(mid_state)):
        goal_row = i // 3 + 1
        goal_col = i % 3 + 1
        row = mid_state[i] // 3 + 1
        col = mid_state[i] % 3 + 1
        row_diff = abs(row - goal_row)
        col_diff = abs(col - goal_col)
        h_c += max(row_diff, col_diff)
    return h_c

def goal_test(s):
    return s.list == GOAL

def goal_message(s):
    return "We are DONE!"

class Operator:
    def __init__(self, name, precond, state_transf):
        self.name = name
        self.precond = precond
        self.state_transf = state_transf

    def is_applicable(self, s):
        return self.precond(s)

    def apply(self, s):
        return self.state_transf(s)

#</COMMON_CODE>

#<COMMON_DATA>
HEURISTICS = {'h_euclidean': h_euclidean, 'h_hamming':h_hamming,
    'h_manhattan':h_manhattan, 'h_custom':h_custom}
#</COMMON_DATA>

#<INITIAL_STATE>
# puzzle10a.py:
# CREATE_INITIAL_STATE = lambda: State([4, 5, 0, 1, 2, 3, 6, 7, 8])

# puzzle12a.py:
# CREATE_INITIAL_STATE = lambda: State([3, 1, 2, 6, 8, 7, 5, 4, 0])

# puzzle14a.py:
# CREATE_INITIAL_STATE = lambda: State([4, 5, 0, 1, 2, 8, 3, 7, 6])

# puzzle16a.py:
CREATE_INITIAL_STATE = lambda: State([0, 8, 2, 1, 7, 4, 3, 6, 5])
#</INITIAL_STATE>

def findPossibleMoves(size):
    n_by_n = size * size
    pos = []
    for i in range(n_by_n):
        for j in range(n_by_n):
            if i != j:
                pos.append((i, j))
    return pos

#<OPERATORS>
OPERATORS = [Operator("Move tile from "+str(p)+" to "+str(q),
                    lambda s,p1=p,q1=q: s.can_move(p1,q1),
                    # The default value construct is needed
                    # here to capture the values of p&q separately
                    # in each iteration of the list comp. iteration.
                    lambda s,p1=p,q1=q: s.move(p1,q1))
            for (p,q) in findPossibleMoves(SIZE)]
#</OPERATORS>

#<GOAL_TEST> (optional)
GOAL_TEST = lambda s: goal_test(s)
#</GOAL_TEST>

#<GOAL_MESSAGE_FUNCTION> (optional)
GOAL_MESSAGE_FUNCTION = lambda s: goal_message(s)
#</GOAL_MESSAGE_FUNCTION>

#<STATE_VIS>
if 'BRYTHON' in globals():
    from TowersOfHanoiVisForBrython import set_up_gui as set_up_user_interface
    from TowersOfHanoiVisForBrython import render_state_svg_graphics as render_state
# if 'TKINTER' in globals(): from TicTacToeVisForTKINTER import set_up_gui
#</STATE_VIS>+