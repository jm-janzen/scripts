#!/bin/sh -e
# Format output of alias print dump into more readable format

cat ${HOME}/.zshrc | grep -e '^alias' | awk -F'=' 'BEGIN {
        print "ALIAS                         | COMMAND";
        print "---------------------------------------";
    }
    {
        # TODO
        #   Specify length for both columns ($1, $2)
        #

        baselen  = 10;
        fieldlen = length($1);
        tablen   = baselen - fieldlen;

        printf " " $1

        for (i = 0; i < tablen; i++)
            printf " "

        printf "     |     " \
            "\t" $2 \
            "\n"
    }
    END {
        print "---------------------------------------";
    }'
