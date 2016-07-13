#!/bin/bash -e

#
# Summary
#   superrm.sh - Show summary of a directory before prompting to delete it.
#
# Usage
#   ./superrm.sh <dir>
#
# Description
#   Show a GNU tree summary of a directory and its contents before prompting
#   invoking user to to recursively delete its contents.
#

if [ $1 ]; then
    tree $1 -aC | less --RAW-CONTROL-CHARS --quit-if-one-screen --squeeze-blank-lines --chop-long-lines
    rm -rI $1
else
    echo 'Usage: R <dir>'
fi

