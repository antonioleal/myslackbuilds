#!/bin/bash

TAG=b2-20241028-215441-a8b4f2a
echo
echo "cloning tag $TAG"
echo

git clone --recursive --branch $TAG https://github.com/tom-seddon/b2.git
rm -rf b2/.git
mv b2 $TAG
tar cvfz $TAG.tar.gz $TAG
rm -rf $TAG
