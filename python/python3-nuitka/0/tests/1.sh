#!/bin/bash

nuitka 1.py
./1.bin

rm -rf 1.build
rm -rf 1.bin
