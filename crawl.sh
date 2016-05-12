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
    exit
}

# Check for number of
# parameters, and route.
if [[ $# -eq 0 ]]; then                             # No parms:  Find *.log, ignore connecting IP
    findLogFile
    ignore
elif [[ $# -eq 1 ]] && [[ $1 == *"-A"* ]]; then     # One parm:  Find *.log, display connecting IP
    findLogFile
    all $1
elif [[ $# -eq 1 ]] && [[ $1 == *".log" ]]; then    # One parm:  Follow specific .log file
    findLogFile $1
    ignore
elif [[ $# -eq 2 ]] &&                              # Two parms: Ignore specific pattern
  [[ $1 == *"-I"* ]]; then
    echo "ignoring $2" #XXX
    ignore $2
    findLogFile
else
    usage 'Invalid arguments'
fi

printf "\n==> Following log file %s, ignoring %s <==\n\n" $log_file $conn_ip

tail -f ${log_file} | grep -v ${conn_ip}
