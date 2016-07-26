#!/usr/bin/env bash

#
# Summary
#   preview-sed.sh - preview resursive sed changes before committing them
#
# Usage
#   ./preview-sed.sh [dir]
#
# Description
#   Creates a back up of the specified directory before performing any
#   operations.  If a same-named backup directory already exists, then
#   the user is prompted to either delete the backup, or quit the script.
#
# TODO
#   1[_]    Take sed /p1/p2/g (original/new patterns)
#   2[_]    Perform sed op on backup dir
#   3[_]    Show diff of backup and original dirs
#   4[_]    Prompt to overwrite original with backup
#

backup_dir="${HOME}/.preview-sed.sh.dir/" || exit 1
backup_files="${backup_dir}${1}"

aargs=($*)

function usage {
    echo $1
    cat << EOF
    Usage: ./preview-sed.sh -[h] <dir> <pattern> <replace>
EOF
    exit 1
}

# TODO check for invalid args and quit
function parse_args {
    # check for help flag
    for i in "${!aargs[@]}"; do
        if [[ ${aargs[i]} == '-h' ]]; then
            usage 'Help.'
        fi
    done

    # check args len
    if [[ $# -lt 3 ]]; then
        usage 'Insufficient arguments.'
    fi
}

function backup_files {

    if [[ -d $1 ]]; then
        if [[ -d "${backup_files}" ]]; then
            pass=0;

            while
                printf "Delete backup \`${backup_files}' [yn]? "
                read answer

                case "$answer" in
                    y)
                        pass=1
                        rm -r "${backup_files}" ;;
                    n|*)
                        exit 0
                        ;;
                esac

                (( $pass == 0 ))
            do
                continue

            done

        fi
        printf "Making a backup of $1 ... "
        mkdir -p $backup_dir
        cp -a $1 "${backup_dir}/${1}"
        printf "Success.\n"
    else
        echo "First arg needs to be a directory"
    fi
}

###
### main
###

parse_args $*
backup_files $*

exit 0
