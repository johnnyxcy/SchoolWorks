'''TowersOfHanoi.py
A QUIET2 Solving Tool problem formulation.
QUIET = Quetzal User Intelligence Enhancing Technology.
The XML-like tags used here serve to identify key sections of this 
problem formulation.  It is important that COMMON_CODE come
before all the other sections (except METADATA), including COMMON_DATA.
CAPITALIZED constructs are generally present in any problem
formulation and therefore need to be spelled exactly the way they are.
Other globals begin with a capital letter but otherwise are lower
case or camel case.
'''
#<METADATA>
QUIET_VERSION = "0.2"
PROBLEM_NAME = "Towers of Hanoi"
PROBLEM_VERSION = "0.2"
PROBLEM_AUTHORS = ['S. Tanimoto']
PROBLEM_CREATION_DATE = "11-OCT-2017"
PROBLEM_DESC=\
'''This formulation of the Towers of Hanoi problem uses generic
Python 3 constructs and has been tested with Python 3.6.
It is designed to work according to the QUIET2 tools interface.
'''
#</METADATA>

#<COMMON_CODE>
class State:
  def __init__(self, d):
    self.d = d

  def __eq__(self,s2):
    for p in ['peg1','peg2','peg3']:
      if self.d[p] != s2.d[p]: return False
    return True

  def __str__(self):
    # Produces a textual description of a state.
    # Might not be needed in normal operation with GUIs.
    txt = "["
    for peg in ['peg1','peg2','peg3']:
      txt += str(self.d[peg]) + " ,"
    return txt[:-2]+"]"

  def __hash__(self):
    return (self.__str__()).__hash__()

  def copy(self):
    # Performs an appropriately deep copy of a state,
    # for use by operators in creating new states.
    news = State({})
    for peg in ['peg1', 'peg2', 'peg3']:
      news.d[peg]=self.d[peg][:]
    return news

  def can_move(self,From,To):
    '''Tests whether it's legal to move a disk in state s
       from the From peg to the To peg.'''
    try:
      pf=self.d[From] # peg disk goes from
      pt=self.d[To]   # peg disk goes to
      if pf==[]: return False  # no disk to move.
      df=pf[-1]  # get topmost disk at From peg..
      if pt==[]: return True # no disk to worry about at To peg.
      dt=pt[-1]  # get topmost disk at To peg.
      if df<dt: return True # Disk is smaller than one it goes on.
      return False # Disk too big for one it goes on.
    except (Exception) as e:
      print(e)

  def move(self,From,To):
    '''Assuming it's legal to make the move, this computes
       the new state resulting from moving the topmost disk
       from the From peg to the To peg.'''
    news = self.copy() # start with a deep copy.
    pf=self.d[From] # peg disk goes from.
    pt=self.d[To]
    df=pf[-1]  # the disk to move.
    news.d[From]=pf[:-1] # remove it from its old peg.
    news.d[To]=pt[:]+[df] # Put disk onto destination peg.
    return news # return new state
  
def goal_test(s):
  '''If the first two pegs are empty, then s is a goal state.'''
  return s.d['peg1']==[] and s.d['peg2']==[]

def goal_message(s):
  return "The Tower Transport is Triumphant!"

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
N_disks = 4
#</COMMON_DATA>

#<INITIAL_STATE>
INITIAL_DICT = {'peg1': list(range(N_disks,0,-1)), 'peg2':[], 'peg3':[] }
CREATE_INITIAL_STATE = lambda: State(INITIAL_DICT)
#DUMMY_STATE =  {'peg1':[], 'peg2':[], 'peg3':[] }
#</INITIAL_STATE>

#<OPERATORS>
peg_combinations = [('peg'+str(a),'peg'+str(b)) for (a,b) in
                    [(1,2),(1,3),(2,1),(2,3),(3,1),(3,2)]]
OPERATORS = [Operator("Move disk from "+p+" to "+q,
                      lambda s,p1=p,q1=q: s.can_move(p1,q1),
                      # The default value construct is needed
                      # here to capture the values of p&q separately
                      # in each iteration of the list comp. iteration.
                      lambda s,p1=p,q1=q: s.move(p1,q1) )
             for (p,q) in peg_combinations]
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