#!/bin/bash -e

#
# Summary
#   crawl.sh - log file follower, filterer.
#
# Usage
#   ./crawl.sh [file]
#
# Description
#   Follow updates on a connection-type log file,
#   ignoring connections from the same IP address
#   that started this script.
#

# If `-A' flag set, use
# this invalid match.
function all {
    conn_ip='//'
}

# Check for `-I' flag, and
# presense of associated value.
function ignore {
    if [[ $1 ]]; then
        conn_ip=$1
    else
        conn_ip=$(echo $SSH_CLIENT | awk '{ print $1 }')
    fi
}

function findLogFile {
    if [[ -f $1 ]]; then
        log_file=$1
    else
        # If multiple log files, just use first found
        log_file=`find . -iname '*.log' -print -quit`

        if [[ $log_file == '' ]]; then
            echo 'No file matching *.log found, exiting'
            exit 0
        fi
    fi
}

# Print information on how
# to use this script.
function usage {
    echo $1
    cat << EOF
Usage: crawl.sh [OPTION] [FILE]

    [OPTION]:
        -A
            Show all.
        -I <pattern>
            Ignore specified pattern.
            To ignore multiple patterns use 'pat1\\|pat2'
        -h  Display this Usage Help.

    [FILE]:
        Follow file matching the pattern \`*.log'. If unspecified,
        crawl.sh will use the first file it finds matching this pattern.
EOF
    exit 1
}

# Check for number of
# parameters, and route.
if [[ $# -eq 0 ]]; then                             # No parms:  Find *.log, ignore connecting IP
    findLogFile
    ignore
elif [[ $# -eq 1 ]]; then                           # One parm:

    if [[ $1 =~ "-h" ]]; then                       #   Display Usage Help
        usage 'Help'
    elif [[ $1 == *"-A"* ]]; then                   #   Don't ignore connecting IP
        findLogFile
        all $1
    elif [[ $1 == *".log" ]]; then                  #   Follow specific .log file
        findLogFile $1
        ignore
    fi
elif [[ $# -ge 2 ]] &&                              # Two parms: Ignore specific pattern
  [[ $1 == *"-I"* ]]; then
    if [[ $# -eq 3 ]]; then                         # Three parms: Ignore specific pattern of specific file
        findLogFile $3
    else
        findLogFile
    fi
    ignore $2
else
    usage 'Invalid arguments'
fi

printf "\n==> Following log file %s, ignoring %s <==\n\n" $log_file $conn_ip

tail -f ${log_file} | grep -v ${conn_ip}
