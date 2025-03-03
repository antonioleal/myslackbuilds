#!/bin/bash

cat *.info | grep ".com" | cut -d "/" -f 7

