#!/bin/sh

DEST="$HOME/qb64pe-3.8.0"
if [ ! -d $DEST ]
then
    notify-send "Setting up $DEST workspace for first run, please be patient..."
    mkdir -p $DEST
    cd $DEST
    tar xvfz /usr/src/qb64pe-3.8.0/QB64pe-3.8.0.tar.gz --strip-components=1
    make clean OS=lnx
    make OS=lnx BUILD_QB64=y -j1
    fi
cd $DEST
./qb64pe &
