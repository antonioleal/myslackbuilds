#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR/..

sboname=${PWD##*/}
echo $sboname
cd 0/slackbuild

tar -z -c -f $sboname.tar.gz -v \
    --exclude='0'           \
    --exclude='*.tar.gz'    \
    --exclude='*.tar'       \
    --exclude='*.tgz'       \
    --exclude='*.txz'       \
    --exclude='*.zip'       \
    --exclude='*.md'        \
    --exclude='*.sf3'       \
    --exclude='*.deb'       \
    --exclude='*.rpm'       \
    ../../../$sboname
