#!/bin/bash

cd slackbuild
tar -z -c -f kForth-32.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../kForth-32
