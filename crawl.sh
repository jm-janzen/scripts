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

if [[ -f $1 ]]; then
    log_file=$1
else
    # If multiple log files, just use first found
    log_file=`find . -iname '*.log' -print -quit`
fi

if [[ $@ != *"-A"* ]]; then
    conn_ip=$(echo $SSH_CLIENT | awk '{ print $1 }')
else
    conn_ip='//'
fi

printf "\n==> Following log file %s, ignoring %s <==\n\n" $log_file $conn_ip

tail -f ${log_file} | grep -v ${conn_ip}
