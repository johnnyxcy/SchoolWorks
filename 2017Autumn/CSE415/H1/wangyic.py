# CSE 415
# Yichao Wang
# Conversational Agents 

from re import *
from random import choice

# introduction of the agent
def introduce():
    return """"My name is AI Unkown, and I a mean and indifference robot. 
I was programmed by Yichao Wang. If you don't like 
the way I deal, contact him at wangyic@uw.edu. """

# agent's responds based on different rule
def respond(the_input):
    if match('bye',the_input):
        # rule: respond when contain bye in input
        return 'Goodbye!'
    wordlist = split(' ',remove_punctuation(the_input))
    wordlist[0]=wordlist[0].lower()
    mapped_wordlist = you_me_map(wordlist)
    mapped_wordlist[0]=mapped_wordlist[0].capitalize()
    
    sent = "Did you say '" + stringify(wordlist) + "' ? Explain."
    if wordlist[0]=='':
        # rule : respond when other speak nothing
        return "Can you speak?"
    if 'repeat' in wordlist:
        # rule : respond when contain repeat
        return "Repeat: do (something) again, either once or a number of times."
    if sent in PUNTS:
        # rule 1: respond when other repeat
        return "Are you stupid? Please don't repeat saying '" + stringify(wordlist) + "' ."
    else:
        PUNTS.append(sent)
    if wordlist[0:2] == ['i','am']:
        # rule 2: respond when start with "i am"
        return cycle1() +\
              stringify(mapped_wordlist[2:]) + '.'
    if 'why' in wordlist:
        # rule: respond when contain why
        return cycle5()
    if wpred(wordlist[0]):
        # rule 3: respond when first word is a question word
        return "I don't care " + wordlist[0] + '.'
    if wordlist[0:2] == ['i','have']:
        # rule 4: respond when start with "i have"
        return "I don't care if you had " +\
              stringify(mapped_wordlist[2:]) + '.'
    if wordlist[0:2] == ['i','feel']:
        # rule 5: respond when start with "i feel"
        return "I don't care if you feel " +\
              stringify(mapped_wordlist[2:]) + '.'
    if 'because' in wordlist:
        # rule 6: respond when contain "because"
        return "Are you sure? I don't think so."
    if 'yes' in wordlist:
        # rule 7: respond when contain "yes"
        return "I think you are wrong."
    if wordlist[0:2] == ['you','are']:
        # rule 8: respond when start with "you are"
        return "Thank you."
    if verbp(wordlist[0]):
        # rule 9: respond when first word is a known verb
        return "I don't want to " +\
              stringify(mapped_wordlist) + '.'
    if wordlist[0:3] == ['do','you','think']:
        # rule 10: respond when start with "do you think"
        return "No, I don't."
    if wordlist[0:2]==['can','you'] or wordlist[0:2]==['could','you']:
        # rule 11: respond when start with "can you" and "could you"
        return "No."
    if wordlist[0] == 'is':
        # rule: respond when start with is:
        return "What about find the answer yourself?"
    for i in range(len(attitude)):
        if attitude[i] in wordlist:
        # rule 12: respond when contain attitude words
            PUNTS.append("Tell me more about " + stringify(wordlist[wordlist.index(attitude[i]) + 1:]))
            PUNTS.append("Why " + stringify(wordlist[wordlist.index(attitude[i]):]) + " ?")
            return cycle2() + stringify(wordlist[wordlist.index(attitude[i]):]) + '.'
    if 'favorite' in wordlist:
        # rule 13: respond when contain favorite
        return "Haha."
    if 'no' in wordlist:
        # rule 14: respond when contain no 
        return "I agree."
    if wordlist[0] == 'please':
        # rule 15: respond when start with please
        return "I won't " + stringify(wordlist[wordlist.index('please') + 1:]) + '.'
    if wordlist[0] == 'tell':
        # rule 16: respond when start with tell
        return "Sorry, no."
    if wordlist[0] == 'i'or wordlist[0] == 'we':
        # rule 17: respond when start with i
        return cycle3()
    if 'sorry' in wordlist:
        # rule 18: respond when contain sorry
        return "Don't feel sorry because I don't care."
    if wordlist[0:2] == ['are','you']:
        # rule 19: respond when start with are you
        return "Guess."
    if len(wordlist) <= 2:
        # rule 20: respond when length <= 2
        return stringify(wordlist).capitalize() + "?"
    if wordlist[0] == 'do' or wordlist[0] == 'did':
        # rule 21: respond when start with do or did
        return "No. Never."
    if wordlist[0] == "what" or wordlist[0] == "what's":
        # rule 22: respond when start with what or what's
        return cycle4()
    if wordlist[0] == 'if':
        # rule 23: respond when start with what or what's
        return "If only."
    if 'remember' in wordlist:
        # rule 24: respond when contain remember
        return "Emmmmmm... remember..."
    if 'you' in mapped_wordlist or 'You' in mapped_wordlist:
        # rule 25: respond when contain you
        return stringify(mapped_wordlist) + '.'
    return punt()

attitude = ['like', 'tolerate', 'dislike', 'hate', 'love'] #attitude list

# cycle1 list (respond when start with i am)
CYCLE1 = ["I don't care if you are ",
        "I don't want to know you are ",
        "You are not "]

cycle1_count = -1 #cycle1's cycle count

def cycle1():
    'Returns one from a list of cycle1 responses.'
    global cycle1_count
    cycle1_count += 1
    return CYCLE1[cycle1_count % len(CYCLE1)]

# cycle2 list (respond when contain attitude words)
CYCLE2 = ["I don't ",
        "I really don't "]

cycle2_count = -1 #cycle2's cycle count

def cycle2():
    'Returns one from a list of cycle2 responses.'
    global cycle2_count
    cycle2_count += 1
    return CYCLE2[cycle2_count % len(CYCLE2)]

# cycle3 list (respond when start with i or we)
CYCLE3 = ["What? ",
        "I don't care. ",
        "I really don't care.",
        "I really really don't care.",
        "Sorry, I don't understand.",
        "Ah?"]

cycle3_count = -1 #cycle3's cycle count

def cycle3():
    'Returns one from a list of cycle3 responses.'
    global cycle3_count
    cycle3_count += 1
    return CYCLE3[cycle3_count % len(CYCLE3)]

# cycle4 list (respond when start with what or what's)
CYCLE4 = ["I don't know.",
          "I don't want to tell you.",
          "No comment.",
          "Nothing to say.",
          "Guess please."]

cycle4_count = -1 #cycle4's cycle count

def cycle4():
    'Returns one from a list of cycle4 responses.'
    global cycle4_count
    cycle4_count += 1
    return CYCLE4[cycle4_count % len(CYCLE4)]

# cycle5 list (respond when contain why)
CYCLE5 = ["Because you are stupid.",
         "I don't care why.",
         "Is why really the problem?",
         "Because of love."]

cycle5_count = -1 #cycle4's cycle count

def cycle5():
    'Returns one from a list of cycle4 responses.'
    global cycle5_count
    cycle5_count += 1
    return CYCLE5[cycle5_count % len(CYCLE5)]

# default responds list
PUNTS = ['Please go on. ',
         'I see. ',
         'Cool. ',
         'You are loser. ',
         'Remember I am mean.',
         'Could you repeat that?',
         'Tell me your story. ']

remem = 'False' #if "remember" in response
def punt():
    'Returns one from a list of default responses.'
    global remem
    if remem == 'True' :
        remem = 'False'
        return "Could you repeat that?"
    res = choice(PUNTS)
    if (res.find("Remember") != -1 ):
        remem = 'True'
    return res

def verbp(w):
    'Returns True if w is one of these known verbs.'
    return (w in ['go', 'have', 'be', 'try', 'eat', 'take', 'help',
                  'make', 'get', 'jump', 'write', 'type', 'fill',
                  'put', 'turn', 'compute', 'think', 'drink',
                  'blink', 'crash', 'crunch', 'add'])

def wpred(w):
    'Returns True if w is one of the question words.'
    return (w in ['when','where','how'])

punctuation_pattern = compile(r"\,|\.|\?|\!|\;|\:")    

def remove_punctuation(text):
    'Returns a string without any punctuation.'
    return sub(punctuation_pattern,'', text)

CASE_MAP = {'i':'you', 'I':'you', 'me':'you','you':'me',
            'my':'your','your':'my',
            'yours':'mine','mine':'yours','am':'are'}

def you_me(w):
    'Changes a word from 1st to 2nd person or vice-versa.'
    try:
        result = CASE_MAP[w]
    except KeyError:
        result = w
    return result

def you_me_map(wordlist):
    'Applies YOU-ME to a whole sentence or phrase.'
    return [you_me(w) for w in wordlist]

def stringify(wordlist):
    'Create a string from wordlist, but with spaces between words.'
    return ' '.join(wordlist)

# nickname of agents
def agentName():
    return "Unkown"
