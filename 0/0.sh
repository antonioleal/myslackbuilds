#!/bin/bash

# Slackware menu for 0scripts

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


PKGNAME=${PWD##*/}
HEIGHT=22
WIDTH=88
CHOICE_HEIGHT=20
BACKTITLE="Antonio Leal's \"0\" scripts SlackBuild environment: $PKGNAME"
TITLE="WORKFLOW"
MENU="Choose one of the following options for $PKGNAME:"

OPTIONS=(1 "less $PKGNAME.info"
         2 "0meld.sh                        # check if SlackBuilds.org changed the script"
         3 "0replace-string.sh              # changes a string in *.* using sed"
         4 "0download-source-tarballs.sh    # get the source code"
         5 "0update-md5-info.sh             # recalculates md5 and updates info file"
         6 "0build.sh                       # builds the package"
         7 "0make-readme.sh                 # updated README.md"
         8 "0commit-push.sh                 # push changes - local commit"
         9 "0pull-request.sh                # generates a PR on SLackBuilds GitHub site"
         0 "0clean-tree.sh                  # runs git clean -f"
         b "less $PKGNAME.SlackBUild"
         d "git diff"
         s "git status"
         q "quit to dos ;-)"
         )

while (true)
do
    CHOICE=$(dialog --clear \
                    --backtitle "$BACKTITLE" \
                    --title "$TITLE" \
                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)

    clear
    case $CHOICE in
            1)
                less $PKGNAME.info
                ;;
            2)
                0meld.sh
                ;;
            3)
                0replace-string.sh
                read -p "Press [ENTER] to continue." op
                ;;
            4)
                0download-source-tarballs.sh
                read -p "Press [ENTER] to continue." op
                ;;
            5)
                0update-md5-info.sh
                read -p "Press [ENTER] to continue." op
                ;;
            6)
                0build.sh
                read -p "Press [ENTER] to continue." op
                ;;
            7)
                0make-readme.sh
                ;;
            8)
                0commit-push.sh
                read -p "Press [ENTER] to continue." op
                ;;
            9)
                0pull-request.sh
                read -p "Press [ENTER] to continue." op
                ;;
            0)
                0clean-tree.sh
                read -p "Press [ENTER] to continue." op
                ;;
            b)
                less $PKGNAME.SlackBuild
                ;;
            d)
                git diff
                read -p "Press [ENTER] to continue." op
                ;;
            s)
                git status
                read -p "Press [ENTER] to continue." op
                ;;
            q)
                exit 0
                ;;
    esac
done

