# ItrBreadthFS.py, Mar 2017 
# Based on ItrDFS.py, Ver 0.4, Oct, 2017.

# Iterative Breadth-First Search of a problem space.
# The Problem should be given in a separate Python
# file using the "QUIET" file format.
# See the TowersOfHanoi.py example file for details.
# Examples of Usage:
# python3 ItrBFS.py TowersOfHanoi
# python3 ItrBFS.py EightPuzzle

import sys

if sys.argv==[''] or len(sys.argv)<2:
  import BasicEightPuzzle as Problem
  #import TowerOfHanoi as Problem
else:
  import importlib
  Problem = importlib.import_module(sys.argv[1])


print("\nWelcome to ItrBFS")
COUNT = None
BACKLINKS = {}

#DO NOT CHANGE THIS FUNCTION
def runBFS(): 
  initial_state = Problem.CREATE_INITIAL_STATE()
  print("Initial State:")
  print(initial_state)
  global COUNT, BACKLINKS
  COUNT = 0
  BACKLINKS = {}
  path, name = IterativeBFS(initial_state)
  print(str(COUNT)+" states examined.")
  return path, name

# DO NOT CHANGE THE NAME OR THE RETURN VALUES
# TODO: implement the core BFS algorithm
def IterativeBFS(initial_state):
    global COUNT, BACKLINKS

    OPEN = [initial_state]
    CLOSED = []
    BACKLINKS[initial_state] = None

    while OPEN != []:
        S = OPEN.pop(0)
        CLOSED.append(S)

        # DO NOT CHANGE THIS SECTION
        # the goal test, return path if reached goal
        if Problem.GOAL_TEST(S):
            print("\n"+Problem.GOAL_MESSAGE_FUNCTION(S))
            path = backtrace(S)
            return path, Problem.PROBLEM_NAME

        # DO NOT CHANGE THE CODE ABOVE 
        COUNT += 1
        L = []
        for op in Problem.OPERATORS:
          if op.precond(S):
            new_state = op.state_transf(S)
            if not occurs_in(new_state, CLOSED):
              L.append(new_state)
              if new_state not in OPEN:
                BACKLINKS[new_state] = S

        for s2 in L:
          for i in range(len(OPEN)):
            if (s2 == OPEN[i]):
              del OPEN[i]; break

        OPEN = OPEN + L
        print_state_list("OPEN", OPEN)


# returns a list of states
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

def print_state_list(name, lst):
  print(name+" is now: ",end='')
  for s in lst[:-1]:
    print(str(s),end=', ')
  print(str(lst[-1]))

if __name__=='__main__':
  path, name = runBFS()
