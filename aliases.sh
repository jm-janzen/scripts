#!/bin/sh -e
# Format output of alias print dump into more readable format

awk -F= 'BEGIN {
        TABLE_FMT = "%-21s | %-60s";
        row = sprintf(TABLE_FMT, "ALIAS", "COMMAND");
        print row;
        print "--------------------------------";
    }
    /^alias/ {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        tablen   = 20 - length($1);

        printf " " $1 " "

        for (i = 0; i < tablen; i++)
            printf "-"

        # TODO check if command ends in \
        # and indent + print continuation.

        print " " $2

    } END {
        print "--------------------------------";
    }' < "$HOME/.zshrc" | grep --color '#.*\|$'

