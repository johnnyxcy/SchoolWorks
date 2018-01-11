def print_subdirect(p:path):
    'print all files and subdirectoreis under the path'
    for q in p.iterdir():
        print(q)
        if q is directory:
            print_subdirect(q)
    return

