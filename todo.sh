#!/bin/bash

# scan files for patterns "XXX, TODO, WIP"

egrep -R --binary-file=without-match \
    --exclude-dir=.git $1 \
    --exclude-dir=.npm \
    --exclude-dir=node_modules \
    | awk '/TODO|XXX|WIP/{
        print $0
    }'
