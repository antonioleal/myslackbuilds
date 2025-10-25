#!/bin/bash

# Slackware updater script for vst3sdk

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

PRGNAM=vst3sdk
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################

NEWVERSION=`curl -s https://api.github.com/repos/steinbergmedia/vst3_base/tags | grep name | head -1 | awk -F " " '{print substr($2,3,length($2)-4)}'`
SHORTVERSION=`echo $NEWVERSION | cut -d "_" -f1`
BUILD=`echo $NEWVERSION | cut -d "_" -f2-`

COMMIT1=`git ls-remote https://github.com/steinbergmedia/vst3sdk/ | head -1 | cut  -f 1`
TARBALL1=vst3sdk-${NEWVERSION}.tar.gz
URL1="https://github.com/steinbergmedia/vst3sdk/archive/v${NEWVERSION}/${TARBALL1}"

COMMIT2=`git ls-remote https://github.com/steinbergmedia/vst3_base/ | head -1 | cut  -f 1`
TARBALL2=vst3_base-${COMMIT2}.tar.gz
URL2="https://github.com/steinbergmedia/vst3_base/archive/${COMMIT2}/${TARBALL2}"

COMMIT3=`git ls-remote https://github.com/steinbergmedia/vst3_cmake/ | head -1 | cut  -f 1`
TARBALL3=vst3_cmake-${COMMIT3}.tar.gz
URL3="https://github.com/steinbergmedia/vst3_cmake/archive/${COMMIT3}/${TARBALL3}"

COMMIT4=`git ls-remote https://github.com/steinbergmedia/vst3_doc/ | head -1 | cut  -f 1`
TARBALL4=vst3_doc-${COMMIT4}.tar.gz
URL4="https://github.com/steinbergmedia/vst3_doc/archive/${COMMIT4}/${TARBALL4}"

COMMIT5=`git ls-remote https://github.com/steinbergmedia/vst3_pluginterfaces/ | head -1 | cut  -f 1`
TARBALL5=vst3_pluginterfaces-${COMMIT5}.tar.gz
URL5="https://github.com/steinbergmedia/vst3_pluginterfaces/archive/${COMMIT5}/${TARBALL5}"

COMMIT6=`git ls-remote https://github.com/steinbergmedia/vst3_public_sdk/ | head -1 | cut  -f 1`
TARBALL6=vst3_public_sdk-${COMMIT6}.tar.gz
URL6="https://github.com/steinbergmedia/vst3_public_sdk/archive/${COMMIT6}/${TARBALL6}"

COMMIT7=`git ls-remote https://github.com/steinbergmedia/vst3_tutorials/ | head -1 | cut  -f 1`
TARBALL7=vst3_tutorials-${COMMIT7}.tar.gz
URL7="https://github.com/steinbergmedia/vst3_tutorials/archive/${COMMIT7}/${TARBALL7}"

COMMIT8=`git ls-remote https://github.com/steinbergmedia/vstgui/ | head -1 | cut  -f 1`
TARBALL8=vstgui-${COMMIT8}.tar.gz
URL8="https://github.com/steinbergmedia/vstgui/archive/${COMMIT8}/${TARBALL8}"

c=( $COMMIT1 $COMMIT2 $COMMIT3 $COMMIT4 $COMMIT5 $COMMIT6 $COMMIT7 $COMMIT8 )
t=( $TARBALL1 $TARBALL2 $TARBALL3 $TARBALL4 $TARBALL5 $TARBALL6 $TARBALL7 $TARBALL8 )
u=( $URL1 $URL2 $URL3 $URL4 $URL5 $URL6 $URL7 $URL8 )


VERSION=`cat version`
if [ "$VERSION" = "$NEWVERSION" ]
then
    echo "is at version $VERSION"
    export RET0=""
else
    ################################
    # download tarball             #
    ################################
    rm -rf ../*.tar.gz 2> /dev/null
    for i in "${!t[@]}"
    do
        wget ${u[i]}
        if [ ! -f ./${t[i]} ]
        then
            echo "File ${t[i]} not found, aborting..."
            exit
        fi
        mv *.tar.gz ..
    done

    ################################
    # write templates              #
    ################################
    MD51=`md5sum ../$TARBALL1 | cut -d " " -f 1`
    MD52=`md5sum ../$TARBALL2 | cut -d " " -f 1`
    MD53=`md5sum ../$TARBALL3 | cut -d " " -f 1`
    MD54=`md5sum ../$TARBALL4 | cut -d " " -f 1`
    MD55=`md5sum ../$TARBALL5 | cut -d " " -f 1`
    MD56=`md5sum ../$TARBALL6 | cut -d " " -f 1`
    MD57=`md5sum ../$TARBALL7 | cut -d " " -f 1`
    MD58=`md5sum ../$TARBALL8 | cut -d " " -f 1`

    sed -e "s/_fullversion_/$NEWVERSION/g" \
        -e "s/_shortversion_/$SHORTVERSION/g" \
        -e "s/_thebuild_/$BUILD/g" \
        -e "s/_md51_/$MD51/g" \
        -e "s/_md52_/$MD52/g" \
        -e "s/_md53_/$MD53/g" \
        -e "s/_md54_/$MD54/g" \
        -e "s/_md55_/$MD55/g" \
        -e "s/_md56_/$MD56/g" \
        -e "s/_md57_/$MD57/g" \
        -e "s/_md58_/$MD58/g" \
        -e "s/_commit2_/$COMMIT2/g" \
        -e "s/_commit3_/$COMMIT3/g" \
        -e "s/_commit4_/$COMMIT4/g" \
        -e "s/_commit5_/$COMMIT5/g" \
        -e "s/_commit6_/$COMMIT6/g" \
        -e "s/_commit7_/$COMMIT7/g" \
        -e "s/_commit8_/$COMMIT8/g" \
        $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info

    sed -e "s/_shortversion_/$SHORTVERSION/g" \
        -e "s/_thebuild_/$BUILD/g" \
        -e "s/_commit2_/$COMMIT2/g" \
        -e "s/_commit3_/$COMMIT3/g" \
        -e "s/_commit4_/$COMMIT4/g" \
        -e "s/_commit5_/$COMMIT5/g" \
        -e "s/_commit6_/$COMMIT6/g" \
        -e "s/_commit7_/$COMMIT7/g" \
        -e "s/_commit8_/$COMMIT8/g" \
        $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild

    chmod 644 ../${PRGNAM}.SlackBuild
    echo "$NEWVERSION" > version
    echo "has a new version $NEWVERSION"
    export RET0=$NEWVERSION
fi
