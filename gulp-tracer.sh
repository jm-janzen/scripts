#!/usr/bin/env bash

# Usage: ./gulp-tracer.sh [name]

function traceProc {
    echo "Running strace for $1"
    strace -tp "$(pgrep -l $(echo "$1") | awk '{ print $1}')" -etrace=stat -esignal=none
}

if [[ $UID != 0 ]]; then
    echo 'Script must be run as root (sudo)'
    exit 1
elif [[ $1 ]]; then
    traceProc $1
else
    traceProc 'gulp'
fi

