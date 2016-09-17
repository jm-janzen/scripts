#!/bin/bash

# TODO accept arguments for verbosity, splitting files among dirs and not

# tokens to match (last char)
dir_count=0
file_count=0

for f in $(\ls -F); do

    file_type="${f: -1}"

    if [[ $file_type == '/' ]]; then
        (( dir_count++ ))
    else
        (( file_count++ ))
    fi

done

echo "dirs: ${dir_count}, files: ${file_count}."

