#!/bin/bash

PRGNAM=qb64pe

cd slackbuild
tar -z -c -f ${PRGNAM}.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../${PRGNAM}
