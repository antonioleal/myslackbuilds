#!/bin/bash

# Slackware updater script for plus42

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

PRGNAM=plus42
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################

#tag=$(curl -s https://api.github.com/repos/Alex313031/thorium/releases/latest | jq -r '.tag_name')
#echo $tag

# NEWVERSION
#COMMIT=`git ls-remote https://github.com/stardot/b-em/ | head -1 | cut  -f 1`
#NEWVERSION=${COMMIT:0:7}

#COMMIT=`git ls-remote https://github.com/stardot/b-em/ | head -1 | cut  -f 1`
#NEWVERSION=${COMMIT:0:7}

#NEWVERSION=`curl -qsL "https://sourceforge.net/projects/doublecmd/best_release.json" | jq -r ".platform_releases.linux.filename" | cut -d "/" -f 3 | cut -d " " -f 3`
#TARBALL=doublecmd-${NEWVERSION}-src.tar.gz

#TAG=$(curl -s https://api.github.com/repos/wxFormBuilder/wxFormBuilder/releases/latest | jq -r '.tag_name')
#NEWVERSION=${TAG:1}
#TARBALL=wxFormBuilder-${NEWVERSION}-source-full.tar.gz

#NEWVERSION=$(curl -s https://2484.de/yabasic/content_whatsnew.html | grep Version | head -n1 | cut -d " " -f 6 | cut -d "," -f 1)
#TARBALL=yabasic-${NEWVERSION}.tar.gz

#NEWVERSION=`curl -qsL "https://sourceforge.net/projects/eightyone-sinclair-emulator/best_release.json" | jq -r ".release.filename" | cut -d " " -f 2 | awk '{ print substr($0,2,length($0)-5) }'`
#TARBALL=EightyOne V${NEWVERSION}.zip
#URL="https://sourceforge.net/projects/eightyone-sinclair-emulator/files/EightyOne%20V${NEWVERSION}.zip"

#NEWVERSION=`curl -qsL "https://sourceforge.net/projects/lazarus/best_release.json" | jq -r ".platform_releases.linux.filename" | awk -F "-" '{print substr($NF,1,length($NF)-4)}'`
#TARBALL=lazarus-${NEWVERSION}-0.tar.gz
#URL="http://downloads.sourceforge.net/lazarus/${TARBALL}"

TAG=`git ls-remote  https://codeberg.org/thomasokken/plus42desktop | tail -n1 | cut -d"/" -f 3`
NEWVERSION=${TAG:1}
TARBALL=${TAG}.tar.gz
URL="https://codeberg.org/thomasokken/plus42desktop/archive/${TAG}.tar.gz"

VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "updater.sh says $PRGNAM is already at version $VERSION. No new update."
    export RET0=""
else
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
    rm -rf ../*.tar.gz 2> /dev/null
    mv *.tar.gz ..

    ################################
    # write templates              #
    ################################
    MD5=`md5sum ../$TARBALL | cut -d " " -f 1`
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
