# Restoring Division Algorithm in Python
def restoring_division(dividend, divisor, n_bits):
    A = 0
    Q = dividend
    M = divisor

    for _ in range(n_bits):
        # Left-shift [A, Q]
        A = (A << 1) | ((Q >> (n_bits - 1)) & 1)
        Q = ((Q << 1) & ((1 << n_bits) - 1))

        # Subtract M
        A = A - M

        if A < 0:  # Restore
            A = A + M
            Q = Q & ~1  # set last bit to 0
        else:
            Q = Q | 1   # set last bit to 1

    return Q, A  # Quotient, Remainder

# Non-Restoring Division Algorithm in Python


# Example usage
dividend = int(input("Enter Dividend: "))
divisor = int(input("Enter Divisor: "))
n_bits = 4

q1, r1 = restoring_division(dividend, divisor, n_bits)


print("Restoring Division -> Quotient:", q1, "Remainder:", r1)
