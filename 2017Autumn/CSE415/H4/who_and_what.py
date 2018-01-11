#!/usr/bin/python3
'''who_and_what.py
This runnable file will provide a representation of
answers to key questions involved in autograding
parts of the assignment.
'''

# DO NOT EDIT THE BOILERPLATE PART OF THIS FILE HERE:
OPTION_A=1; OPTION_B=2; OPTION_C3=3; OPTION_C2PLUS=4
OPTIONS = ['none', 'A', 'B', 'C.3', 'C.2+']
CATEGORIES=['wicked','uncommon','common']

class Partner():
  def __init__(self, lastname, firstname, uwnetid):
    self.uwnetid=uwnetid
    self.lastname=lastname
    self.firstname=firstname

  def __lt__(self, other):
    return (self.lastname+","+self.firstname).__lt__(other.lastname+","+other.firstname)

  def __str__(self):
    return self.lastname+", "+self.firstname+" ("+self.uwnetid+")"

class Problem():
  def __init__(self, descriptive_name, category, importable_name):
    self.descriptive_name=descriptive_name
    self.category=category
    if not category in CATEGORIES:
      raise Exception("Invalid category "+str(category)+" for problem "+descriptive_name+".")
    self.importable_name=importable_name
    if importable_name[-3:]==".py":
      raise Exception("Leave off the '.py' here because 'import "+importable_name+"' won't work.")

  def __str__(self):
    return self.descriptive_name+" (category: "+self.category+") -- importable_name: "+\
       self.importable_name

class Who_and_what():
  def __init__(self, team, option, problems):
    self.team=team
    self.option=option
    self.problems=problems

  def report(self):
    rpt = 80*"#"+"\n"
    rpt += '''The Who and What for This Submission

Assignment 4 in CSE 415, University of Washington, Autumn 2017

Team: 
'''
    team_sorted = sorted(self.team)
    # Note that the partner whose name comes first alphabetically
    # must do the turn-in.
    # The other partner(s) should NOT turn anything in.
    rpt += "    "+ str(team_sorted[0])+" (the partner who must turn in all files in Catalyst)\n"
    for p in team_sorted[1:]:
      rpt += "    "+str(p) + " (partner who should NOT turn anything in)\n\n"

    rpt += "Option: "+OPTIONS[self.option]+"\n\n"
    rpt += "Problems: \n"
    for pr in self.problems:
      rpt += "    "+str(pr)
    rpt += "\n\nThe information here indicates that the following\n"+\
     "files will need to be submitted:\n"
    rpt += "    "+\
     {OPTION_A:"Our-Wicked-Problem",OPTION_B:"Our-Uncommon-Puzzles",\
      OPTION_C3:"Our-Common-Puzzles", OPTION_C2PLUS:"Our-Common-Puzzles"}\
        [self.option]+".pdf\n"
    for pr in self.problems:
        rpt += "    "+pr.importable_name+".py\n"
    rpt += "\n"+80*"#"+"\n"
    if self.option==1:
      if len(self.problems)!=1:
        rpt += ("Your option requires 1 problem, but given was "+str(len(self.problems))+"\n")
    if self.option==2 or self.option==4:
      if len(self.problems)!=2:
        rpt += ("Your option requires 2 problems, but given was "+str(len(self.problems))+"\n")
    if self.option==3:
      if len(self.problems)!=3:
        rpt += ("Your option requires 3 problems, but given was "+str(len(self.problems))+"\n")
    return rpt
# END OF BOILERPLATE.

# Change the following to represent your own information:

chongyi = Partner("Xu", "Chongyi", "chongyix")
yichao = Partner("Wang", "Yichao", "wangyic")
yang = Partner("Le", "Yang", "yangl23")
team = [chongyi, yichao, yang]

problem1 = Problem("Secure Internet", 'wicked', "SecureInternet")
 # In this case, the Python file for the formulation would be named End_Poverty.py.

problems = [problem1]

our_submission = Who_and_what(team, OPTION_A, problems)
# Legal options are OPTION_A, OPTION_B, OPTION_C3, or OPTION_C2PLUS

# You can run this file from the command line by typing:
# python3 who_and_what.py

# Running this file by itself should produce a report that seems correct to you.
if __name__ == '__main__':
  print(our_submission.report())