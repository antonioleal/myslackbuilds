#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR
README=README.md

rm -rf $README
for fich in `find . -name "*-desc" -print`;
do
    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | head -n2`
    echo "##$AUX" >> $README
    echo >> $README
    AUX=`cat $fich | grep "^[a-zA-Z0-9].*:.*" | cut -d ":" -f 2-10 | tail -n10 | grep -v '^[[:space:]]*$'`
    echo "$AUX" >> $README
    echo -e "  \n" >> $README
done

