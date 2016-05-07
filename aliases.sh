#!/bin/sh -e
# Format output of aliases for z shell

awk -F= 'BEGIN {
        TABLE_FMT = "%-21s | %-59s";
        row = sprintf(TABLE_FMT, "ALIAS", "COMMAND");
        holdover;
        print row;
        gsub(".", "-", row);
        print row;
    }
    /^alias/ {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        # check for continuation char
        if ($2 ~ /\\$/) {
            holdover = $1 $2;
        } else if (holdover) {
            printf(TABLE_FMT holdover, "\n", $1, $2, "\n");
            holdover = 0;
        } else {
            printf(TABLE_FMT "\n", $1, $2);
        }

    } END {
        print row;
    }
' < "$HOME/.zshrc" | grep --color '#.*\|$'

