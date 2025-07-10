#!/bin/bash

# Slackware 0script to run all updaters

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

# Note: In order for this to work please install the jq package from SBo

cd ~/slackware-builds/myslackbuilds
for updaterdir in `find . -name "0" -print`
do
    cd ~/slackware-builds/myslackbuilds
    if [ "$updaterdir" == "./0" ] || [ "$updaterdir" == "./0/0" ]; then
        continue
    elif [ -f $updaterdir/updater.sh ]; then
        echo "Running $updaterdir/updater.sh"
        RET0=""
        source ~/slackware-builds/myslackbuilds/$updaterdir/updater.sh
        echo
        if ! [ "$RET0" = "" ]
        then
            read -p "Spawn work Konsole ? (Y/n) " op
            if [ "$op" = "y" ] || [ "$op" = "Y" ] || [ "$op" = "" ]
            then
                konsole --workdir ~/slackware-builds/myslackbuilds/$updaterdir/..
            fi
        fi
    else
        cd $updaterdir/..
        PKGNAME=${PWD##*/}
        echo "No updater.sh for $PKGNAME"
        echo
    fi
done
echo "Done."
