#Yang Le
#CSE 415
#October 4, 2017

#This program includes the setting of an agent and provides material for communicate with others.

from re import *
import random





def introduce():
    return """Ni Hao, this is Siri! I am the absolutely
     capable to solve everything, no matter it is about 
     music and art, or physics and biology. No other human 
     can beat me! But I hate teaching other person. I like 
     basketballs and I am a challenger tier LOL player. If 
     you have some more information and would like me to 
     know and learn, please email me at yangl23@uw.edu. 
     Come and let's chat! """

def agentName():
    return "Siri"

favor_food = ''
def respond(input):
    sport = ['basketball', 'tennis', 'soccer']
    food = ['pizza', 'ramen', 'steak', 'cheeseburger', 'rice', 'vegetable']
    people = ['bill gates', 'steve jobs', "kobe bryant"]
    social = ["facebook", "instagram", "whatsapp", 'twitter']
    phone = ["lg", "samsung", "iphone", "xiaomi"]
    like = ['walking', 'lol', 'Apple']
    topic = ["basketball", "soccer", "food"]


    input = input.lower()
    words = split(" ", remove_punctuation(input))
    if words[0:3] == ['you', 'said', 'remember'] :
        return "GOOD"
    words = you_me_map(words)
    if bool(set(food).intersection(set(words))):
        global favor_food
        favor_food = set(food).intersection(set(words))
    if bool(set(phone).intersection(set(words))):
        favor_phone = set(phone).intersection(set(words))

    if 'goodbye' in input:
        return "Zai Jian"
    if len(input) == 0:
        return "I cannot hear you."

    now = ""
    global question
    question = -1
    now = topic[0]

    questions = ["What do you like for dinner?",
                 "What sports do you like?",
                 "What movies do you like?",
                 "Which cellphone are you using?",
                 "How do you feel now?",
                 "What about we going out tomorrow?"]

    if "day" in words:
        return "I like the weather today. It is sunny. "
    if "hang out" in input and "do you" in input:
        question += 1
        return "Yes, I like to hang out with you. " + questions[question]
    if "music" in words:
        question += 2
        return "I like Chinese music. " + questions[question]
    if "hungry" in words:
        topic = topic.remove('food')
        question += 2
        return "I know you want to eat " + " ".join(favor_food) + ". " + questions[question]
    if "fruit" in words:
        question += 3
        return "I like apples. " + questions[question]
    if "favorite food" in input or "dinner" in words or "lunch" in words or "breakfast" in words:
        topic = topic.remove('food')
        question += 4
        return "I love steak. " + questions[question]
    if bool(set(phone).intersection(set(words))):
        question += 5
        return "I love " + " ".join(favor_phone).upper() + ", too. But I love iPhone best. " + questions[question]
    if "drink" in words:
        question += 6   
        return "I do not have time today. " +  questions[question]
    if "where" in words:
        return "What about Mars?"
    if "when" in words:
        return "What about 7?"
    if "tower" in words:
        return "Remember Stark Tower at 7. "
    if "remember" in words:
        return "Repeat what I said."
    if "sports" in words:
        play = random.choice(sport)
        return "I like playing " + play +". "

    if "why" in words:
        return "I do not know"

    if (("basketball" and "i") or ("basketball" and "you") in words) and "basketball" in topic:
        topic.remove('basketball')
        now = random.choice(topic)
        return "I like basketball like hell! Sorry, just got excited, what is your question?"
    if ("soccer" and "you") or ("soccer" and "i") in words and "soccer" in topic:
        topic.remove('soccer')
        now = random.choice(topic)
        return "I love Leo Messi. What about you?"
    if "let me" in input:
        return "Sure, just do it!"
    if "color" in words:
        return "My favorite color is blue. What is yours?"
    if "i like" in input:
        thing = words[words.index('like') + 1]
        select = random.choice(topic)
        return "I do not like " + thing + ", but I like " + select + ". "

    if bool(set(people).intersection(set(words))):
        return "I think " + name + " is one of the greatest person. He is just so brilliant. I admire him a lot."
    if bool(set(food).intersection(set(words))):
        mode += 1
        return "I like " + eat + " and I eat it twice a week. "
    if bool(set(social).intersection(set(words))):
            return "Oh, I use " + media + " as well. I think I am additive to it. "

    if now == "basketball":
        topic.remove('basketball')
        now = random.choice(topic)
        return "Great! Do you like basketball?"
    elif now == "soccer":
        topic.remove('soccer')
        now = random.choice(topic)
        return "Oh, do you watch soccer? Which soccer team do you support?"
    elif now == "food":
        topic.remove('food')
        now = random.choice(topic)
        return "Alright. I like steak a lot because it is so tasty. What kind of food do you like?"

    punt()


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

punctuation_pattern = compile(r"\,|\.|\?|\!|\;|\:")

def remove_punctuation(text):
    'Returns a string without any punctuation.'
    return sub(punctuation_pattern,'', text)

PUNTS = ['Please go on.',
         'Tell me more.',
         'I see.',
         'What does that indicate?',
         'But why be concerned about it?',
         'Just tell me how you feel.',
         'Just do it']

def punt():
    'Returns one from a list of default responses.'
    return random.choice(PUNTS)