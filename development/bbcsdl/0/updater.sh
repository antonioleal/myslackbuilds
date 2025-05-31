#!/bin/bash

# Slackware updater script for bbcsdl

# Copyright 2025 Antonio Leal, Porto Salvo, Oeiras, Portugal
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PRGNAM=bbcsdl
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
COMMIT=`git ls-remote https://github.com/rtrussell/BBCSDL/ | head -1 | cut  -f 1`
NEWVERSION=${COMMIT:0:7}
TARBALL1=BBCSDL-${COMMIT}.tar.gz
URL1="https://github.com/rtrussell/BBCSDL/archive/${COMMIT}/BBCSDL-${COMMIT}.tar.gz"
TARBALL2=bbclinux32.zip
URL2="https://www.bbcbasic.co.uk/bbcsdl/bbclinux32.zip"
TARBALL3=bbclinux.zip
URL3="https://www.bbcbasic.co.uk/bbcsdl/bbclinux.zip"

VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "updater.sh says $PRGNAM is already at version $VERSION. No new update."
    export RET0=""
else
    ################################
    # download tarballs            #
    ################################
    rm -rf ../*.tar.gz 2> /dev/null
    rm -rf ../*.zip 2> /dev/null
    wget $URL1
    if [ ! -f ./$TARBALL1 ]
    then
        echo "File $TARBALL1 not found, aborting..."
        exit
    fi
    mv *.tar.gz ..

    wget $URL2
    if [ ! -f ./$TARBALL2 ]
    then
        echo "File $TARBALL2 not found, aborting..."
        exit
    fi
    mv *.zip ..

    wget $URL3
    if [ ! -f ./$TARBALL3 ]
    then
        echo "File $TARBALL3 not found, aborting..."
        exit
    fi
    mv *.zip ..

    ################################
    # write templates              #
    ################################
    MD51=`md5sum ../$TARBALL1 | cut -d " " -f 1`
    DATEVERSION=`tar tvfz ../$TARBALL1 | head -n1 | awk '{ print $4 }' | awk 'BEGIN { FS = "-" } ; { print $1$2$3 }'`
    MD52=`md5sum ../$TARBALL2 | cut -d " " -f 1`
    MD53=`md5sum ../$TARBALL3 | cut -d " " -f 1`

    sed -e "s/_fullversion_/${DATEVERSION}_${NEWVERSION}/g" \
        -e "s/_commit_/${COMMIT}/g" \
        -e "s/_md51_/${MD51}/" \
        -e "s/_md52_/${MD52}/" \
        -e "s/_md53_/${MD53}/" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_fullversion_/${DATEVERSION}_${NEWVERSION}/g" \
        -e "s/_commit_/${COMMIT}/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$NEWVERSION" > version
    echo "updater.sh says $PRGNAM has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
