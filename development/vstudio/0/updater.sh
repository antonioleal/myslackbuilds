#!/bin/bash

# Slackware updater script for vstudio

# Copyright 2023-2025 Antonio Leal, Porto Salvo, Oeiras, Portugal
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

PRGNAM=vstudio
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
# OLDVERSION
touch version
OLDVERSION=`cat version`
echo "Old version is $OLDVERSION"

# NEWVERSION
curl -s -o index.html http://valentina-db.com/download/prev_releases/?C=M;O=A
NEWVERSION=`lynx -dump index.html | tail -1 | cut -d "/" -f 14`
echo "New version is $NEWVERSION"
echo $NEWVERSION > version

if [ "$OLDVERSION" = "$NEWVERSION" ]; then
    echo "No new version detected..."
    exit
fi

MAJOR=`cut -d "." -f 1 version`
echo "Major version number is $MAJOR"
DEBFILE=vstudio_x64_${MAJOR}_lin.deb
echo "Debian file is $DEBFILE"
echo

################################
# download tarball             #
################################
cd ..
rm -f *.deb
wget http://valentina-db.com/download/prev_releases/$NEWVERSION/lin_64/$DEBFILE
if [ ! -f ./$DEBFILE ]
then
    echo "File $DEBFILE not found, aborting..."
    exit
fi

################################
# write templates              #
################################
MD5=`md5sum $DEBFILE | cut -d " " -f 1`
sed -e "s/\${_version_}/$NEWVERSION/" -e "s/\${_major_}/$MAJOR/" -e "s/\${_md5_}/$MD5/" $SCRIPT_DIR/template/${PRGNAM}.info.template > ${PRGNAM}.info
sed -e "s/\${_version_}/$NEWVERSION/" -e "s/\${_major_}/$MAJOR/" $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ${PRGNAM}.SlackBuild
chmod 644 ${PRGNAM}.SlackBuild

################################
# finish                       #
################################
echo $NEWVERSION > $SCRIPT_DIR/version

