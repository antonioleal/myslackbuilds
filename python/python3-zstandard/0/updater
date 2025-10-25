#!/bin/bash

# Slackware updater script for python3-zstandard

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

PRGNAM=python3-zstandard
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
NEWVERSION=$(curl -s https://api.github.com/repos/indygreg/python-zstandard/releases/latest | jq -r '.tag_name')
URL32="https://github.com/indygreg/python-zstandard/releases/download/$NEWVERSION/zstandard-$NEWVERSION-cp39-cp39-manylinux2010_i686.manylinux2014_i686.manylinux_2_12_i686.manylinux_2_17_i686.whl"
URL64="https://github.com/indygreg/python-zstandard/releases/download/$NEWVERSION/zstandard-$NEWVERSION-cp39-cp39-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
TARBALL32=zstandard-$NEWVERSION-cp39-cp39-manylinux2010_i686.manylinux2014_i686.manylinux_2_12_i686.manylinux_2_17_i686.whl
TARBALL64=zstandard-$NEWVERSION-cp39-cp39-manylinux2014_x86_64.manylinux_2_17_x86_64.whl

VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "is at version $VERSION"
    export RET0=""
else
    ################################
    # download tarball             #
    ################################
    wget $URL32
    if [ ! -f ./$TARBALL32 ]
    then
        echo "File $TARBALL32 not found, aborting..."
        exit
    fi
    wget $URL64
    if [ ! -f ./$TARBALL64 ]
    then
        echo "File $TARBALL64 not found, aborting..."
        exit
    fi
    # delete old tarball and place new one
    rm -rf ../*.whl 2> /dev/null
    mv *.whl ..

    ################################
    # write templates              #
    ################################
    MD532=`md5sum ../$TARBALL32 | cut -d " " -f 1`
    MD564=`md5sum ../$TARBALL64 | cut -d " " -f 1`
    #DATEVERSION=`tar tvfz ../$TARBALL | head -n1 | awk '{ print $4 }' | awk 'BEGIN { FS = "-" } ; { print $1$2$3 }'`

    sed -e "s/_version_/${NEWVERSION}/g" \
        -e "s/_md532_/${MD532}/g" \
        -e "s/_md564_/${MD564}/g" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_version_/${NEWVERSION}/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$NEWVERSION" > version
    echo "has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
