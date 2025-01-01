#!/bin/bash

VERSION=14.2.0

export PATH=/opt/gcc-local-${VERSION}/bin:$PATH
export LD_LIBRARY_PATH=/opt/gcc-local-${VERSION}/lib64:$LD_LIBRARY_PATH

# To let CMake know
export CC=/opt/gcc-local-${VERSION}/bin/gcc
export CXX=/opt/gcc-local-${VERSION}/bin/g++
export FC=/opt/gcc-local-${VERSION}/bin/gfortran
