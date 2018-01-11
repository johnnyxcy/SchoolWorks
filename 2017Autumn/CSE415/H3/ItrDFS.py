# ItrDFS.py
# Iterative Depth-First Search of a problem space.
# Ver 0.3, October 11, 2017.
# Usage:
# python3 ItrDFS.py TowerOfHanoi

import sys

if sys.argv==[''] or len(sys.argv)<2:
#  import EightPuzzle as Problem
  import TowerOfHanoi as Problem
else:
  import importlib
  Problem = importlib.import_module(sys.argv[1])


print("\nWelcome to ItrDFS")
COUNT = None
BACKLINKS = {}

def runDFS():
  initial_state = Problem.CREATE_INITIAL_STATE()
  print("Initial State:")
  print(initial_state)
  global COUNT, BACKLINKS
  COUNT = 0
  BACKLINKS = {}
  IterativeDFS(initial_state)
  print(str(COUNT)+" states examined.")

def IterativeDFS(initial_state):
  #print("In RecDFS, with depth_limit="+str(depth_limit)+", current_state is ")
  #print(Problem.DESCRIBE_STATE(current_state))
  global COUNT, BACKLINKS

  OPEN = [initial_state]
  CLOSED = []
  BACKLINKS[initial_state] = None

  while OPEN != []:
    S = OPEN.pop(0)
    CLOSED.append(S)

    if Problem.GOAL_TEST(S):
      print(Problem.GOAL_MESSAGE_FUNCTION(S))
      backtrace(S)
      return

    COUNT += 1
    #if (COUNT % 32)==0:
    if True:
       #print(".",end="")
       #if (COUNT % 128)==0:
       if True:
         print("COUNT = "+str(COUNT))
         print("len(OPEN)="+str(len(OPEN)))
         print("len(CLOSED)="+str(len(CLOSED)))
    L = []
    for op in Problem.OPERATORS:
      if op.precond(S):
        new_state = op.state_transf(S)
        if not occurs_in(new_state, CLOSED):
          L.append(new_state)
          BACKLINKS[new_state] = S
          #print(Problem.DESCRIBE_STATE(new_state))

    for s2 in L:
      for i in range(len(OPEN)):
        if (s2 == OPEN[i]):
          del OPEN[i]; break

    OPEN = L + OPEN
    print_state_list("OPEN", OPEN)

def print_state_list(name, lst):
  print(name+" is now: ",end='')
  for s in lst[:-1]:
    print(str(s),end=', ')
  print(str(lst[-1]))

def backtrace(S):
  global BACKLINKS

  path = []
  while S:
    path.append(S)
    #print("In backtrace, S is now: "+str(S))
    S = BACKLINKS[S]
  path.reverse()
  print("Solution path: ")
  for s in path:
    print(s)
  return path    
  

def occurs_in(s1, lst):
  for s2 in lst:
    if s1==s2: return True
  return False

if __name__=='__main__':
  runDFS()
