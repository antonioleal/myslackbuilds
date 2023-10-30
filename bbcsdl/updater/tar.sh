#!/bin/bash

cd slackbuild
tar -z -c -f bbcsdl.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../bbcsdl
