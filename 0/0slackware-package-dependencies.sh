#!/bin/bash

# This script searches the slackare dependencies of an executable
# it uses the script 'whichpkg' available at
# http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

msg="Slackware package dependencies of executable $1"
base="slackware_package_dependencies"
fich="$base.txt"
aux="$base.aux"
rm -rf $fich

clear
echo $msg

#get all the ELF dependencies
for lib in `readelf -d $1 | grep "NEEDED" | awk '{ print substr($5,2,length($5)-2) }'`
do
	echo $lib >> $fich
done
#remove repetitions
awk '!seen[$0]++' $fich > $aux

echo "*******************************************************************************************************************"
echo "these are library dependencies:"
cat $aux
echo

echo "*******************************************************************************************************************"
echo "now finding their packages:"
echo "$msg" > $fich
#print the version on the screen
IFS=$'\n' # set the Internal Field Separator to newline
for lib in $(cat "$aux")
do
        pkg="`0whichpkg.sh $lib`"
        echo "$pkg"
        echo "$pkg" >> $fich
done

rm $aux
echo "*******************************************************************************************************************"
echo "Done."
