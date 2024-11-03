#!/bin/bash

# Slackware build scipt for 0scripts

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
echo "Building Package $PKGNAME:"
echo

echo "--------------------------------------------------------------------------------"
echo
read -p "Run sbolint? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sbolint .
fi

echo "--------------------------------------------------------------------------------"
echo
read -p "Run SlackBuild for Package $PKGNAME? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sudo sh ./$PKGNAME.SlackBuild
fi

echo "--------------------------------------------------------------------------------"
echo
VERSION=`cat *.info | grep VERSION | cut -d"\"" -f2`
echo "Tarballs available at /tmp:"
ls /tmp/$PKGNAME-$VERSION* -lasth
TARBALL=`ls /tmp/$PKGNAME-$VERSION* -1t | head -n1`


echo "--------------------------------------------------------------------------------"
echo
read -p "Run sbopkglint $TARBALL ? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sbopkglint $TARBALL
fi

echo "--------------------------------------------------------------------------------"
echo
read -p "Install $TARBALL ? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sudo /sbin/upgradepkg --install-new --reinstall $TARBALL
fi


echo "--------------------------------------------------------------------------------"
echo
read -p "Create SlackBuild package by running tar.sh? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    ./0/tar.sh
fi
