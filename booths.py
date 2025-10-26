# EXP 4: IMPLEMENTATION OF BOOTHS ALGORITHM IN PYTHON

def dec_to_bin(n, bits):
    if n >= 0:
        s = bin(n)[2:].zfill(bits)
    else:
        s = bin((1 << bits) + n)[2:]
    return [int(b) for b in s]

def bin_to_dec(b):
    bits = len(b)
    if b[0] == 0:
        return int(''.join(str(x) for x in b), 2)
    else:
        return int(''.join(str(x) for x in b), 2) - (1 << bits)

def add_bin(a, b):
    n = len(a)
    result = [0] * n
    carry = 0
    for i in range(n-1, -1, -1):
        total = a[i] + b[i] + carry
        result[i] = total % 2
        carry = total // 2
    return result

def twos_complement(b):
    n = len(b)
    inv = [1 - bit for bit in b]
    return add_bin(inv, dec_to_bin(1, n))

def arithmetic_right_shift(A, Q, Q_1):
    new_Q_1 = Q[-1]
    Q = [A[-1]] + Q[:-1]
    A = [A[0]] + A[:-1]
    return A, Q, new_Q_1

def booths_algorithm(M, Q, bits):
    A = dec_to_bin(0, bits)
    M_bin = dec_to_bin(M, bits)
    neg_M_bin = twos_complement(M_bin)
    Q_bin = dec_to_bin(Q, bits)
    Q_1 = 0
    count = bits

    print("Initial Values:")
    print(f"A: {A} Q: {Q_bin} Q-1: {Q_1} M: {M_bin}")
    
    while count > 0:
        print(f"Step {bits - count + 1}:")
        if Q_bin[-1] == 0 and Q_1 == 1:
            print("Condition (0,1) -> A = A + M")
            A = add_bin(A, M_bin)
        elif Q_bin[-1] == 1 and Q_1 == 0:
            print("Condition (1,0) -> A = A - M")
            A = add_bin(A, neg_M_bin)
        else:
            print("Condition (0,0) or (1,1) -> No operation")

        print(f"Before Shift -> A: {A} Q: {Q_bin} Q-1: {Q_1}")

        A, Q_bin, Q_1 = arithmetic_right_shift(A, Q_bin, Q_1)
        print(f"After Shift  -> A: {A} Q: {Q_bin} Q-1: {Q_1}")
        count -= 1
    
    result_bin = A + Q_bin
    result_dec = bin_to_dec(result_bin)
    print("Final Binary Result:", result_bin)
    print("Final Decimal Result:", result_dec)

# Input Section
M = int(input("Enter multiplicand (M): "))
Q = int(input("Enter multiplier (Q): "))
bits = 5

booths_algorithm(M, Q, bits)