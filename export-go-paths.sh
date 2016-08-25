#!/usr/bin/env sh

# Usage: source ./export-go-paths.sh

set -a

export PATH=$PATH:/usr/local/go/bin # local package
export GOPATH=$HOME/trees/go        # source files
export GOBIN=$HOME/trees/go/bin     # binaries
