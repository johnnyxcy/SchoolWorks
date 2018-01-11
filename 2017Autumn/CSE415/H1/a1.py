  
def three_x_cubed_plus_7(x):
    return 3* (x * x * x) + 7

print(three_x_cubed_plus_7(2)) # output: 31
print(three_x_cubed_plus_7(12)) # output: 5191
print(three_x_cubed_plus_7(0)) # output: 7

#2 mystery_code("abc Iz th1s Secure? n0, no, 9!")
# Rule: 
# Lower Case:     if ord(character) <= 103, then chr(ord(character) - 13)
#                   otherwise, chr(ord(character) - 39)
#                   a -> T, b -> V, ..., g -> Z, h -> A, i -> B, ..., z -> S
# Capital Case:     if ord(character) <= 71, then chr(ord(character) + 51)
#                   otherwise, chr(ord(character) + 25)
#                   A -> t, B -> v, ..., G -> z, H -> a, I -> b, ..., Z -> s
def mystery_code(str):
    'Change the case and map to a different character if the character is alphabetic'
    result = ""
    for x in range(len(str)):
        if str[x].isalpha() :
            num = ord(str[x])
            if num < 97: # Capital Cases
                if num <= 71:
                    result += chr(num + 51)
                else:
                    result += chr(num + 25)
            else: # Lower Cases
                if num <= 103:
                    result += chr(num - 13)
                else:
                    result += chr(num - 39)
        else:
            result += str[x]
        x += 1
    return result

print(mystery_code("abc Iz th1s Secure? n0, no, 9!")) 
# output: TUV bS MA1L lXVNKX? G0, GH, 9!
print(mystery_code("How about TOMORROW? Let's meet at Space Needle at 10")) 
# output: aHP TUHNM mhfhkkhp? eXM'L FXXM TM lITVX gXXWEX TM 10
print(mystery_code("!I HATE DURIANs!")) 
# output: !b atmx wnkbtgL!

#3 3. pair_off([2, 5, 1.5, 100, 3, 8, 7, 1, 1, 0, -2])
def pair_off(list):
    for index in range(len(list)):
        if index >= len(list) :
            return list
        elif index + 1 == len(list):
            list[index] = [list[index]]
            index += 1
        else:
            list[index] = [list[index], list[index + 1]]
            list.pop(index + 1)
            index += 1

print(pair_off([2, 5, 1.5, 100, 3, 8, 7, 1, 1, 0, -2])) 
# output: [[2, 5], [1.5, 100], [3, 8], [7, 1], [1, 0], [-2]]
print(pair_off([1, 2, 3, 32141, 0, -0,1234143124231]))
# output: [[1, 2], [3, 32141], [0, 0], [1234143124231]]
print(pair_off([None, None, None, None]))
# output: [[None, None], [None, None]]

# 4. past_tense(['program', 'debug', 'execute', 'crash', 'repeat', 'eat'])
def past_tense(list):
    MAP_SPECIAL = {'have':'had', 'be':'was', 'eat':'ate', 'go':'went'}
    vowel = ['a', 'e', 'i', 'o', 'u']
    for index in range(len(list)):
        try:
            list[index] = MAP_SPECIAL[list[index]]
        except KeyError:
            cur = list[index]
            if cur[len(cur) - 1] == 'e':
                list[index] += 'd'
            elif cur[len(cur) - 1] == 'y' and cur[len(cur) - 2] not in vowel:
                list[index] = cur.replace('y', "ied")
            elif cur[len(cur) - 3] not in vowel and cur[len(cur) - 2] in vowel and\
            (cur[len(cur) - 1] not in (vowel and ['y', 'w'])):
                list[index] += cur[len(cur) - 1]
                list[index] += "ed"
            else:
                list[index] += "ed"
        index += 1
    return list

print(past_tense(['program', 'debug', 'execute', 'crash', 'repeat', 'eat']))
# output: ['programmed', 'debugged', 'executed', 'crashed', 'repeated', 'ate']
print(past_tense(['delay', 'imagine', 'go', 'cry', 'play', 'shout']))
# output: ['delayed', 'imagined', 'went', 'cried', 'played', 'shouted']
print(past_tense(['love', 'marry', 'believe', 'pass', 'watch']))
# output: ['loved', 'married', 'believed', 'passed', 'watched']