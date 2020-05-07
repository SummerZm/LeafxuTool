#!/bin/sh
## A little script to wrap DiffMerge (sgdm.exe) to make
## it easier to invoke from a Cygwin process. For example
## when trying to use DiffMerge as an external difftool
## from "Git for Cyginw".
##
## The arguments for this script deviate from the normal
## DiffMerge.exe usage.  Instead of having 2 or 3 unbound
## pathname args somewhere on the line (mixed in with the
## bound -options and/or /options), I'm going to let them
## take 2 or 3 options of the form:
##
##       -p1=pathname
##    or /p1=pathname
##
## with values /p1 (aka /path1, -p1, -path1, and --path1)
##             /p2 (...)
##             /p3 (...)
##
## It is assumed that the "pathname" will be a cygwin-style
## pathname.
##
## When using this script you should use the "/option=value"
## or "-option=value" form, rather than the "-option value"
## form ***FOR ALL OPTIONS*** (since this script doesn't
## know which options take values and which don't).
##
## See the section on "GIT for Cygwin" in the manual for
## an example.
##
## Version 4.2.0.697 stable
## Copyright (C) 2003-2013 SourceGear LLC. All Rights Reserved.
##############################################################################

## set -x
## set -v
##
## NOTE: The path to the DiffMerge executable is set here to
##       the default install path when the .MSI installer is
##       used.  If you are using the .ZIP package, update this
##       accordingly.

DIFFMERGE_PATH="C:/Program Files/SourceGear/Common/DiffMerge/sgdm.exe";

shopt -s nocasematch

declare -a values;
declare -a pathnames;

for arg in "$@" ;
do
    if [[ $arg =~ (/p|/path|-p|-path|--path)([123])=(.*) ]];
    then
	k=${BASH_REMATCH[2]}
	x=${BASH_REMATCH[3]}
	y=`cygpath -w -a "$x"`
	## echo Path "$k": "$x" becomes "$y"
	pathnames[$k]="$y"
    elif [[ $arg =~ (/r|/result|-r|-result|--result)=(.*) ]];
    then
	x=${BASH_REMATCH[2]}
	y=`cygpath -w -a "$x"`
	## echo Result Path "$x" becomes "$y"
	values=("${values[@]}" "--result=$y")
    elif [[ $arg =~ [-/].* ]]
    then
	values=("${values[@]}" "$arg")
    else
	## I'm not going to support mixing unbound arguments
	## and -p options because it has the potential to 
	## make the command line ambigouous.
	## Odds are if a script or another command (like GIT
	## for Cygwin) is driving this script and we're getting
	## mixed args, there's probably a quoting problem or
	## they are using something like /title MyTitle rather
	## than /title=MyTitle
	echo Unbound arguments should not be used with this script: "$arg"
	exit 2
    fi
done

if [[ ${#pathnames[1]} -gt 0 ]];
then
    values=("${values[@]}" "${pathnames[1]}")
fi

if [[ ${#pathnames[2]} -gt 0 ]];
then
    if [[ ${#pathnames[1]} -eq 0 ]];
    then
	echo Error /p2 without /p1
	exit 2
    fi
    values=("${values[@]}" "${pathnames[2]}")
fi

if [[ ${#pathnames[3]} -gt 0 ]];
then
    if [[ ${#pathnames[2]} -eq 0 ]];
    then
	echo Error /p3 without /p2
	exit 2
    fi
    values=("${values[@]}" "${pathnames[3]}")
fi

## echo "${DIFFMERGE_PATH}" "${values[@]}"
exec "${DIFFMERGE_PATH}" "${values[@]}"
