#!/bin/bash

cd slackbuild
tar -z -c -f smoffice2024.tar.gz -v --exclude='updater' --exclude='*.tar.gz'  ../../../smoffice2024
