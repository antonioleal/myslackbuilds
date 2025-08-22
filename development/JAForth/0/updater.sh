#!/bin/bash

# Slackware updater script for JAForth

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

PRGNAM=JAForth
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
TAG=`lynx -accept_all_cookies -dump  https://codeberg.org/pgimeno/JAForth/commits/branch/master | grep "src/commit" | head -1 | awk -F"/" '{ print $NF }'`
TARBALL=${TAG}.tar.gz
URL="https://codeberg.org/pgimeno/JAForth/archive/${TARBALL}"

VERSION=`cat version`
if [ "$VERSION" = "$TAG" ]
then
    echo "is at version $VERSION"
    export RET0=""
else
    ################################
    # find date and build version  #
    ################################
    git clone --depth=1  https://codeberg.org/pgimeno/JAForth > /dev/null 2>&1
    cd JAForth
    AUX=`git log --date=format:'%Y%m%d' --pretty=format:'%h %cd' -1`
    SHORTTAG=`echo $AUX | awk '{print $1}'`
    DATE=`echo $AUX | awk '{print $2}'`
    NEWVERSION="${DATE}_${SHORTTAG}"
    cd ..
    rm -rf JAForth

    ################################
    # download tarball             #
    ################################
    wget $URL
    if [ ! -f ./$TARBALL ]
    then
        echo "File $TARBALL not found, aborting..."
        exit
    fi
    # delete old tarball and place new one
    rm -rf ../$TAG.tar.gz 2> /dev/null
    mv *.tar.gz ..

    ################################
    # write templates              #
    ################################
    MD5=`md5sum ../$TARBALL | cut -d " " -f 1`
    #DATEVERSION=`tar tvfz ../$TARBALL | head -n1 | awk '{ print $4 }' | awk 'BEGIN { FS = "-" } ; { print $1$2$3 }'`

    sed -e "s/_version_/${NEWVERSION}/g" \
        -e "s/_md5_/$MD5/g" \
        -e "s/_tag_/$TAG/g" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_version_/${NEWVERSION}/g" \
        -e "s/_tag_/$TAG/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$TAG" > version
    echo "has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
