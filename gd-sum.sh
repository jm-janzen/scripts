#!/bin/bash -e
# Brief sum of additions minus deletions,
# meant to indicate 'red' or 'green' commit
# Output:
#   f = files changed
#   l = lines insert or deleted
#   Format:
#       f:l

git diff --shortstat | \
awk -f <(cat - <<-'EOD'
        {
            red   = 0;
            files = $1;
            sum   = $4 - $6;

            if (sum < 0)
                red = 1;

            sum = sum < 0 ? sum * -1 : sum;
        }
        END {
            if (sum == "") {
                printf "No changes in tracked files.\n"
                exit 0
            }

            printf files ":"

            if (red) {
                printf "\033[1;31m" sum "\033[0m"
            } else {
                printf "\033[1;32m" sum "\033[0m"
            }
            printf "\n"
        }
EOD
)
