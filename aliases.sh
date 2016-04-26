#!/bin/sh -e
# Format output of alias print dump into more readable format

awk -F= 'BEGIN {
        TABLE_FMT = "%-21s | %-59s";
        row = sprintf(TABLE_FMT, "ALIAS", "COMMAND");
        print row;
        gsub(".", "-", row);
        print row;
    }
    /^alias/ {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        printf(TABLE_FMT "\n", $1, $2);

    } END {
        print row;
    }' < "$HOME/.zshrc" | grep --color '#.*\|$'

