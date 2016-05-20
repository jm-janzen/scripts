#!/bin/bash -e

#
# Summary
#   ipinfo.sh - simple query to API for info on an IP address.
#
# Usage
#   ./ipinfo.sh [address]
#
# Description
#   Returns info on hostname, city, region, country, lat-long coordinates,
#   organization, and mail code, all in JSON format.  If an IP address is
#   not specified, the API returns information on the address making the
#   request (and this script prints it dutifully).
#

eval curl ipinfo.io/"${1}"/json

echo # push \n

