#!/usr/bin/env bash
$1 >> $2
cat /dev/urandom | tr -dc 'AGTC' | fold -w 100 | head -n 1 >> $2
