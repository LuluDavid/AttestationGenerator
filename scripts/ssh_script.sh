#!/bin/sh
python3 -u AttestationGenerator/src/main.py
cd Downloads
a=`ls ./Downloads | head -n 1`
echo $a