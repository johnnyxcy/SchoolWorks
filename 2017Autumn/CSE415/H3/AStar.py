# Astar.py, April 2017 
# Based on ItrDFS.py, Ver 0.4a, October 14, 2017.

# A* Search of a problem space.
# The Problem should be given in a separate Python
# file using the "QUIET" file format.
# See the TowerOfHanoi.py example file for details.
# Examples of Usage:

# A small change was made on Oct. 14, so that backtrace
# uses None as the BACKLINK value for the initial state,
# just as in ItrDFS.py, rather than using -1 as it did
# in an earlier version.

# python3 AStar.py EightPuzzleWithHeuristics h_manhattan

import sys
from priorityq import PriorityQ

# DO NOT CHANGE THIS SECTION 
if sys.argv==[''] or len(sys.argv)<2:
    import EightPuzzleWithHeuristics as Problem
    heuristics = lambda s: Problem.HEURISTICS['h_custom'](s)
    
else:
    import importlib
    Problem = importlib.import_module(sys.argv[1])
    heuristics = lambda s: Problem.HEURISTICS[sys.argv[2]](s)


print("\nWelcome to AStar")
COUNT = None
BACKLINKS = {}

# DO NOT CHANGE THIS SECTION
def runAStar():
    initial_state = Problem.CREATE_INITIAL_STATE()
    print("Initial State:")
    print(initial_state)
    global COUNT, BACKLINKS
    COUNT = 0
    BACKLINKS = {}
    path, name = AStar(initial_state)
    print(str(COUNT)+" states examined.")
    return path, name

# A star search algorithm
def AStar(initial_state):
    '''
    Find the shortest path from start to end f(x) by calculating distance from start to
    midpoint g(x) and from midpoint to the end h(x)

    Parameters
    ----------
    initial_state: the start state
    '''
    global COUNT, BACKLINKS
    OPEN = PriorityQ()
    CLOSED = []
    BACKLINKS[initial_state] = None
    g_dict = {} # Initialize a dictionary to store the value of g(x)
    
    # Start Point of A* Search
    
    # Initialize the priority queue 
    OPEN.insert(initial_state, heuristics(initial_state))
    g_dict[initial_state] = 0

    while OPEN.__len__() != 0:
        S = OPEN.deletemin()
        while S in CLOSED:
            S = OPEN.deletemin()
        CLOSED.append(S)
        g = g_dict[S]

        # DO NOT CHANGE THIS SECTION: begining 
        if Problem.GOAL_TEST(S):
            print(Problem.GOAL_MESSAGE_FUNCTION(S))
            path = backtrace(S)
            return path, Problem.PROBLEM_NAME
        # DO NOT CHANGE THIS SECTION: end
        
        COUNT += 1 # A new state is examined
        for choice in Problem.OPERATORS:
            if choice.is_applicable(S): # able to transform state
                new_state = choice.state_transf(S)
                new_weight = g + 1
                if (new_state not in g_dict) or \
                    (g_dict[new_state] > new_weight):
                    BACKLINKS[new_state] = S
                    g_dict[new_state] = new_weight
                    f = g + heuristics(new_state) # f(x) = g(x) + h(x)
                    OPEN.insert(new_state, f)

# DO NOT CHANGE
def backtrace(S):
    global BACKLINKS
    path = []
    while S:
        path.append(S)
        S = BACKLINKS[S]
    path.reverse()
    print("Solution path: ")
    for s in path:
        print(s)
    print("\nPath length = "+str(len(path)-1))
    return path    

def occurs_in(s1, lst):
  for s2 in lst:
    if s1==s2: return True
  return False

if __name__=='__main__':
    path, name = runAStar()

