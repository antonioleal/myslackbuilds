#!/bin/sh

DEST="$HOME/.config/qb64-2.1"
if [ ! -d $DEST ]
then
    notify-send "Setting up $DEST workspace for first run, please be patient..."
    CWD=`pwd`
    mkdir -p $DEST
    cd $DEST
    tar xvfz /usr/src/qb64-2.1/qb64-2.1.tar.gz --strip-components=1
    pushd internal/c/libqb/os/lnx >/dev/null
    rm -f libqb_setup.o
    ./setup_build.sh
    popd >/dev/null
    pushd internal/c/parts/video/font/ttf/os/lnx >/dev/null
    rm -f src.o
    ./setup_build.sh
    popd >/dev/null
    pushd internal/c/parts/core/os/lnx >/dev/null
    rm -f src.a
    ./setup_build.sh
    popd >/dev/null
    cp -r ./internal/source/* ./internal/temp/
    pushd internal/c >/dev/null
    g++ -no-pie -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lpthread -ldl -lrt -D FREEGLUT_STATIC -o ../../qb64
    popd
    rm -rf run_qb64.sh
    ln -s /usr/bin/set_qb64.sh run_qb64.sh
    cd $CWD
fi
$DEST/qb64 "$@" &
