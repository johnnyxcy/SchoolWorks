T = {
    'Dormitory, X, Dormitory':0,
    'Dormitory, X, Lavatory':0.4,
    'Dormitory, X, Pantry':0,
    'Dormitory, X, Mess Hall':0.6,
    'Dormitory, X, Ambushed':0,
    'Dormitory, X, Kaput':0,
    'Dormitory, Y, Dormitory':0,
    'Dormitory, Y, Lavatory':0.6,
    'Dormitory, Y, Pantry':0,
    'Dormitory, Y, Mess Hall':0.4,
    'Dormitory, Y, Ambushed':0,
    'Dormitory, Y, Kaput':0,
    'Dormitory, Z, Dormitory':0.75,
    'Dormitory, Z, Lavatory':0,
    'Dormitory, Z, Pantry':0,
    'Dormitory, Z, Mess Hall':0,
    'Dormitory, Z, Ambushed':0.25,
    'Dormitory, Z, Kaput':0,
    'Lavatory, X, Dormitory':0.4,
    'Lavatory, X, Lavatory':0,
    'Lavatory, X, Pantry':0.6,
    'Lavatory, X, Mess Hall':0,
    'Lavatory, X, Ambushed':0,
    'Lavatory, X, Kaput':0,
    'Lavatory, Y, Dormitory':0.6,
    'Lavatory, Y, Lavatory':0,
    'Lavatory, Y, Pantry':0.4,
    'Lavatory, Y, Mess Hall':0,
    'Lavatory, Y, Ambushed':0,
    'Lavatory, Y, Kaput':0,
    'Lavatory, Z, Dormitory':0,
    'Lavatory, Z, Lavatory':0.75,
    'Lavatory, Z, Pantry':0.,
    'Lavatory, Z, Mess Hall':0,
    'Lavatory, Z, Ambushed':0.25,
    'Lavatory, Z, Kaput':0,
    'Pantry, X, Dormitory':0,
    'Pantry, X, Lavatory':0.6,
    'Pantry, X, Pantry':0,
    'Pantry, X, Mess Hall':0.4,
    'Pantry, X, Ambushed':0,
    'Pantry, X, Kaput':0,
    'Pantry, Y, Dormitory':0,
    'Pantry, Y, Lavatory':0.4,
    'Pantry, Y, Pantry':0,
    'Pantry, Y, Mess Hall':0.6,
    'Pantry, Y, Ambushed':0,
    'Pantry, Y, Kaput':0,
    'Pantry, Z, Dormitory':0,
    'Pantry, Z, Lavatory':0,
    'Pantry, Z, Pantry':0.75,
    'Pantry, Z, Mess Hall':0,
    'Pantry, Z, Ambushed':0.25,
    'Pantry, Z, Kaput':0,
    'Mess Hall, X, Dormitory':0.4,
    'Mess Hall, X, Lavatory':0,
    'Mess Hall, X, Pantry':0.6,
    'Mess Hall, X, Mess Hall':0,
    'Mess Hall, X, Ambushed':0,
    'Mess Hall, X, Kaput':0,
    'Mess Hall, Y, Dormitory':0.6,
    'Mess Hall, Y, Lavatory':0,
    'Mess Hall, Y, Pantry':0.4,
    'Mess Hall, Y, Mess Hall':0,
    'Mess Hall, Y, Ambushed':0,
    'Mess Hall, Y, Kaput':0,
    'Mess Hall, Z, Dormitory':0,
    'Mess Hall, Z, Lavatory':0,
    'Mess Hall, Z, Pantry':0,
    'Mess Hall, Z, Mess Hall':0.75,
    'Mess Hall, Z, Ambushed':0.25,
    'Mess Hall, Z, Kaput':0,
    'Ambushed, *, Dormitory':0,
    'Ambushed, *, Lavatory':0,
    'Ambushed, *, Pantry':0,
    'Ambushed, *, Mess Hall':0,
    'Ambushed, *, Ambushed':0,
    'Ambushed, *, Kaput':1,
    'Kaput, *, Dormitory':0,
    'Kaput, *, Lavatory':0,
    'Kaput, *, Pantry':0,
    'Kaput, *, Mess Hall':0,
    'Kaput, *, Ambushed':0,
    'Kaput, *, Kaput':1
}

R = {
    'Dormitory':0,
    'Lavatory':4,
    'Pantry':10,
    'Mess Hall':2,
    'Ambushed':-50,
    'Kaput':0
}
states = ['Dormitory', 'Lavatory', 'Pantry', 'Mess Hall', 'Ambushed', 'Kaput']
actions = ['X', 'Y', 'Z']
gamma = 0.5

def V(s, iterations):
    if iterations > 0:
        max = 0
        best = ''
        for a in actions:
            v = 0
            if s == 'Ambushed' or s == 'Kaput':
                v += R['Kaput'] + gamma * V('Kaput', iterations - 1)
            else: 
                for s1 in states:
                    key = s + ', ' + a  + ', ' + s1 
                    if T[key] != 0:
                        v += T[key] * (R[s1] + gamma * V(s1, iterations - 1))
            if v > max:
                max = v
                best = a
        return max
    return 0

print(str(V('Dormitory', 5)))
print(str(V('Lavatory', 5)))
print(str(V('Pantry', 5)))
print(str(V('Mess Hall', 5)))
print(str(V('Ambushed', 5)))
print(str(V('Kaput', 5)))