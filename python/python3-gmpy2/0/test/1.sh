#!/usr/bin/env python3

from gmpy2 import *

print(mpz(99) * 43)
print(pow(mpz(99), 37, 59))
print(isqrt(99))
print(isqrt_rem(99))
print(gcd(123, 27))
print(lcm(123, 27))
print((mpz(123) + 12) / 5)
print((mpz(123) + 12) // 5)
print((mpz(123) + 12) / 5.0)
print(mpz('123') + 1)
print(10 - mpz(1))
print(is_prime(17))
print(mpz('1_000_000'))
print(mpq(3, 7)/7)
print(mpq(45, 3) * mpq(11, 8))
print(mpq(1, 7) * 11)


ctx = get_context()
print(ctx.precision)
ctx.precision = 100
print(mpfr('1.2'))
print(mpfr(float('1.2')))

ctx.precision = 53
ctx.round = RoundUp
print(const_pi())
ctx.round = RoundToNearest
print(const_pi())
