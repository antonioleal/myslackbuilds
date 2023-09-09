#!/bin/bash

cd ..
tar -z -c -f ZEsarUX.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  ZEsarUX
