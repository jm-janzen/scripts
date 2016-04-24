#!/bin/sh -e
# Format output of alias print dump into more readable format

if [ -f "TEMP.AWK" ]; then
    echo "Somehow 'TEMP.AWK' already exists"
    exit 1
fi


cat ${HOME}/.zshrc | grep -e '^alias' | awk -F'=' 'BEGIN {
        print "ALIAS                  | COMMAND";
        print "--------------------------------";
    }
    {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        col1Len  = 20;
        aliasLen = length($1);
        tab1len  = col1Len - aliasLen;

        printf " " $1 " "

        for (i = 0; i < tab1len; i++)
            printf "-"

        print " " $2

    } END {
        print "--------------------------------";
    }' > TEMP.AWK

cat TEMP.AWK | grep --color -e '[#].*\|$'

rm TEMP.AWK
