#!/bin/bash

# Slackware 0script to make a PR to https://github.com/SlackBuildsOrg/slackbuilds

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

set -e
clear
PKGNAME=${PWD##*/}
source $PKGNAME.info
echo "Package: " $PKGNAME
if ! [ -f 0/slackbuild/$PKGNAME.tar.gz ]; then
    echo "0/slackbuild/$PKGNAME.tar.gz is non-existing. Are you at the correct folder?"
    exit
fi
cd ..
CATEGORY=${PWD##*/}
echo "Category: " $CATEGORY


MSG="$CATEGORY/$PKGNAME: Updated for version $VERSION"
echo "Commit message: " $MSG
read -p "change? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]
then
    read -p "Commit message: " MSG
fi
echo
echo

cd ~/slackware-builds/slackbuilds
git checkout -B $PKGNAME
cd ~/slackware-builds/slackbuilds/$CATEGORY/
echo
echo

tar xvfz ~/slackware-builds/myslackbuilds/$CATEGORY/$PKGNAME/0/slackbuild/$PKGNAME.tar.gz
echo
echo
pwd
git status

# git add all
echo
echo
echo Adding all files: git add --all
#read -p "Issue command above? (y/n) " op
op="y"
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    git add --all
fi

# git commit -a -m "$MSG"
echo
echo
echo Commit all files: git commit -a -m "\"$MSG\""
#read -p "Issue command above? (y/n) " op
sleep 2
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    git commit -a -m "$MSG"
fi

# git push -f origin $PKGNAME
echo
echo
echo Pushing to upstream master with: git push -f origin $PKGNAME
#read -p "Issue command above? (y/n) " op
sleep 2
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    git push -f origin $PKGNAME
fi

# return to master branch
echo
echo
echo Returning to master branch with: git checkout master
git checkout master
echo
echo Done.
