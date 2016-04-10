#!/bin/sh -e
# Format output of printenv for legibility

# BUG:  Values that contain the delimeter `=' are cut off prematurely.

printenv | awk -F'=' 'BEGIN {
    print "VARIABLE                      | VALUE";
    print "------------------------------------";
}
{
# setup std column 30 chars wide
    baselen  = 30;
    fieldlen = length($1);
    tablen   = baselen - fieldlen;

    printf $1

    for (i = 0; i < tablen; i++)
        printf " "

    printf "| " $2 "\n"
}
END {
    print "------------------------------------";
}'
