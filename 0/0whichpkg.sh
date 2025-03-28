#!/bin/sh
#*******************************************************************************
# Name: whichpkg
# 
# A Slackware tool to find which package a file comes from.
#
# Originally written by CTWaley (a.k.a., thegeekster) and originally posted in
# the Slackware forum at LinuxQuestions.org,
# <http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459>
# 
# This program is given to the Public Domain and is free software. You can
# redistribute it and/or modify it without restriction of any kind.
# 
# It distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.
#*******************************************************************************

search_pkgs() {
  name1="/${1}\>"

  find /var/log/packages/* -type f -prune | while read file
  do
    # This makes certain assumptions about where to look, such as
    # ignoring certain directories and files which are easy to figure
    # out where the files came from:
    cat $file | egrep -A5000 'FILE\ LIST:' | egrep -i "${name1}\$"\
      | egrep -v '(FILE\ LIST:|^\./$|\<install/|\<install-sh|\<install\.sh)' \
      | egrep -v '(usr/src/linux|doc/|share/$1)' \
      | while read line
    do
      [ ! -d $file ] && echo "`basename $file`:/$line"
    done
  done

  # Due to a problem of a broken pipe when trying to find any symlinks
  # associated with the file "ln", I had to find a workaround.
  name2="\<${1}\>"
  [ "$1" = "ln" ] && name2="\<ln\>\ [^-rf]"
  [ "$1" = "rm" ] && name2="\<rm\>\ [^-rf]"

  find /var/log/scripts/* -type f -prune | while read file
  do
    cat $file | egrep -i "$name2" \
      | egrep -v '(^#|:| \<rm\ -r\>|\<if\ |\<else\ |>>|\$|\<for\ .*\ in\>|doinst\.sh)' \
      | while read line
    do
      [ ! -z "`echo $line | egrep '\<ln\ -sf' |egrep '\(\ cd'`" ] \
        && echo "`basename $file`:/`echo $line \
        | awk '{ print $3\"/\"$8\"  --linked-to->  \"$7 }'`"
      [ ! -z "`echo $line | egrep '\<mv\ '`" ] \
        && echo "`basename $file`:/`echo $line | sed 's/^.*\(\<mv\ \)/\1/' \
        | awk '{ print $2\"  --renamed-to->  \"$3 }'`"
    done
  done
}

case $1 in
  "" | -h | --help )  # If no argument is given, or -h (--help) is given,
                      # as an argument then show the usage.
    cat << "__EOF__"  | less

Usage: whichpkg FILE1 [ FILE2 ... ]

Finds which Slackware package contains the file supplied on the command
line. A filename must be supplied and more than one filenam may be used
on the command line. For pattern matching, you may use the wildcards *
and ?. For example, to find the files "bzip" and "bzip2", you may use
the pattern "bzip?" to look for both files. The search is case
insensitive (upper- or lowercase is okay). You may also enclose the
search pattern in single quotes (') or double quotes (") to avoid the
shell interpeter from interfering with the search term when using the
wildcard characters.

The output was made to be as easy as possible to read and the output
for each search term is easily identifiable. Each matching line will
look something link this:

    <package_name>:<matched_path>

For symlink matches, the output will look something like this:

    <package_name>:<matched_symlink>  -- linked to->  <real_file>

If a file was renamed when installed, the output will look something
like this:

    <package_name>:<old_filename>  -- renamed to->  <new_filename>

To give you an idea, here's a sample output for the search for the
multiple terms "sh" and "bash":

$ whichpkg sh bash
------------------------------------------------------------------------
Searching for "sh"...

aaa_base-9.1.0-noarch-1:/bin/sh  --linked to->  bash

------------------------------------------------------------------------
------------------------------------------------------------------------
Searching for "bash"...

aaa_base-9.1.0-noarch-1:/bin/sh  --linked to->  bash
bash-2.05b-i486-3:/bin/bash  --renamed to->  bin/bash.old
bash-2.05b-i486-3:/bin/bash2.new  --renamed to->  bin/bash
bash-2.05b-i486-3:/usr/bin/bash  --linked to->  /bin/bash

------------------------------------------------------------------------


NOTE: The searches will take a couple of moments for each term being
      searched and some searches may take longer than others, depending
      on the keyword used. Usually it depends on how many occurrences of
      the keyword is found, which then must be analyzed and filtered.

__EOF__
    ;;
  * )
    while [ ! -z "$1" ]
    do
      i="`basename \`echo \"$1\" | sed 's/\./\\./g; s/\*/.*/; s/\?/.?/g'\``"
      echo "------------------------------------------------------------------------"
      echo -e "Searching for \"${1}\"...\n"
      search_pkgs "$i" | sort
      echo -e "\n------------------------------------------------------------------------"
      shift
      done	;;
esac
