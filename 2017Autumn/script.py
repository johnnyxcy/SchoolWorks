def search(A, B):
    for i in (range(len(A) + 1)):
        if B in A * i:
            return i
    return -1

print(search("abcd", "cdabcdab"))