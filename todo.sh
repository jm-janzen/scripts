#!/bin/bash -e

#
# Summary
#   todo.sh - scan files for signs of incomplete work
#
# Description
#   Look for patterns which match `TODO', `XXX', or `WIP',
#   and display snippets of the lines that contain these
#   patterns.
#   Once completed scanning all files, display summary (count)
#   of each pattern.
#
# Usage
#   ./todo.sh
#

egrep -Rn --binary-file=without-match \
    --exclude-dir=.git . \
    --exclude-dir=.npm \
    --exclude-dir=node_modules \
    | awk -F':' '
    BEGIN {
        todo = 0;
        xxx  = 0;
        wip  = 0;
    }{
        if ($3 ~ /TODO/) {
            todo++
            print $1 ":" $3
        }
        if ($3 ~ /XXX/) {
            xxx++
            print $1 ":" $3
        }
        if ($3 ~ /WIP/) {
            wip++
            print $1 ":" $3
        }
    } END {
        printf("TODO:%d, XXX:%d, WIP:%d\n", todo, xxx, wip);
    }'

