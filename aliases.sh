#!/bin/sh -e
# Format output of alias print dump into more readable format

awk -F= 'BEGIN {
        print "ALIAS                  | COMMAND";
        print "--------------------------------";
    }
    /^alias/ {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        colLen   = 20;
        aliasLen = length($1);
        tablen   = colLen - aliasLen;

        printf " " $1 " "

        for (i = 0; i < tablen; i++)
            printf "-"

        # TODO check if command ends in \
        # and indent + print continuation.

        print " " $2

    } END {
        print "--------------------------------";
    }' < "$HOME/.zshrc" | grep --color '#.*\|$'

