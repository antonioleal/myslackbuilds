#!/bin/bash

cd slackbuild
tar -z -c -f kforth.tar.gz -v --exclude='updater' --exclude='*.tar.gz' --exclude='dpans94.pdf' ../../../kforth
