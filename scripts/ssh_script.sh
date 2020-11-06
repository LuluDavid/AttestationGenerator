#!/bin/sh
python3 AttestationGenerator/src/main.py "$1" >> logs.txt
cd Downloads || return
# shellcheck disable=SC2012
a=$(ls | tail -n 1)
echo "$a"