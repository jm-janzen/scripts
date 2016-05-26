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

    # XXX Returns single line, with variable spacing
    branches=$(git -C $dir show-branch --list 2> /dev/null) || continue

    IFS=$'\n'
    for branch in "${branches}"; do
        let ++git_branches
    done

    let ++git_count

done

printf "gits:%d, duplicates:%d, branches:%d\n" $git_count $git_duplicates $git_branches

