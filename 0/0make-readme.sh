#!/bin/bash

# Slackware 0script to generate a README.md

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

cd ~/slackware-builds/myslackbuilds
README=README.md

rm -rf $README

echo -e "*This repo contains my slackbuild scripts, some of which also published to SlackBuilds.org*\n" >> $README
echo -e "---\n" >> $README
echo -e "  \n" >> $README

for fich in `find . -name "*-desc" -print`;
do
    DIR="$(dirname "${fich}")"
    PKGNAME=${DIR##*/}
    source $DIR/$PKGNAME.info
    echo "$DIR"

    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | head -n2`
    echo "##$AUX" >> $README
    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | tail -n10 | grep -v '^[[:space:]]*$'`
    echo "$AUX" >> $README
    echo -e "  \n" >> $README

    VERSION=`cat $DIR/*.info | grep "VERSION" | cut -d "=" -f 2-10`
    VERSION="${VERSION%\"}"
    VERSION="${VERSION#\"}"
    CATEGORY=`echo $fich | cut -d "/" -f 2`

    echo "- Category: $CATEGORY" >> $README
    echo "- Version: $VERSION" >> $README
    if [ -f $DIR/0/README.md ]; then
        cat $DIR/0/README.md >> $README
        if [ -f $DIR/0/updater.sh ]; then
            echo >> $README
            echo "*updater.sh is available for this package*" >> $README
        fi
    fi
done
