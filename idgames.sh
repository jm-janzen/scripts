#!/bin/bash -e

#
# idgames.sh - simple idgames API ping script
#

base='http://www.doomworld.com/idgames/api/api.php'
json='&out=json'
action='?action='

function ping ()
{
    curl -X GET "${base}${action}ping${json}";
}

case "$1" in
    ping)
        ping
        ;;
    *)
        echo "Command \"${1}\" not recognized"
        exit 1
        ;;
esac

