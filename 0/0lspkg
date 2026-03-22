#!/bin/sh
#*******************************************************************************
# Name: lspkg
# 
# A Slackware tool which simply lists the currently installed packages.
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

case $1 in
  -h | --help )  # If -h (--help) is given as an argument, show the usage.
    cat << __EOF__

Usage: lspkg [<package_name> ... ]

Lists the Slackware packages currently installed. If no argument is
given, it will output all packages currently installed. If an argument
is given on the command line, it will look for the package name matching
the pattern(s) supplied. More than one package name or pattern may be
given on the command line.

Use the wildcards * and ? when looking for a package name containing the
characters supplied on the command line. For example, to find a package
containing the word "lib", but does not necessarily begin with "lib",
use one of the patterns "*lib", "?lib", "??lib" or even "??lib*". To see
if you have both "bzip" and "bzip2" installed on your system, you can
use the search term "bzip?".  You may also enclose the search pattern in
single quotes (') or double quotes (") to avoid the shell interpeter from
interfering with the search term when using the wildcard characters.

__EOF__
    ;;
  * )
    [ -z $1 ] && 'ls' /var/log/packages/ | less \
    || {
      while [ ! -z $1 ]
      do
        pkg=`echo $1 | sed 's/\./\\./g; s/\*/.*/; s/\?/.?/g'`
        'ls' /var/log/packages/ | egrep -i "^$pkg\>"
        shift
      done | more
    }
esac

