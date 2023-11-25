#!/bin/bash

cd slackbuild
tar -z -c -f kForth-64.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../kForth-64
