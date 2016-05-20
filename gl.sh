#!/bin/bash -e

#
# Summary
#   gl.sh - summarize a particular user's contributions to a repository.
#
# Usage
#   ./gl.sh [user-name]
#
# Description
#   Skims the output of an abbreviated git log for contributions by the provided
#   user's name, then sums the numbers associated with three metrics:
#       1) File(s) changed
#       2) Line insertions
#       3) Lines deletions
#   Which are finally summarised respectively as `files', `green', and `red'.
#

if [ $1 ]; then
    git log --shortstat --author "$1" | grep "files\? changed" | awk '{f+=$1; i+=$4; d+=$6} END {print "files:", f, "green:", i, "red", d}'
else
    echo "Usage: ./this username"
    exit
fi
