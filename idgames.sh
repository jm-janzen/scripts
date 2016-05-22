#!/bin/bash -e

#
# idgames.sh - simple idgames API ping script
#
# Usage
#   ./idgames.sh [db]ping
#

base='http://www.doomworld.com/idgames/api/api.php'
json='&out=json'
action='?action='

function ping ()
{
    uri="${base}${action}${1}${json}";
    echo "Accessing $uri";
    curl -X GET $uri;
}

function getid ()
{
    action="${action}get"
    uri="${base}${action}&id=${1}${json}";
    echo "Accessing $uri";
    curl -X GET $uri;
}

case "$1" in
    ping|dbping)
        ping $1
        ;;
    id)
        getid $2
        ;;
    *)
        echo "Command \"${1}\" not recognized"
        exit 1
        ;;
esac

