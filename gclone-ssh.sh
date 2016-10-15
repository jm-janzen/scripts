#!/bin/sh

owner="jm-janzen"

if [ -z $1 ]; then
    echo "Usage: \`./gclone-ssh.sh <repo-name>'"
else
    echo "Attempting clone ${owner}'s repository \`${1}'"
    git clone -v --progress git@github.com:${owner}/${1}.git
fi
