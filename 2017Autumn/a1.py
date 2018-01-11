#Write Python function definitions for the following requirements (worth 5 points each, 
#except for numbers 2 and 4, which are worth 10 points each). You should be able to infer 
#what each function should do by a combination of reading its name and examining the 
#relationship between its input and ouput on the given examples. Note that the functions 
#that accept lists as arguments must be able to handle lists of any length. For this assignment 
#your functions do not have to validate the types of their inputs. That is, you may assume that 
#they will be called with arguments of the proper types. In problem 2, you may find it helpful
#to write a helping function that can translate one character, and you may find the various 
#string methods to be useful: islower(), isupper(), isdigit(), isalpha(), index(), and join().
#You might also consider using the functions map(), and list(). The built-in Python functions
#ord and chr could come in handy. The mod operator ('%') may also be helpful.


#1. three_x_cubed_plus_7(2) -> 31
'''
@num > 0
@returns the x cube * 3 + 7
'''
def three_x_cubed_plus_7(num):
    return 3*num^(3)+7

#2. mystery_code("abc Iz th1s Secure? n0, no, 9!") -> "TUV bS MA1L lXVNKX? G0, GH, 9!"

 #(Hint: If a character of the input is alphabetic, then it undergoes a
 # change of case as well as a mapping to a different place in the alphabet.)
