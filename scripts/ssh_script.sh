#!/bin/sh
python3 AttestationGenerator/src/main.py
cd Downloads || return
a=$(ls | tail -n 1)
echo "$a"