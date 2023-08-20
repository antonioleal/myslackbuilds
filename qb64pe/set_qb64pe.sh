#!/bin/sh

DEST="$HOME/.config/qb64pe-3.8.0"
if [ ! -d $DEST ]
then
    notify-send "Setting up $DEST workspace for first run, please be patient..."
    mkdir -p $DEST
    cd $DEST
    tar xvfz /usr/src/qb64pe-3.8.0/QB64pe-3.8.0.tar.gz --strip-components=1
    make clean OS=lnx
    make OS=lnx BUILD_QB64=y -j1
    rm -rf run_qb64pe.sh
    ln -s /usr/bin/set_qb64pe.sh run_qb64pe.sh
    fi
cd $DEST
./qb64pe &
