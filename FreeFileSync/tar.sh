#!/bin/bash

cd ..
tar -z -c -f FreeFileSync.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  FreeFileSync
