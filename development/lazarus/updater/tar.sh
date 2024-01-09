#!/bin/bash

PRGNAM=lazarus

cd slackbuild
tar -z -c -f ${PRGNAM}.tar.gz -v --exclude='updater' --exclude='*.tar.gz' --exclude='*.zip' ../../../${PRGNAM}
