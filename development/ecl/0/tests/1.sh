#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

make -f Makefile
echo
echo "------------------------"
echo
./hello.exe
rm hello.exe
