#!/bin/sh -e
# Usage: `sudo sh gulp-tracer.sh'

strace -tp $(pgrep -l gulp | awk '{ print $1}') -etrace=stat -esignal=none
