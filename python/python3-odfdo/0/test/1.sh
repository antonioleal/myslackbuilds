#!/bin/bash

python3 1.py

( /usr/bin/libreoffice ./hello.odt & )
( /usr/bin/libreoffice ./modified_spreadsheet.ods & )
sleep 10
rm hello.odt
rm modified_spreadsheet.ods

