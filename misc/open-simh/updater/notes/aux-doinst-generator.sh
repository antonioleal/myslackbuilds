
FILES="/opt/open-simh/bin/*"
for f in $FILES
do
    # echo "Processing $f file..."
    # take action on each file. $f store current file name
    #cat "$f"

    if [ "`basename $f`" != "buildtools" ]; then
        echo "( cd \$PKG/usr/bin ; rm -rf open-simh-`basename $f` )"
        echo "( cd \$PKG/usr/bin ; ln -sf ../..$f open-simh-`basename $f` )"
        #echo
    fi

done

