#!/bin/bash

# Slackware updater script for onlyoffice-desktopeditors

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

PRGNAM=onlyoffice-desktopeditors
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

TAG=$(curl -s https://api.github.com/repos/ONLYOFFICE/DesktopEditors/releases/latest | jq -r '.tag_name')
NEWVERSION=${TAG:1}
TARBALL1=onlyoffice-desktopeditors_amd64.deb
TARBALL2=onlyoffice-desktopeditors-help_all.deb
URL1="https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${TAG}/${TARBALL1}"
URL2="https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${TAG}/${TARBALL2}"

VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "updater.sh says $PRGNAM is already at version $VERSION. No new update."
    export RET0=""
else
    ################################
    # download tarball             #
    ################################
    rm -rf ../*.deb 2> /dev/null
    wget $URL1
    if [ ! -f ./$TARBALL1 ]
    then
        echo "File $TARBALL1 not found, aborting..."
        exit
    fi
    wget $URL2
    if [ ! -f ./$TARBALL2 ]
    then
        echo "File $TARBALL2 not found, aborting..."
        exit
    fi
    # delete old tarballs and place new ones
    mv *.deb ..

    ################################
    # write templates              #
    ################################
    MD51=`md5sum ../$TARBALL1 | cut -d " " -f 1`
    MD52=`md5sum ../$TARBALL2 | cut -d " " -f 1`
    #DATEVERSION=`tar tvfz ../$TARBALL | head -n1 | awk '{ print $4 }' | awk 'BEGIN { FS = "-" } ; { print $1$2$3 }'`

    sed -e "s/_version_/${NEWVERSION}/g" \
        -e "s/_md51_/$MD51/g" \
        -e "s/_md52_/$MD52/g" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_version_/${NEWVERSION}/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$NEWVERSION" > version
    echo "updater.sh says $PRGNAM has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
