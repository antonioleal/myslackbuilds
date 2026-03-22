

import os
import subprocess
import sys

class sb:
    name = ""
    url = ""
    sum = ""

sbs=[]

aux=os.system('git config --file .gitmodules --get-regexp "^submodule\..*\.url$" | awk "{print $2}" > aux.txt')
with open('aux.txt', 'rb') as f:
    for line in f:
        v = line.decode('utf-8').split()
        #print(v)
        ob = sb()
        ob.name = v[0].split("/")[1][:-4]
        ob.url = v[1]
        #print (ob.name)
        sbs.append(ob)

aux=os.system('git submodule status --recursive > aux.txt')
with open('aux.txt', 'r') as f:
    for line in f:
        v = line.strip().split()
        h = v[0][1:]
        n = v[1].split("/")[1]
        #print (h, n)
        found = False
        for o in sbs:
            if n == o.name:
                o.sum = h
                found = True
        #print (n, h)
        if not found:
            print ("Error key not found")
            sys.exit(1)
#print('\n\nThe submodules for this repo are:\n\n')
for o in sbs:
    print (f'{o.url}/archive/{o.sum}/{o.name}-{o.sum}.tar.gz \\')
print()
print("Commands in include in the SlackBuild:\n")
print("# Extract submodules")
print("(")
print("    cd ${PRGNAM}-${VERSION/./_}/src/lib or whatever directory sits at the top of the submodules")
for o in sbs:
    print(f'    tar xvf $CWD/{o.name}-{o.sum}.tar.gz --strip-components=1 -C {o.name}')
print(")")
