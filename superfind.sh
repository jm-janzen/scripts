#!/bin/bash
# convenience script for GNU find package

if [ $1 ]; then
  find $1 -iname $2 -printf '%p\n'
else
  echo 'Usage: ./this <dir> <filename>'
fi
