from re import *   # Loads the regular expression module.
from random import choice
# introduce()
def introduce():
    'Give a short introduce for the agent itself'
    return("""My name is Tony Stark. My armor was never a distraction
    or a hobby. It was a cocoon. And now I'm a changed
    man. You can take away my house, all my tricks and
    toys. But one thing you can't take away... I am Iron Man
    I was programmed by Chongyi Xu. If you don't like
    me, contact him at chongyix@uw.edu or directly to Marverl.
   How can I help you?""")
def agentName():
    'Returns the nick name of the agent'
    return "Tony Stark"


memory = '' # Set up the memory
def respond(theInput):
    'Make response basing on different input'
    if (match('Bye', theInput)):
        return "See you."
    wordlist = split(' ', remove_punctuation(theInput))
    wordlist[0] = wordlist[0].lower()
    mapped_wordlist = you_me_map(wordlist)
    mapped_wordlist[0] = wordlist[0].capitalize()

    if wordlist[0]=='':
        # Rule 1: If the input contains nothing
        return("Say something, dude. Cmon.")
    
    if wordlist[0] == 'remember':
        # Rule 2: If the input starts with remember, save it as memory
        global memory
        memory = "You said " + stringify(mapped_wordlist).lower()
        return ansRemember() 

    if 'weather' in wordlist:
        # Rule 3: If the input contains "weather", give the answer and ask a question
        return ("My favorite weather is sunny cuz I love sunshine. " + giveQ())
    
    if ('dinner' in wordlist) or ('lunch' in wordlist) or ('breakfast' in wordlist) or ('food' in wordlist):
        # Rule 3: If the input contains "dinner", "lunch", "breakfast", "food", 
        # give a random answer and ask a question
        return (choice(FOOD) + giveQ())
    
    if 'sports' in wordlist:
        # Rule 4: If the input contains "sports", give a cycle of answers and ask a question
        return (ansSports() + giveQ())
    
    if ('movie' in wordlist) or ('movies' in wordlist):
        # Rule 5: If the input contains "movie" or "movies,
        # give the answer and ask a question
        return "Obviously, Ironman Series are the best. " + giveQ()

    if 'cellphone' in wordlist:
        # Rule 6: If the input contains "cellphone", give the random answer.
        return choice(CELLPHONES)
    
    if 'feel' in wordlist:
        # Rule 7: If the input contains "feel", give a random answer and ask a question
        return "I feel " + choice(FEELING) + ". Would you like to have a drink with me?"
    
    if 'tomorrow' in wordlist:
         # Rule 7: If the input contains "feel", give the answer.
        return "Tomorrow is good. Where are we going?"
    
    if 'Mars' in wordlist:
        # Rule 8: if the input contains "Mars", give a random response and ask the question
        return whatAbout_res() + "When are we going?"
    
    if '7' in wordlist:
        # Rule 8: if the input contains "7", give a random response and ask the question
        return whatAbout_res() + "Let us meet at Stark Tower"
    
    if wordlist[0] == 'how':
        # Rule 9: if the input starts with "how", give the asnwer
        return "Could you help me answer this? Let's see, " + stringify(wordlist)

    if wordlist[0:2] == ['what', 'about']:
        # Rule 10: if the input starts with "what about", give a random answer
        return whatAbout_res()

    if verbp(wordlist[0]):
        # Rule 11: if the input starts with any of the words in the list, give the answer
        return("Why do you want me to " + stringify(wordlist) + '?')

    if wpred(wordlist[0]):
        # Rule 12: if the input starts with any of the question words,  give the answer
        return("Why do we need to know " + wordlist[0] + "? We just do it. Right?")

    if wordlist[0:2] == ['i','am']:
        # Rule 13: if the input starts with "I am", give the cyclical responses
        return(res_WHO(wordlist))

    if wordlist[0:2] == ['i','have']:
        # Rule 14: if the input starts with "I have", give the answer
        return ("Well then, is it possible for you to tell me \
                how long have you had " + stringify(mapped_wordlist[2:]) + '?')

    if wordlist[0:2] == ['i','feel']:
        # Rule 15: if the input starts with "I feel", give the cyclical responses
        return(res_FEEL(wordlist))
        
    if (wordlist[0:2] == ['you','are']):
        # Rule 16: if the input starts with "you are", give the answer
        return ("Oh yeah, I am " + stringify(mapped_wordlist[2:]) + ".")

    if (wordlist[0:2] == ['are', 'you']):
        # Rule 17: if the input starts with "are you", give the answer
        return "Is that really the problem here? "

    if 'repeat' in wordlist:
        # Rule 18: if the input contains "repeat", give the answer in memory
        if memory == '' : # if the memory has nothing in it, return this
            return "You did not let me remeber anything yet."
        return memory

    if (wordlist[0:2] == ['do', 'you']) or (wordlist[0:2] == ['did', 'you']):
        # Rule 19: if the input starts with "do you" or "did you",
        #          give the answer
        return "What do you think about that? I want to hear your voice."
    
    if (wordlist[0:2] == ["i", "don't"]):
        # Rule 20: if the input starts with "i don't", give a cycle of answers
        return ansIdont(wordlist)
   
    if 'know' in wordlist:
        # Rule 21: if the input contains "know", give the answer
        return"People always think you know or they don't know about onething. \
                But is the line between known and unknown so clear? "
    
    if 'because' in wordlist:
        # Rule 22: if the input contains "because", give the answer
        return "Is that really the reason?"

    if 'yes' in wordlist:
        # Rule 23: if the input contains "yes", give the answer
        return "How can you be so sure?" 

    if wordlist[0:3] == ['do','you','think']:
        # Rule 24: if the input starts with "do you think", give the answer
        return "Time tells everything." 

    if dpred(wordlist[0]) and wordlist[1] == 'you' :
        # Rule 25: if the input starts with auxiliary verb and you, give the answer
        return ("Trust me, I know. I'm professional to " + stringify(mapped_wordlist[2:]) + ".")

    if 'hungry' in wordlist:
        # Rule 26: if the input contains "hungry", give the answer
        return "Give me a scotch. I'm starving." 
    
    if 'peace' in wordlist:
        # Rule 27: if the input contains "peace", give the answer
        return "Yeah, peace. I love peace. I'd be out of a job for peace. "

    if 'no' in wordlist:
        # Rule 28: if the input contains "no", give the answer
        return "We gotta go. Come on. We got a plan, and we're going to stick to it."

    if 'maybe' in wordlist:
        # Rule 29: if the input contains "maybe", give the answer
        return "Be more decisive."

    if 'you' in mapped_wordlist or 'You' in mapped_wordlist:
        # Rule 30: if the input contains "i" or "I", give the answer
        return(stringify(mapped_wordlist) + '.')
    
    # Rule 31: if any of the rules above does not match, give a cycle of default answers     
    return(others())

def stringify(wordlist):
    'Create a string from wordlist, but with spaces between words.'
    return ' '.join(wordlist)

punctuation_pattern = compile(r"\,|\.|\?|\!|\;|\:")    

def remove_punctuation(text):
    'Returns a string without any punctuation.'
    return sub(punctuation_pattern,'', text)

def wpred(w):
    'Returns True if w is one of the question words.'
    return (w in ['when','why','where', 'which', 'who'])

def dpred(w):
    'Returns True if w is an auxiliary verb.'
    return (w in ['do','can','should','would'])


CASE_MAP = {'i':'you', 'I':'you', 'me':'you','you':'me',
            'my':'your','your':'my',
            'yours':'mine','mine':'yours','am':'are',
            'myself':'yourself','yourself':'myself'}

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

def verbp(w):
    'Returns True if w is one of these known verbs.'
    return (w in ['go', 'have', 'be', 'try', 'eat', 'take', 'help',
                  'make', 'get', 'jump', 'write', 'type', 'fill',
                  'put', 'turn', 'compute', 'think', 'drink',
                  'blink', 'crash', 'crunch', 'add'])

who_count = -1
def res_WHO(wordList):
    'Cyclically choose a response to answer "I am..."'
    global who_count
    who_count += 1 
    res = ["Did you just said you are " + stringfy(wordlist[2:]) +\
         "? [LONG PAUSE.] That is funny.",
        "I can see you are " + stringfy(wordlist[2:])]
    return res[who_count % len(res)]

feel_count = -1
def res_FEEL(wordList):
    'Cyclically choose a response to anwer "I feel..."'
    global feel_count
    feel_count += 1
    FEEL = ["JARVIS, could you tell me what does this guy mean? ",
    "Unfortunately, I feel " + wordList[2:] + "as well.",
    "[laughs]"]
    return FEEL[feel_count % len(res)]

QUESTION = ["Do you like to hang out with me?",
            "Do you like music?",
            "I am hungry. Let us get something for eat.",
            "What fruit do you like?",
            "What is your favorite food?"]
q_count = -1
def giveQ():
    'Cyclically give a question'
    global q_count
    q_count += 1
    return QUESTION[q_count % len(QUESTION)]

SPORTS = ["I always go boxing when I am free. ",
        "I also go climbing sometimes. ",
        "I go to gym everyday. "]
sports_count = -1
def ansSports():
    'Cyclically answer the question about sports'
    global sports_count
    sports_count += 1
    return SPORTS[sports_count % len(SPORTS)]


def whatAbout_res():
    'Randomly choose a response to answer "what about" question'
    return choice(["Nice choice. ", "It works for me. ","Sure. "])

REMEMBER = ["Are you doubting me? I can remember it.",
            "JARVIS, bring that to my core memory.",
            "I am good at remembering things"]
remember_count = -1
def ansRemember():
    'Cyclically give the response to remember'
    global remember_count
    remember_count += 1
    return REMEMBER[remember_count % len(REMEMBER)]


idont_count = -1
def ansIdont(wordlist):
    'Cyclically give the response to I don\'t... '
    global idont_count
    idont_count += 1
    res = ["Why don't? You should give yourself a chance.",
            "I know you don't.",
            "\"Don't \" is not always a good answer.",
            "Human should believe in their possibilities.",
            "You could " + stringify(wordlist[2:])]
    return res[idont_count % len(res)]

OTHERS = ['Sometimes you gotta run before you can walk.',
         'What are you trying to get rid of me for? You got plans?',
         'If we can\'t protect the Earth, you can be damned well sure we\'ll avenge it.',       
         'What is the point of owning a race car if you can\'t drive it?',
         'Are you out of power, JARVIS?',
         choice(QUESTION)]

other_count = -1
def others():
    'Cyclically returns one from a list of default responses.'
    global other_count
    other_count += 1
    return OTHERS[other_count % len(OTHERS)]

CELLPHONES = ["lg", "samsung", "iphone", "xiaomi"]
FOOD = ['pizza', 'ramen', 'steak', 'cheeseburger', 'rice', 'vegetable']
FEELING = ['sick', 'tired', 'not bad', 'awesome']
