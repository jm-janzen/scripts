#!/bin/sh -e
# highlight differences between common files in two given directories

if [ $1 ] && [ $2 ]; then
    diff --suppress-blank-empty \
      --suppress-common-lines   \
      --ignore-all-space        \
      $1 $2 | grep -v Only | grep -E '^[diff].+|$' --color
else
    echo 'Usage: ./this <dir1> <dir2>'
fi

