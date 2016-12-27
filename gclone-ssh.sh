#!/bin/sh

#
# Summary
#   gclone-ssh.sh - Convenience script to quickly clone my own repositories
#
# Usage
#   ./gclone-ssh.sh
#
# Description
#   Using the magic String of `owner,' clone the given repository by name,
#   from github.com.  Relies on git being properly configured for this owner.
#


owner="jm-janzen"

if [ -z $1 ]; then
    echo "Usage: \`./gclone-ssh.sh <repo-name>'"
else
    echo "Attempting clone ${owner}'s repository \`${1}'"
    git clone -v --progress git@github.com:${owner}/${1}.git
fi
