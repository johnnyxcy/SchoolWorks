'''
Yichao Wang, Chongyi Xu, Yang Le
Option A: Wicked Problems - Secure Internet
All required features are implemented and working:
  - one initial states
  - goal test
  - operators
  - heuristic evaluation function
  - work with ItrDFS, BreadthFS, AStar
  - __str__
'''
#<METADATA>
PROBLEM_NAME = "Create Secure Internet"
PROBLEM_VERSION = "1.0"
PROBLEM_AUTHORS = ['Yichao Wang', 'Chongyi Xu']
PROBLEM_CREATION_DATE = "29-OCT-2017"
PROBLEM_DESC=\
'''This formulation of the secure internet uses generic
Python 3 constructs and has been tested with Python 3.6.
'''
#</METADATA>

#<COMMON_CODE>
class State:
  def __init__(self, l):
    self.l = l

  def __eq__(self,s2):
    return self.l == s2.l

  def __str__(self):
    # Produces a textual description of a state.
    # Might not be needed in normal operation with GUIs.
    txt = "["
    for element in self.l:
      temp = element.split("_")
      txt += str_map[temp[0]] + ": " + str(temp[1]) + " \n"
    return txt[:-2] + "]"

  def __hash__(self):
    return (self.__str__()).__hash__()

  def copy(self):
    # Performs an appropriately deep copy of a state,
    # for use by operators in creating new states.
    news = []
    for element in self.l:
      news.append(element)
    return State(news)

  def can_move(self, To):
    '''Tests whether it's legal to move from one type of method to another.'''
    try:
      news = self.copy()
      if To in news.l:
        return False
      for i in range(len(news.l)):
        if To[:2] == news.l[i][:2]:
          news.l[i] = To
          return compute_secure_ease(news.l)[1] <= MIN_EASE_LEVEL
      return False
    except (Exception) as e:
      print(e)

  def move(self, To):
    '''Assuming it's legal to make the move, this computes
       the new state resulting from one type of method to another.'''
    news = self.copy() # start with a deep copy.
    for i in range(len(news.l)):
      if To[:2] == news.l[i][:2]:
        news.l[i] = To
    return news # return new state

def h1(s):
  '''heuristic function: distance from goal safe level to current safe level'''
  return GOAL_SAFE_LEVEL - compute_secure_ease(s.l)[0]

def compute_secure_ease(li):
  '''compute secure level and ease level based on given list'''
  secure_level = 0
  ease_level = 0
  for element in li:
    temp = cons_map[element.split("_")[0]]
    secure_level += temp[element][0]
    ease_level += temp[element][1]
  return secure_level, ease_level
      
  
def goal_test(s):
  '''If current safe level reaches goal safe level, then s is a goal state.'''
  return compute_secure_ease(s.l)[0] >= GOAL_SAFE_LEVEL

def goal_message(s):
  return "Find a solution to secure internet!"

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
CHANGE_PWD_FREQUENCY = {"cp_never" :(0, 0), "cp_year":(50, 1),"cp_quarter": (80, 2), "cp_month":(200, 3), "cp_week":(300, 5),"cp_day":(350, 7)}
LOG_OUT_FREQUENCY = {"lo_never" :(0, 0), "lo_week":(100, 1),"lo_day":(300, 3)}
BACK_UP_FREQUENCY = {"bu_never" :(0, 0), "bu_year":(100, 2),"bu_quarter": (150, 5), "bu_month":(300, 7), "bu_week":(500, 10)}
STRONG_LEVEL = {"sl_easy":(100, 0), "sl_medium":(200, 1),"sl_hard":(300, 3)}
IF_TWO_FACTOR = {"tf_false":(0, 0), "tf_true":(400, 4)}
GOAL_SAFE_LEVEL = 1000
MIN_EASE_LEVEL = 20

cons_map = {"cp": CHANGE_PWD_FREQUENCY, "lo": LOG_OUT_FREQUENCY, "bu": BACK_UP_FREQUENCY, "sl":STRONG_LEVEL, "tf":IF_TWO_FACTOR}
str_map = {"cp": "CHANGE_PWD_FREQUENCY", "lo": "LOG_OUT_FREQUENCY", "bu": "BACK_UP_FREQUENCY", "sl":"STRONG_LEVEL", "tf":"IF_TWO_FACTOR"}
#</COMMON_DATA>

#<INITIAL_STATE>
CREATE_INITIAL_STATE = lambda: State(["cp_never", "lo_never", "bu_never", "sl_easy", "tf_false"])
#</INITIAL_STATE>

#<OPERATORS>
def get_all_keys():
  return [*IF_TWO_FACTOR] + [*CHANGE_PWD_FREQUENCY] + [*LOG_OUT_FREQUENCY] + [*BACK_UP_FREQUENCY] + [*STRONG_LEVEL] 

safe_combinations = get_all_keys()
OPERATORS = [Operator("Change " + str_map[q.split("_")[0]] + " to " + q.split("_")[1],
                      lambda s, q1=q: s.can_move(q1),
                      lambda s, q1=q: s.move(q1) )
             for q in safe_combinations]
#</OPERATORS>

#<GOAL_TEST> (optional)
GOAL_TEST = lambda s: goal_test(s)
#</GOAL_TEST>

#<GOAL_MESSAGE_FUNCTION> (optional)
GOAL_MESSAGE_FUNCTION = lambda s: goal_message(s)
#</GOAL_MESSAGE_FUNCTION>

#<HEURISTICS>
HEURISTICS = {'h1': h1}
#</HEURISTICS>
