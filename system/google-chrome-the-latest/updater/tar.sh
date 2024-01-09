#!/bin/bash

PRGNAM=google-chrome-the-latest

cd slackbuild
tar -z -c -f ${PRGNAM}.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../${PRGNAM}
