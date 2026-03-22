#!/usr/bin/env python3

from mpmath import mp
mp.dps = 50
print(mp.quad(lambda x: mp.exp(-x**2), [-mp.inf, mp.inf]) ** 2)

