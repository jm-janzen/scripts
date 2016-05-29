#!/bin/bash -e

# look for directories which respond to `git branch' command.

git_duplicates=0
git_branches=0
git_count=0
git_bad=0
git_dirs=$(find ${HOME} -name '.git')

for dir in $git_dirs; do
    dir=${dir%.git}

    if [[ $@ == "-l" ]] || [[ $@ == "--list" ]]; then
        echo $dir
    fi

    if [[ $@ == "-u" ]] || [[ $@ == "--update" ]]; then
        $(git -C $dir remote -v update) || continue
    fi

    if [[ $@ == "-d" ]] || [[ $@ == "--dirty" ]]; then
        git=`git -C $dir status -s -b`
        dir=`git -C $dir rev-parse --show-toplevel`
        for g in $git; do
            echo "$g" | awk -vdir="$dir" \
                'staleFiles = 0;
                 /^M$/ { staleFiles++; }
                 /^A$/ { staleFiles++; }
                 /^R$/ { staleFiles++; }
                 /^D$/ { staleFiles++; }
                 /^\?\?$/ { }
                 END {
                 if (staleFiles > 0)
                     printf "Found %d out-of-date file(s) in %s\n", staleFiles, dir;

                }'
        done
    fi

    for g in `git -C $dir ls-remote --heads 2> /dev/null`; do
        let ++git_branches
    done

    let ++git_count

done

printf "gits:%d, duplicates:%d, branches:%d\n" $git_count $git_duplicates $git_branches

