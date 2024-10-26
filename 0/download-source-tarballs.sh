#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

set -e
clear
cd ..
PKGNAME=${PWD##*/}
source *.info

echo "--------------------------------------------------------------------------------"
cat *.info
echo
echo

read -p "WGET DOWNLOAD_x86_64? (y/n) " op
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

echo "--------------------------------------------------------------------------------"
echo
read -p "WGET DOWNLOAD? (y/n) " op
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
echo "Done."
