#!/bin/bash

# Slackware 0help

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

echo "--------------------------------------------------------------------------------------------------------------"
echo " WORKFLOW HELP:"
echo "--------------------------------------------------------------------------------------------------------------"
echo
echo " 1. 0delete-branches.sh                       -> delete branches from last week updates"
echo
echo " 2. sed -iE \"s/old ver/new ver/g\" infofile    -> update the info version number, probably needs editing too"
echo
echo " 3. 0download-source-tarballs.sh              -> get the source code"
echo
echo " 4. 0update-info.sh                           -> recalculates md5 and updates info file"
echo
echo " 5. 0download-source-tarballs.sh              -> confirms md5 is correct"
echo
echo " 6. 0build.sh                                 -> builds the package (now install it and test it)"
echo
echo " 7. 0pull-request.sh                          -> generates a PR on SLackBuilds GitHub site"
echo "                                                 go there and confirm it"
echo
echo " SEE ALSO THE README.md FILE"
echo
echo "--------------------------------------------------------------------------------------------------------------"
echo
