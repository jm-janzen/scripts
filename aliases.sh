#!/bin/sh -e

#
# Summary
#   aliases.sh - Format output of aliases for z shell
#
# Usage
#   ./aliases.sh
#
# Description
#   An excedingly simple script, that is by no means guaranteed
#   to be reusable.  Reads the contents of `~/.zshrc' for alias
#   declarations, and prints the output into columns, along with
#   any associated comments (highlights with grep).
#

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

