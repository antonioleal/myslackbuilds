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

CWD="$(echo `pwd`)"
PKGNAME=${PWD##*/}
HEIGHT=26
WIDTH=90
CHOICE_HEIGHT=24
BACKTITLE="Antonio Leal's \"0\" scripts SlackBuild environment at $CWD"
TITLE="$PKGNAME"
MENU="Choose one of the following options for package: $PKGNAME"

if ! [ -f $PKGNAME.info ]; then
  echo "You must run this script from within a SlackBuild folder."
  exit 0
fi

DIALOG_CANCEL=1
DIALOG_ESC=255

OPTIONS=()
if [ -f 0/updater.sh ]; then
OPTIONS+=(0 "** Run updater.sh for this SlackBuild **"
         "" "---------------------------------------------------------------------------------"
         )
fi
OPTIONS+=(1 "Run \"less $PKGNAME.info\""
         2 "Compare with slackbuilds            # check if SlackBuilds.org changed the script"
         3 "Replace strings                     # Uses sed in the $PKGNAME folder"
         4 "Download sources                    # get the source code"
         5 "Update md5 in info                  # recalculates md5 and updates info file"
         "" "---------------------------------------------------------------------------------"
         6 "Build                               # builds the package"
         7 "Open tar.gz ready SlackBuild        # uses the ark program"
         "" "---------------------------------------------------------------------------------"
         8 "Commit & Push                       # local commits changes and pushes to GitHub"
         9 "Pull Request SlackBuilds.org        # generates a PR on SlackBuilds GitHub site"
         "" "---------------------------------------------------------------------------------"
         c "Clean tree                          # runs git clean -f"
         b "Run \"less $PKGNAME.SlackBuild\""
         d "Run \"git diff\""
         s "Run \"git status\""
         q "Quit to DOS :)"
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

    exit_status=$?
    exec 3>&-
    clear
    case $exit_status in
        $DIALOG_CANCEL)
        echo "Program terminated."
        exit
        ;;
        $DIALOG_ESC)
        echo "Program terminated." >&2
        exit 1
        ;;
    esac

    case $CHOICE in
            0)
                if [ -f 0/updater.sh ]; then
                    cd 0
                    source updater.sh
                    cd $CWD
                fi
                ;;
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
                echo "close ark to return to main menu..."
                ark 0/slackbuild/$PKGNAME.tar.gz
                ;;
            8)
                0commit-push.sh
                read -p "Press [ENTER] to continue." op
                ;;
            9)
                0pull-request.sh
                read -p "Press [ENTER] to continue." op
                ;;
            c)
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
