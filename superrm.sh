#!/bin/bash -e
# convenience script to show summary of a directory before prompting to delete it

if [ $1 ]; then
    tree $1 -aC | less --RAW-CONTROL-CHARS --quit-if-one-screen --squeeze-blank-lines --chop-long-lines
    rm -rI $1
else
    echo 'Usage: R <dir>'
fi
