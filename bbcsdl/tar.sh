#!/bin/bash

cd ..
tar -z -c -f bbcsdl.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  bbcsdl
