#!/bin/bash
# highlight differences between common files in two given directories

if [ $1 ] && [ $2 ]; then

    cmd="diff --suppress-blank-empty --suppress-common-lines --ignore-all-space"

    if [[ $3 == *"-u"* ]]; then
        cme=" --unified=0"
    fi

      cmf=" $1 $2 | grep -vE '^Only|^---|^\+\+\+|@@\s' |  sed 's/^diff.* /\nFILE: /g'"
      echo Issuing Command: \`$cmd $cme $cmf\'
      eval $cmd $cme $cmf | GREP_COLOR="0;32" egrep --color=always '^<.*|^\+.*|$' \
        | GREP_COLOR="0;31" egrep --color=always '^>.*|^\-.*|$'
else
    echo 'Usage: ./this <dir1> <dir2> [opts]'
    echo ' -u'
    echo '  unified diff, rather than split into columns'
fi

