#!/bin/bash

PRGNAM=fpc

cd slackbuild
tar -z -c -f ${PRGNAM}.tar.gz -v --exclude='updater' --exclude='*.tar.gz' --exclude='*.tar'  ../../../${PRGNAM}
