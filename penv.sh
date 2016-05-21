#!/bin/sh -e

#
# Summary
#   penv.sh - format output of core utility printenv for legibility.
#
# Usage
#   ./penv.sh
#
# BUGS
#   *   Values that contain the delimeter `=' are cut off prematurely.
#   *   LS_COLORS variable is very long in some environments (eg. when
#       using GNU screen).
#

printenv | gawk -F'=' 'BEGIN {
    print "VARIABLE                      | VALUE";
    print "------------------------------------";
}
{
# setup std column 30 chars wide
    baselen  = 30;
    fieldlen = length($1);
    tablen   = baselen - fieldlen;

    if (NR % 2)
        printf "\033[1;32m " $1
    else
        printf " " $1

    for (i = 0; i < tablen; i++)
        printf " "

    if (NR % 2)
        printf "| " $2 "\033[0m\n"
    else
        printf "| " $s "\n"
}
END {
    print "------------------------------------";
}'
