#!/bin/bash

# Slackware 0script to delete branches

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

#set -e
clear
if [ "$1" == "" ]
then
    echo "Error: please specify branch name or 'all' as parameter"
    echo
else
    if [ "$1" == "all" ]
    then
        cd ~/slackware-builds/slackbuilds
        git checkout master
        echo
        for b in `git branch | grep -v "master"`
        do
            echo "deleting $b"
            git branch -D $b
            echo
        done
        for b in `git branch -r | grep -v "master"`
        do
            echo "deleting remote $b"
            git push origin -d $(echo $b | cut -d "/" -f2)
            echo
        done
    else
        git branch -D $1
        git push origin -d $1
    fi
    git fetch --prune
fi
echo
echo "------------------------------------------"
git branch -a
echo "------------------------------------------"
echo
