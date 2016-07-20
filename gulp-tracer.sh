#!/usr/bin/env bash

# Usage: ./gulp-tracer.sh [name]

proc='gulp'

if [[ $UID != 0 ]]; then
    echo 'Script must be run as root (sudo)'
    exit 1
elif [[ $1 ]]; then
    proc=$1
else
    strace -tp "$(pgrep -l gulp | awk '{ print $1}')" -etrace=stat -esignal=none
fi
