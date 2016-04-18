#!/bin/bash

# scan files for patterns "XXX, TODO, WIP"

egrep -Rn --binary-file=without-match \
    --exclude-dir=.git $1 \
    --exclude-dir=.npm \
    --exclude-dir=node_modules \
    | awk -F':' '
    BEGIN {
        todo = 0;
        xxx  = 0;
        wip  = 0;
    }/TODO/{
        todo++
        print $0
    }/XXX/{
        xxx++
        print $0
    }/WIP/{
        wip++
        print $0
    } END {
        printf("TODO:%d, XXX:%d, WIP:%d\n", todo, xxx, wip);
    }' \
    | less -R --quit-if-one-screen
