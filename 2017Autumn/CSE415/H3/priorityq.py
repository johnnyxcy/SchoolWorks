'''priorityq.py
A module that provides a custom priority queue implementation
for use in A* and similar algorithms.

Version of Oct. 18, 2017, 3:00 PM,  which contains
an adjustment to handle duplicate priority values
together with elements that don't implement
the __lt__ method.

Ties are broken by adding a small random adjustment value
to the new priority value.  These adjustments are less than
0.00001.

The Oct. 18 fixes the double-deletion error found 
in the Oct. 17 version.

 By S. Tanimoto,
'''

import heapq, random
class PriorityQ:
  def __init__(self):
    self.elts = []
    # self.keys = {}
    self.priorities = {}

  def isEmpty(self):
    return len(self.elts)==0
  
  def insert(self, element, priority):
    if priority in self.priorities:
      # resolve priority ties by adding a small random increment to the new one.
      adjustment = random.uniform(0.000001, 0.000009)
      priority += adjustment    
    self.priorities[priority]=True
    heapq.heappush(self.elts, (priority, element))
    # self.keys[element]=True

  def deletemin(self):
    item = self.elts[0]
    (priority, element) = item
    # self.keys.pop(element)
    self.priorities.pop(priority)
   
    try:
      heapq.heappop(self.elts)
    except TypeError as e:
      # A tie should never show up here, having been broken during the insert.
      # but if does, this fix should work.  It did during some testing
      # before the insertion tie-breaking was made.
      # del self.elts[0] # Commented out because heapq.heappop exception occurs after removal.
      print("There was a TypeError in deletemin: "+str(e))

    return element

  def __contains__(self, element):
    return element in self.keys

  def __str__(self):
    return 'PriorityQ'+str(self.elts)

