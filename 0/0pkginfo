#!/bin/sh
#*******************************************************************************
# Name: pkginfo
# 
# A Slackware tool to find the inforamtion about any installed package.
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

count_args() {
  args=$#
}

present_list() {
  cat << __EOF1__ | more

-------------------------------------------------------------------------------
 More than one package was found matching the name, "$ARG".
 Choose a package from the following list (Hint: Use the mouse to copy-n-paste
 the desired package name)...
-------------------------------------------------------------------------------

`echo "$PKGS" | egrep -i "\<$1\>" | while read i ; do basename $i ; done`

-------------------------------------------------------------------------------
__EOF1__

  echo -n " Enter package name here: " ; read pkg
  count_args `echo "$PKGS" | egrep -i "\<$pkg\>"`
  { [ $args -gt 1 ] && present_list $pkg
  } || {
    [ $args -lt 1 ] \
      && echo "No package was found matching the name, \"${pkg}\"." \
      && exit 1
  }
}

view_info() {
  cat << __EOF2__ | less
`cat \`echo "$PKGS" | egrep -i "\<$1\>"\``

`echo "INSTALLATION SCRIPT:"`
`cat \`echo "$SCRIPTS" | egrep -i "\<$1\>"\``
__EOF2__
}

case $1 in
  # If no argument or -h (--help) is given as an argument, show the help message.
  "" | "-h" | "--help" )
    cat << "__EOF3__"

Usage: pkginfo <package_name>

Lists the contents of the requested package. You can give any part of
the package name (such as bash, bash-2.05b, 2.05b, bash-2.05b-i486,
etc.). The search is case insensitive (upper- or lowercase is okay).
You may use the wildcards "*" or "?" for pattern matching. If more
than one match is found, you will be presented with a list of package
names to choose from (like when searching for the package xfree86).

TIP: If you know the first few letters of the package you are looking
     for, add the asterisk (*) at the end of the search term, such as
     "lib*". Or to find packages which end with the search term entered
     on the command line, add the "*" wildcard in front of the term
     (ie., "*lib"). You will then be presented with a list of package
     names to choose from. You may also enclose the search pattern in
     single quotes (' ') or double quotes (" ") to avoid the shell
     interpeter from interfering with the search term while using the
     wildcard characters.

__EOF3__
    ;;
  * )
    count=0
    ARG="$1"
    F="`echo \"$1\" | sed 's/\./\\./g; s/\*/.*/; s/\?/.?/g'`"
    PKGS=`find /var/log/packages/* -type f -prune`
    SCRIPTS=`find /var/log/scripts/* -type f -prune`
    count_args `echo "$PKGS" | egrep -i "\<$F\>"`
    case $args in
      0 )
        echo "No package was found matching the name, \"$ARG\"."	;;
      1 )
        [ -z `echo "$SCRIPTS" | egrep -i "\<$F"` ] \
          && cat "`echo \"$PKGS\" | egrep -i \"\<$F\"`" | less \
          || view_info "$F"
        ;;
      * )
        present_list $F
        [ -z `echo "$SCRIPTS" | egrep -i "\<$pkg\>"` ] \
          && cat "`echo \"$PKGS\" | egrep -i \"\<$pkg\>\"`" | less \
          || view_info "$pkg"
        ;;
    esac
esac
