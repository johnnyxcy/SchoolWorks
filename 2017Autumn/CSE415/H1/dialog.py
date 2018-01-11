# dialog.py
# This program runs a dialog between two agents, which must be defined
# elsewhere as separate modules.

import chongyix as agentA
import yangl23 as agentB

N_TURNS = 13

turn = 0
print(str(turn)+"A: "+agentA.agentName() + ': ' + agentA.introduce()+"\n")
print(str(turn)+"B: "+agentB.agentName() + ': ' + agentB.introduce()+"\n")
remark = "How is the day today."
for i in range(N_TURNS):
    turn += 1
    remark = agentA.respond(remark)
    print(str(turn)+"A: "+agentA.agentName() + ': ' + remark+"\n")
    remark = agentB.respond(remark)
    print(str(turn)+"B: "+agentB.agentName() + ': ' + remark+"\n")