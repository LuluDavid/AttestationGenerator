#!/bin/sh
python3 AttestationGenerator/src/main.py "$0"
cd Downloads || return
# shellcheck disable=SC2012
a=$(ls | tail -n 1)
echo "$a"