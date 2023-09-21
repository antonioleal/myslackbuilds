#!/bin/bash

cd ..
tar -z -c -f B-em.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  B-em
