#!/bin/sh -e
# Format output of alias print dump into more readable format

cat ${HOME}/.zshrc | grep -e '^alias' | awk -F'=' 'BEGIN {
        print "ALIAS                         | COMMAND";
        print "---------------------------------------";
    }
    {

        # replace all multi-spaces with a single space
        gsub(/\s+/, " ", $0);

        col1Len  = 20;
        col2Len  = 60;
        aliasLen = length($1);
        cmdLen   = length($2);

        tab1len   = col1Len - aliasLen;
        tab2len   = col2Len - cmdLen;

        printf " " $1

        printf " "
        for (i = 0; i < tab1len; i++)
            printf "-"
        printf " "

        print $2

    } END {
        print "---------------------------------------";
    }' > TEMP.AWK

cat TEMP.AWK | grep --color -e '[#].*'



rm TEMP.AWK
