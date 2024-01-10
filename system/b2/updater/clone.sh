#!/bin/bash

TAG=b2-20231011-172305-4bd1939

git clone --recursive --branch $TAG https://github.com/tom-seddon/b2.git
rm -rf b2/.git
mv b2 $TAG
tar cvfz $TAG.tar.gz $TAG
rm -rf $TAG
