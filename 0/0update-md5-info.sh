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

if [[ $1 == "" ]]
then
    INFOFILE="`ls -1 *.info | head -n1`"
else
    INFOFILE=$1
fi

echo "Calculated md5sums for the downloaded tarballs already declared in $INFOFILE"
echo "-------------------------------------------------------------------------------------------------------"
echo
source $INFOFILE
cp $INFOFILE $INFOFILE.new

echo "PRGNAM=\"${PRGNAM}\""
echo "PRGNAM=\"${PRGNAM}\"" > $INFOFILE.new

echo "VERSION=\"${VERSION}\""
echo "VERSION=\"${VERSION}\"" >> $INFOFILE.new

echo "HOMEPAGE=\"${HOMEPAGE}\""
echo "HOMEPAGE=\"${HOMEPAGE}\"" >> $INFOFILE.new

ident="                       "
calcula()
{
    MD5SUM=(  )  #array to populate with the ms5sums
    pass=0
    echo -n "$2\""
    echo -n "$2\"" >> $INFOFILE.new
    for i in $1
    do
        source=`echo $i| rev | cut -d "/" -f1 | rev`
        if [[ $pass -eq 0 ]]
        then
            pass=1
            echo -n "$i"
            echo -n "$i" >> $INFOFILE.new
        else
            echo " \\"
            echo " \\" >> $INFOFILE.new
            len=${#2}+1
            echo -n "${ident:0:$len}$i"
            echo -n "${ident:0:$len}$i" >> $INFOFILE.new
        fi
        MD5SUM+=( "$source" )
    done
    echo -n "\""
    echo -n "\"" >> $INFOFILE.new
    echo
    echo >> $INFOFILE.new

    echo -n "$3\""
    echo -n "$3\"" >> $INFOFILE.new
    for i in ${!MD5SUM[@]}
    do
        aux=`md5sum ${MD5SUM[$i]} | cut -d" " -f1`
        if [[ $i -eq 0 ]]
        then
            echo -n "$aux"
            echo -n "$aux" >> $INFOFILE.new
        else
            echo " \\"
            echo " \\" >> $INFOFILE.new
            len=${#3}+1
            echo -n "${ident:0:$len}$aux"
            echo -n "${ident:0:$len}$aux" >> $INFOFILE.new
        fi
    done
    echo -n "\""
    echo -n "\"" >> $INFOFILE.new
    echo
    echo >> $INFOFILE.new
}

calcula "$DOWNLOAD" "DOWNLOAD=" "MD5SUM="
calcula "$DOWNLOAD_x86_64" "DOWNLOAD_x86_64=" "MD5SUM_x86_64="

echo "REQUIRES=\"${REQUIRES}\""
echo "REQUIRES=\"${REQUIRES}\"" >> $INFOFILE.new

echo "MAINTAINER=\"${MAINTAINER}\""
echo "MAINTAINER=\"${MAINTAINER}\"" >> $INFOFILE.new

echo "EMAIL=\"${EMAIL}\""
echo "EMAIL=\"${EMAIL}\"" >> $INFOFILE.new

#  ---------------------------------------------------------------
echo
echo "-------------------------------------------------------------------------------------------------------"
echo "- THE DIFFERENCES ARE:"
echo "-------------------------------------------------------------------------------------------------------"
echo
diff $INFOFILE $INFOFILE.new
echo "-------------------------------------------------------------------------------------------------------"
read -p "Replace $INFOFILE? (y/N) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]
then
    mv $INFOFILE.new $INFOFILE
fi

#  ---------------------------------------------------------------
echo
echo "----------------"
echo "Done."
