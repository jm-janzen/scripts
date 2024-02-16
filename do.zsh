#!/bin/env zsh

#set -vx

# TODO Route to `cd' if more than 1 positional arg

function cdo() {

	dir="${@:1:1}"
	cmd="${@:2:1}"
	opt="${@:3}"

	#echo "dir=${@:1:1}"
	#echo "cmd=${@:2:1}"
	#echo "opt=${@:3}"
	#echo -e "\n\tcommand $cmd $opt\n"

	if [[ $# -lt 2 ]]
	then
		echo 'Usage: do <dir> <command> [opts]'
		exit 1
	fi

	chdir "${dir}"

	command $cmd $opt

	exit_code=$?

	chdir -

	exit $exit_code
}

cdo $@
