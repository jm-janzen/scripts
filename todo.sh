#!/bin/bash

# scan files for patterns "XXX, TODO, WIP"

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
    }' \
    | less -R --quit-if-one-screen
