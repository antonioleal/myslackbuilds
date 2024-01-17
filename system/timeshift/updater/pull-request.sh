#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

cd ..
PKGNAME=${PWD##*/}
echo "Package: " $PKGNAME
cd ..
CATEGORY=${PWD##*/}
echo "Category: " $CATEGORY

read -p "Commit message: " MSG

cd ~/slackware-builds/antonioleal/slackbuilds/$CATEGORY/

git checkout -B $PKGNAME
sleep 2

tar xvfz ~/slackware-builds/antonioleal/myslackbuilds/$CATEGORY/$PKGNAME/updater/slackbuild/$PKGNAME.tar.gz
sleep 2

echo git commit -a -m "$CATEGORY/$PKGNAME: $MSG"
echo git push -f origin $PKGNAME
echo git checkout master
echo git branch -D $PKG

