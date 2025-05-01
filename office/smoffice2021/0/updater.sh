#!/bin/bash

# Slackware updater script for smoffice2021

# Copyright 2023 Antonio Leal, Porto Salvo, Oeiras, Portugal
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

PRGNAM=smoffice2021
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
# OLDVERSION
touch old_version
OLDVERSION=`cat old_version`
echo "Old version is $OLDVERSION"

# NEWVERSION
#curl -s -o index.html http://valentina-db.com/download/prev_releases/?C=M;O=A
curl -s -o index.html https://www.softmaker.de/support/installation/linux/office-2021
#NEWVERSION=`lynx -dump index.html | tail -1 | cut -d "/" -f 14`
NEWVERSION=`lynx -dump index.html  | grep "2021.*amd64.tgz" | cut -d "-" -f4 | tail -n1`


echo "New version is $NEWVERSION"
echo $NEWVERSION > new_version

if [ "$OLDVERSION" = "$NEWVERSION" ]; then
    echo "No new version detected..."
    exit
fi

################################
# download tarball             #
################################
cd ..
set +e
rm *.tgz
set -e
TARBALL=softmaker-office-2021-$NEWVERSION-amd64.tgz
wget https://www.softmaker.net/down/$TARBALL
if [ ! -f ./$TARBALL ]
then
    echo "File $TARBALL not found, aborting..."
    exit 1
fi

################################
# write templates              #
################################
MD5=`md5sum $TARBALL | cut -d " " -f 1`
sed -e "s/\${_version_}/$NEWVERSION/" -e "s/\${_md5_}/$MD5/" $SCRIPT_DIR/template/${PRGNAM}.info.template > ${PRGNAM}.info
sed -e "s/\${_version_}/$NEWVERSION/" $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ${PRGNAM}.SlackBuild
chmod +x ${PRGNAM}.SlackBuild

################################
# build                        #
################################
set -e
sudo ./${PRGNAM}.SlackBuild
if [ ! -f /tmp/${PRGNAM}-2021_$NEWVERSION-x86_64-1_SBo.tgz ]
then
    echo "Build process not successfull, aborting..."
    exit 1
fi

################################
# make slackbuild tar.gz       #
################################
echo "Compressing SlackBuild release in slackbuild folder"
cd $SCRIPT_DIR/../..
rm -rf $SCRIPT_DIR/slackbuild/*
tar -z -v -c -f $SCRIPT_DIR/slackbuild/${PRGNAM}.tar.gz --exclude='*.tgz' --exclude='updater' ${PRGNAM}

################################
# cleanup                      #
################################
cd $SCRIPT_DIR
rm index.html
rm new_version

################################
# sbopkglint                   #
################################
sbopkglint /tmp/${PRGNAM}-2021_$NEWVERSION-x86_64-1_SBo.tgz

################################
# make slackbuild tar.gz       #
################################
read -p "Proceed with install of /tmp/${PRGNAM}-2021_$NEWVERSION-x86_64-1_SBo.tgz ? (y/n) " RESP
if [ ! "$RESP" = "y" ]; then
    echo "bye"
    exit
fi
sudo /sbin/upgradepkg --install-new /tmp/${PRGNAM}-2021_$NEWVERSION-x86_64-1_SBo.tgz
echo $NEWVERSION > $SCRIPT_DIR/old_version
echo
echo "/tmp/${PRGNAM}-2021_$NEWVERSION-x86_64-1_SBo.tgz installed."
