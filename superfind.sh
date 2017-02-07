#!/bin/bash -e
#
# Summary
#   superfind.sh - convenience script for GNU find package
#
# Usage
#   ./superfind.sh [dir] <filename>
#

if [ $# -gt 1 ]; then
  find $1 -iname \*$2\* -printf '%p\n'
elif [[ $# -gt 0 ]]; then
  find . -iname \*$1\* -printf '%p\n'
else
  echo 'Usage: ./superfind.sh [dir] <filename>'
fi

