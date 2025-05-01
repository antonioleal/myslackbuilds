#!/bin/bash

TAG=b2-20250105-203025-e825ff1
echo
echo "cloning tag $TAG"
echo

git clone --recursive --branch $TAG https://github.com/tom-seddon/b2.git
rm -rf b2/.git
mv b2 $TAG
tar cvfz $TAG.tar.gz $TAG
rm -rf $TAG
