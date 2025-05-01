#!/bin/bash

# Slackware updater script for smoffice2024

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

PRGNAM=smoffice2024
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
curl -s -o index.html https://www.softmaker.de/support/installation/linux/office-2024
#NEWVERSION=`lynx -dump index.html | tail -1 | cut -d "/" -f 14`
NEWVERSION=`lynx -dump index.html  | grep "2024.*amd64.tgz" | cut -d "-" -f4 | tail -n1`
rm index.html
echo "New version is $NEWVERSION"

if [ "$OLDVERSION" = "$NEWVERSION" ]; then
    echo "No new version detected..."
    return
fi
echo $NEWVERSION > old_version

################################
# download tarball             #
################################
cd ..
set +e
rm *.tgz
set -e
TARBALL=softmaker-office-2024-$NEWVERSION-amd64.tgz
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
echo
echo "SlackBuild has been updated!"
