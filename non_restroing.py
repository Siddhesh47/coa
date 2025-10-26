def non_restoring_division(dividend, divisor, n_bits):
    A = 0
    Q = dividend
    M = divisor

    for _ in range(n_bits):
        # Left shift [A, Q]
        A = (A << 1) | ((Q >> (n_bits - 1)) & 1)
        Q = ((Q << 1) & ((1 << n_bits) - 1))

        if A >= 0:
            A = A - M
            Q = Q | 1
        else:
            A = A + M
            Q = Q & ~1

    # Correction step
    if A < 0:
        A = A + M

    return Q, A  # Quotient, Remainder

dividend = int(input("Enter Dividend: "))
divisor = int(input("Enter Divisor: "))
n_bits = 4

q1, r1 = non_restoring_division(dividend, divisor, n_bits)
print("Non-Restoring Division -> Quotient:", q1, "Remainder:", r1)