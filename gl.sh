#!/bin/bash -e

### TODO if no user specified, just list all users' contributions
### TODO list contributions by all users when none specified explicitly

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
    user=$1;
    git log --shortstat --author "$user" | grep "files\? changed" | awk '{f+=$1; i+=$4; d+=$6} END {print "files:", f, "green:", i, "red", d}'
else
    total=`git log --shortstat | awk '/Author: / { print; }' | wc -l` # total number of contributions by all users
    #authors=`git log --shortstat | awk '/Author: / { print; }' | uniq -c | grep -oP '(Author: ).*'` # list of unique authors
    authors=`git log --shortstat | awk '/Author: / { print; }' | uniq | sed -n -e 's/Author:\s//p'`

    for a in $authors; do
        if [[ $a =~ "<" ]]; then
            echo OINK
        else
            echo $a
        fi
    done
fi

echo $total $users

