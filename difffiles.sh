#!/bin/bash -e

#
# Summary
#   difffiles.sh - highlight differences between common files in two given directories.
#
# Usage
#   ./difffiles.sh dir_a/ dir_b/
#
# Description
#   If `-n' or `--normal' specified in opts, will show normal diff format, otherwise
#   use unified (or git style) diff output.  In either case, colour the output red
#   and green, for additions and deletions, respectively.
#

if [[ $1 == *"-h"* ]]; then
    echo 'Usage: ./this <dir1> <dir2> [opts]'
    echo ' -u'
    echo '  unified diff, rather than split into columns'
    echo ' -h'
    echo '  display this usage text'
    exit 0
elif [ -z $1 ] || [ -z $2 ]; then
    here=${HOME}
    there=${HOME}/env
else
    here=$1
    there=$2
fi

cmd="diff --suppress-blank-empty --suppress-common-lines --ignore-all-space"

# if normal format specified, use it, else use git-style unified format
if [[ $@ == *"-n"* ]] || [[ $@ == *"--normal"* ]]; then
    cme=" --normal"
else
    cme=" --unified=0"
fi

# finally:

cmf=" $here $there | grep -vE '^Only|^---|^\+\+\+|@@\s' |  sed 's/^diff.* /\nFILE: /g'"
echo Issuing Command: \`$cmd $cme $cmf\'
eval $cmd $cme $cmf | GREP_COLOR="0;32" egrep --color=always '^<.*|^\+.*|$' \
  | GREP_COLOR="0;31" egrep --color=always '^>.*|^\-.*|$'

