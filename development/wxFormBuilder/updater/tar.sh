#!/bin/bash

cd slackbuild
tar -z -c -f wxFormBuilder.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../wxFormBuilder
