from prefixed import Float

print('{:.2h}s'.format(Float(.00001534)))

print(f'{Float(950):.2h}')

print(f'{Float(950):%-5.2h}')

print(f'{Float(1000):%5.2h}')

print(f'{Float(1050):%5.2h}')