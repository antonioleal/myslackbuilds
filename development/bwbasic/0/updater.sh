#!/bin/bash

# Slackware updater script for bwbasic

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

PRGNAM=bwbasic
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
NEWVERSION=`curl -qsL "https://sourceforge.net/projects/bwbasic/best_release.json" | jq -r ".platform_releases.linux.filename" | awk '{print $2}' | awk -F "/" '{print $1}'`
TARBALL1=bwbasic-${NEWVERSION}.zip
URL1="https://sourceforge.net/projects/bwbasic/files/bwbasic/version%20${NEWVERSION}/${TARBALL1}"
TARBALL2=bwbasic-tests-2017-07-06.zip
URL2="https://sourceforge.net/projects/bwbasic/files/bwbasic/version%203.20/${TARBALL2}"

VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "updater.sh says $PRGNAM is already at version $VERSION. No new update."
    export RET0=""
else
    ################################
    # download tarball             #
    ################################
    rm -rf ../*.zip 2> /dev/null
    wget $URL1
    if [ ! -f ./$TARBALL1 ]
    then
        echo "File $TARBALL1 not found, aborting..."
        exit
    fi
    # delete old tarball and place new one
    mv *.zip ..

    wget $URL2
    if [ ! -f ./$TARBALL2 ]
    then
        echo "File $TARBALL2 not found, aborting..."
        exit
    fi
    # delete old tarball and place new one
    mv *.zip ..

    ################################
    # write templates              #
    ################################
    MD5=`md5sum ../$TARBALL1 | cut -d " " -f 1`
    #DATEVERSION=`tar tvfz ../$TARBALL | head -n1 | awk '{ print $4 }' | awk 'BEGIN { FS = "-" } ; { print $1$2$3 }'`

    sed -e "s/_version_/${NEWVERSION}/g" \
        -e "s/_md5_/$MD5/g" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_version_/${NEWVERSION}/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$NEWVERSION" > version
    echo "updater.sh says $PRGNAM has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
