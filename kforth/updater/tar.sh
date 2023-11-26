#!/bin/bash

cd slackbuild
tar -z -c -f kforth.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../kforth
