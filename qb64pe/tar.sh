#!/bin/bash

cd ..
tar -z -c -f qb64pe.tar.gz -v --exclude='tar.sh' --exclude='*.tar.gz'  qb64pe
