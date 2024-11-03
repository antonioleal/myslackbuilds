#!/bin/bash

set -e
clear
PKGNAME=${PWD##*/}
echo "Package: " $PKGNAME
cd ..
CATEGORY=${PWD##*/}
echo "Category: " $CATEGORY

read -p "Commit message: " MSG
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

# git commit -a -m "$CATEGORY/$PKGNAME: $MSG"
echo
echo
echo Commit all files: git commit -a -m "\"$CATEGORY/$PKGNAME: $MSG\""
#read -p "Issue command above? (y/n) " op
sleep 2
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    git commit -a -m "$CATEGORY/$PKGNAME: $MSG"
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
