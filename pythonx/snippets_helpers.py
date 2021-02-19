linelen = 88

def floor(i):
    if int(i) == i:
        return int(i)
    elif i > 0:
        return int(i)
    elif i < 0:
        return int(i) - 1

def ceil(i):
    if int(i) == i:
        return int(i)
    elif i > 0:
        return int(i) + 1
    elif i < 0:
        return int(i)

