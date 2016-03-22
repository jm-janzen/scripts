#!/bin/bash -e

cmd='curl ipinfo.io/"${1}"/json'
eval $cmd
