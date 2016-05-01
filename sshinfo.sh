#!/bin/sh -e

if [ ! -n $SSH_TTY ]; then
    echo "This script is only useful if you're connected via a Secure SHell"
fi

echo $SSH_CONNECTION | \
    awk '{
        cli_ip=$1;
        cli_port=$2;
        srv_ip=$3;
        srv_port=$4;

        FMT="Client IP:\t%s\nClient Port:\t%s\n" \
        "Server IP:\t%s\nServer Port:\t%s\n"

        printf FMT, cli_ip, cli_port, srv_ip, srv_port;
    }'

