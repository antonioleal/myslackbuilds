#!/bin/bash

cd ..
tar -z -c -f yabasic.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  yabasic
