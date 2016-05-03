#!/bin/sh -e

#
# Summary
#   sshinfo.sh - $SSH_CONNECTION environment variable formatter
#
# Usage
#   ./sshinfo.sh
#
# Description
#   Check if $SSH_TTY is set, and unconditionally label and print
#   IP address and port number information related to a Secure SHell
#   session, regardless of status.
#

if [ -n $SSH_TTY ]; then
    echo "This script is only useful if you're connected via a Secure SHell"
fi

echo $SSH_CONNECTION | \
    awk '{
        # Collect space-delimited values
        cli_ip      =   $1;
        cli_port    =   $2;
        srv_ip      =   $3;
        srv_port    =   $4;

        # Prepare String format for output
        FMT="Client IP:\t%s\nClient Port:\t%s\n" \
        "Server IP:\t%s\nServer Port:\t%s\n"

        printf FMT, cli_ip, cli_port, srv_ip, srv_port;
    }'

