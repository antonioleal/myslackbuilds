#!/bin/bash

# Slackware 0script to download sources listed in the *.info file

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
source *.info

echo "--------------------------------------------------------------------------------"
cat *.info
echo
echo


read -p "WGET DOWNLOAD? (y/N) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    for s in $DOWNLOAD
    do
        echo "--------------------------------------------------------------------------------"
        echo "Downloading: $s"
        wget -nc $s
        TARBALL=`echo $s | rev | cut -d"/" -f1 | rev`
        SUM=`md5sum $TARBALL | cut -d" " -f1`
        echo "**************************************"
        echo "** $SUM **"
        echo "**************************************"

        FOUND="no"
        for CHK in $MD5SUM
        do
            if [ "$CHK" = "$SUM" ]; then
                FOUND="yes"
            fi
        done
        if [ "$FOUND" = "yes" ]; then
            echo "Confirmed checksum in info file"
        else
            echo "Checksum error in info file"
        fi
        echo
    done
fi

echo
echo "--------------------------------------------------------------------------------"
echo

read -p "WGET DOWNLOAD_x86_64? (y/N) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    for s in $DOWNLOAD_x86_64
    do
        echo "--------------------------------------------------------------------------------"
        echo "Downloading: $s"
        wget -nc $s
        TARBALL=`echo $s | rev | cut -d"/" -f1 | rev`
        SUM=`md5sum $TARBALL | cut -d" " -f1`
        echo "**************************************"
        echo "** $SUM **"
        echo "**************************************"

        FOUND="no"
        for CHK in $MD5SUM_x86_64
        do
            if [ "$CHK" = "$SUM" ]; then
                FOUND="yes"
            fi
        done
        if [ "$FOUND" = "yes" ]; then
            echo "Confirmed checksum in info file"
        else
            echo "Checksum error in info file"
        fi
        echo
    done
fi

echo
echo "Done."
