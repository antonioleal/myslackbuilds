#!/bin/bash

VERSION=15.1.0

export PATH=/opt/gcc-${VERSION}/bin:$PATH
export LD_LIBRARY_PATH=/opt/gcc-${VERSION}/lib64:$LD_LIBRARY_PATH

# To let CMake know
export CC=/opt/gcc-${VERSION}/bin/gcc
export CXX=/opt/gcc-${VERSION}/bin/g++
export FC=/opt/gcc-${VERSION}/bin/gfortran
