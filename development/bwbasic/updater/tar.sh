#!/bin/bash

PRGNAM=bwbasic

cd slackbuild
tar -z -c -f ${PRGNAM}.tar.gz -v --exclude='updater' --exclude='*.tar.gz' --exclude='*.zip' ../../../${PRGNAM}
