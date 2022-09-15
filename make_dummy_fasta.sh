#!/usr/bin/env bash

# usage 
# sh make_dummy_fasta.sh sequencename outputfile
$1 >> $2
cat /dev/urandom | tr -dc 'AGTC' | fold -w 100 | head -n 1 >> $2
