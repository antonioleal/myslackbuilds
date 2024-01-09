#!/bin/bash

# Slackware updater script for B-em

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

PRGNAM=B-em
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

################################
# check versions               #
################################
# OLDVERSION
touch old_version
OLDVERSION=`cat old_version`

# NEWVERSION
COMMIT=`git ls-remote https://github.com/stardot/b-em/ | head -1 | cut  -f 1`
NEWVERSION=${COMMIT:0:7}

# cd git/simh
# git reset --hard
# git pull --rebase
# COMMIT=`git rev-parse HEAD`
# NEWVERSION=${COMMIT:0:7}
# cd ../..

echo
echo "Old version is $OLDVERSION"
echo "New version is $NEWVERSION"
#echo $NEWVERSION > new_version

if [ "$OLDVERSION" = "$NEWVERSION" ]; then
    echo "No new version detected..."
    exit
fi

################################
# download tarball             #
################################
TARBALL=b-em-$COMMIT.tar.gz
wget https://github.com/stardot/b-em/archive/${NEWVERSION}/${TARBALL}
if [ ! -f ./${TARBALL} ]
then
    echo "File $TARBALL not found, aborting..."
    exit
fi

# delete old tarball and place new one
rm -i ../*.tar.gz
mv *.tar.gz ..

################################
# write templates              #
################################
MD5=`md5sum ../$TARBALL | cut -d " " -f 1`
sed -e "s/\${_version_}/$NEWVERSION/" -e "s/\${_commit_}/$COMMIT/" -e "s/\${_commit_}/$COMMIT/" -e "s/\${_md5_}/$MD5/" $SCRIPT_DIR/template/${PRGNAM}.info.template > ../${PRGNAM}.info
sed -e "s/\${_version_}/$NEWVERSION/" -e "s/\${_commit_}/$COMMIT/" $SCRIPT_DIR/template/${PRGNAM}.SlackBuild.template > ../${PRGNAM}.SlackBuild
chmod +x ../${PRGNAM}.SlackBuild

################################
# build                        #
################################
cd $SCRIPT_DIR/..
sudo ./${PRGNAM}.SlackBuild
if [ ! -f /tmp/${PRGNAM}-$NEWVERSION-x86_64-1_SBo.tgz ]
then
    echo "Build process not successfull, aborting..."
    exit
fi

################################
# make slackbuild tar.gz       #
################################
echo "Compressing SlackBuild release in slackbuild folder '${PRGNAM}'"
cd $SCRIPT_DIR/../..
rm -rf $SCRIPT_DIR/slackbuild/*
tar -z -v -c -f $SCRIPT_DIR/slackbuild/${PRGNAM}.tar.gz --exclude='*.tar.gz' --exclude='updater' ${PRGNAM}

################################
# sbopkglint                   #
################################
sbopkglint /tmp/${PRGNAM}-$NEWVERSION-x86_64-1_SBo.tgz

################################
# make slackbuild tar.gz       #
################################
read -p "Proceed with install of /tmp/${PRGNAM}-$NEWVERSION-x86_64-1_SBo.tgz ? (y/n) " RESP
if [ ! "$RESP" = "y" ]; then
    echo "bye"
    exit
fi
sudo /sbin/upgradepkg --install-new /tmp/${PRGNAM}-$NEWVERSION-x86_64-1_SBo.tgz
echo $NEWVERSION > $SCRIPT_DIR/old_version
echo
echo "/tmp/${PRGNAM}-$NEWVERSION-x86_64-1_SBo.tgz installed."
