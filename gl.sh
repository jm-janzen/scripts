#!/bin/bash -e
### summarize a particular user's contributions to a repository.
if [ $1 ]; then
    git log --shortstat --author "$1" | grep "files\? changed" | awk '{f+=$1; i+=$4; d+=$6} END {print "files:", f, "green:", i, "red", d}'
else
    echo "Usage: ./this username"
    exit
fi
