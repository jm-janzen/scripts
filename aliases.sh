#!/bin/sh -e
# Format output of alias print dump into more readable format

alias | awk -F'=' 'BEGIN {
        print "ALIAS                         | COMMAND";
        print "---------------------------------------";
    }
    {
        baselen  = 10;
        fieldlen = length($1);
        tablen   = baselen - fieldlen;

        printf " " $1

        for (i = 0; i < tablen; i++)
            printf " "

        printf "| " $s "\n"
    }
    END {
        print "---------------------------------------";
    }'
