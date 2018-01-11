'''Basic8Puzzle.py

'''
#<METADATA>
QUIET_VERSION = "0.1"
PROBLEM_NAME = "BasicEightPuzzle"
PROBLEM_VERSION = "0.1"
PROBLEM_AUTHORS = ['C. Xu']
PROBLEM_CREATION_DATE = "19-OCT-2017"
PROBLEM_DESC=\
'''123
'''
#</METADATA>

#<COMMON_CODE>

SIZE = 3
GOAL = [0, 1, 2, 3, 4, 5, 6, 7, 8]

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
        the new state resulting from moving the topmost disk
        from the From peg to the To peg.'''
        new = self.copy() # start with a deep copy.
        tile = self.list[From]
        new.list[From] = 0 # remove it from its old peg.
        new.list[To] = tile # Put disk onto destination peg.
        return new # return new state

def goal_test(s):
    '''If the first two pegs are empty, then s is a goal state.'''
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
#</COMMON_DATA>

#<INITIAL_STATE>
# puzzle0:
# CREATE_INITIAL_STATE = lambda: State([0, 1, 2, 3, 4, 5, 6, 7, 8])
# # puzzle1a:
# CREATE_INITIAL_STATE = lambda: State([1, 0, 2, 3, 4, 5, 6, 7, 8])
# # puzzle2a:
# CREATE_INITIAL_STATE = lambda: State([3, 1, 2, 4, 0, 5, 6, 7, 8])
# # puzzle4a:
CREATE_INITIAL_STATE = lambda: State([1, 4, 2, 3, 7, 0, 6, 8, 5])
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
#</STATE_VIS>