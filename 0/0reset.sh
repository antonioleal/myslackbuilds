#!/bin/bash

# Slackware 0script to reset local git

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

set -e

proc="no"

if [ "$1" == "sl" ] || [ "$1" == "all" ]; then
    echo "---------------------------------------------------------------------"
    echo "on ~/slackware-builds/slackbuilds:"
    cd ~/slackware-builds/slackbuilds
    git checkout master
    git clean -f
    git reset --hard
    git pull --rebase
    proc="yes"
fi

if [ "$1" == "my" ] || [ "$1" == "all" ]; then
    echo "---------------------------------------------------------------------"
    echo "on ~/slackware-builds/myslackbuilds:"
    cd ~/slackware-builds/myslackbuilds
    git checkout main
    git clean -f
    git reset --hard
    git pull --rebase
    proc="yes"
fi

if [ "$proc" == "no" ]; then
    echo "please specify 'all', 'my' ou 'sl' as parameter"
fi
