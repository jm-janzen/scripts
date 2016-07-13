#!/bin/bash -e
#
# Summary
#   superfind.sh - convenience script for GNU find package
#
# Usage
#   ./superfind.sh <dir> <filename>
#

if [ $1 ]; then
  find $1 -iname $2 -printf '%p\n'
else
  echo 'Usage: ./this <dir> <filename>'
fi

