#!/bin/bash
# highlight differences between common files in two given directories

if [ $1 ] && [ $2 ]; then

    cmd="diff --suppress-blank-empty --suppress-common-lines --ignore-all-space"

    if [[ $3 == *"-u"* ]]; then
        cme=" --unified=0"
    fi

      cmf=" $1 $2 | grep -vE '^Only|^---|^\+\+\+|@@\s' |  sed 's/^diff.* /\nFILE: /g'"
      echo Issuing Command: \`$cmd $cme $cmf\'
      eval $cmd $cme $cmf
else
    echo 'Usage: ./this <dir1> <dir2>'
fi

