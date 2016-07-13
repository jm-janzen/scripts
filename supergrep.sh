#!/bin/bash -e

#
# Summary
#   supergrep.sh - Convenience script to grep a particular dir for a particular pattern.
#
# Usage
#   ./supergrep.sh <dir> <pattern> [-a] [-u]
#
# Description
#   Excluding build directories, or Makefiles (unless `-a' flag set), recursive search
#   for and print matching pattern to the standard out.
#

if [ $1 ] && [ $2 ]; then
  cd $1
  if [[ $3 == *"-a"* ]]; then
    grep -rn -E -o ".{0,100}$2.{0,50}" * --binary-file=without-match | grep "/b/\|^b/\|Makefile....\|$" --color

  elif [[ $3 == *"-u"* ]]; then
    grep -rn -E -o ".{0,80}$2.{0,80}" * --binary-file=without-match | sed -e "s/[aeio]/u/g" #lol

  else
    grep -rn -E -o ".{0,80}$2.{0,80}" * --binary-file=without-match --exclude-dir=b --exclude=Makefile.{am,in}
  fi
else
  echo 'Usage: ./this <dir> <pattern>'
  echo ' -a'
  echo '  show Makefile*, /b/ matches as well'
  echo ' -u'
  echo '  lul'
fi

