#!/bin/bash -e

#
# Summary
#   todo.sh - scan files for signs of incomplete work
#
# Usage
#   ./todo.sh [target]
#
# Examples
#   Search file 'foo.txt':
#       ./todo.sh foo.txt
#
#   Search dir 'bar':
#       ./todo.sh bar
#
# Description
#   Look for patterns which match `TODO', `XXX', or `WIP',
#   and display snippets of the lines that contain these
#   patterns.
#
#   If we receive an argument, use that as the target for the
#   search rather than $PWD.
#
#   Once completed scanning all files, display summary (count)
#   of each pattern.
#
#

todo_toks="TODO|XXX|FIXME|WIP"
animal_toks="OINK|MOO+|MEOW|HOOT|WOOF|BARK"

if [ -z $1 ]; then
    SEARCH_TARGET='.'
else
    SEARCH_TARGET="${1}"
fi
echo $SEARCH_TARGET

egrep -Rn "$todo_toks|$animal_toks" \
    --binary-file=without-match     \
    --exclude-dir=.git              \
    --exclude-dir=.npm              \
    --exclude-dir=node_modules      \
    --exclude="*.log"               \
    --exclude="*.csv"               \
    --color=always                  \
    "${SEARCH_TARGET}"              \
    | awk -F':' '
    BEGIN {
        todo = 0;
        xxx  = 0;
        wip  = 0;
        print("===")
    }{
        # Skip this script
        if ($1 ~ /todo\.sh/) {
            next
        }
        if ($3 ~ /TODO/) {
            todo++
            print
        }
        if ($3 ~ /XXX|FIXME/) {
            xxx++
            print
        }
        if ($3 ~ /WIP/) {
            wip++
            print
        }
    } END {
        print("===")
        printf("TODO:%d, XXX:%d, WIP:%d\n", todo, xxx, wip);
    }'

