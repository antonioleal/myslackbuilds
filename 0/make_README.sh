#!/bin/bash

#SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#cd $SCRIPT_DIR
cd ~/slackware-builds/myslackbuilds
README=README.md

rm -rf $README

echo -e "*This repo contains my slackbuild scripts, some of which also published to SlackBuilds.org*\n" >> $README
#echo -e "------------------------------------------------------------------------------------------\n" >> $README
echo -e "---\n" >> $README
echo -e "  \n" >> $README

for fich in `find . -name "*-desc" -print`;
do
    DIR="$(dirname "${fich}")"
    echo $DIR

    CATEGORY=`echo $fich | cut -d "/" -f 2`
    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | head -n2`
    echo "##$AUX  [$CATEGORY]" >> $README
    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | tail -n10 | grep -v '^[[:space:]]*$'`
    echo "$AUX" >> $README
    echo -e "  \n" >> $README

    VERSION=`cat $DIR/*.info | grep "VERSION" | cut -d "=" -f 2-10`
    VERSION="${VERSION%\"}"
    VERSION="${VERSION#\"}"
    echo "*Version $VERSION*" >> $README
    echo -e "  \n" >> $README
done
