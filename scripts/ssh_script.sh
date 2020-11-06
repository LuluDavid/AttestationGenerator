#!/bin/sh
python3 AttestationGenerator/src/main.py
cd Downloads || return
# shellcheck disable=SC2012
a=$(ls | tail -n 1)
echo "$a"