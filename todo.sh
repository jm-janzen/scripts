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

todo_toks="TODO|XXX|FIXME|WIP"
animal_toks="OINK|MOO+|MEOW|HOOT|WOOF|BARK"

# If we receive a parameter, search for that instead
if [ $1 ]; then
    animal_toks=""
    todo_toks=$1
fi

egrep -Rn "$todo_toks|$animal_toks" \
    --binary-file=without-match     \
    --exclude-dir=.git              \
    --exclude-dir=.npm              \
    --exclude-dir=node_modules      \
    --exclude="*.log"               \
    --exclude="*.csv"               \
    --color=always                  \
    .                               \
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

