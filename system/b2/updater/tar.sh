#!/bin/bash

cd slackbuild
tar -z -c -f b2.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../b2
