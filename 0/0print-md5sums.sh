#!/bin/bash

# Slackware 0script to print MD5SUM from existing downloaded tarballs file
# useful to update *.info files

# Copyright 2024 Antonio Leal, Porto Salvo, Oeiras, Portugal
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

clear
echo "Calculated md5sums for the downloaded tarballs already declared in $1"
echo "-------------------------------------------------------------------------------------------------------"
echo
source $1

ident="                       "
calcula()
{
    MD5SUM=(  )  #array to populate with the ms5sums
    i=0
    echo -n "$2\""
    for f in $1
    do
        source=`echo $f| rev | cut -d "/" -f1 | rev`
        if [[ $i -eq 0 ]]
        then
            i=1
            echo -n "$f"
        else
            echo " \\"
            len=${#2}+1
            echo -n "${ident:0:$len}$f"
        fi
        MD5SUM+=( "$source" )
    done
    echo -n "\""

    echo
    echo -n "$3\""
    for i in ${!MD5SUM[@]}
    do
        aux=`md5sum ${MD5SUM[$i]} | cut -d" " -f1`
        if [[ $i -eq 0 ]]
        then
            echo -n "$aux"
        else
            echo " \\"
            len=${#3}+1
            echo -n "${ident:0:$len}$aux"
        fi
    done
    echo -n "\""
    echo
}

calcula "$DOWNLOAD" "DOWNLOAD=" "MD5SUM="
calcula "$DOWNLOAD_x86_64" "DOWNLOAD_x86_64=" "MD5SUM_x86_64="

#  ---------------------------------------------------------------
echo
echo
echo "----------------"
echo "Done."
