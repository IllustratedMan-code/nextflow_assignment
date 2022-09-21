#!/usr/bin/env bash

# usage 
# sh make_dummy_fasta.sh sequencename outputfile
# "$1" >> "$2"

reads=("read1" "read2")
conditions=("sars1" "sars2" "ctrl")
seqs=("A" "B" "C")

for seq in "${seqs[@]}"
do
    for condition in "${conditions[@]}"
    do
        for read in "${reads[@]}"
        do
            nameSeq=">"${condition}"_rep_"${seq}
            nameFile="seqs/"${condition}"_rep_"${seq}"_"${read}".fa"
            echo $nameSeq >> $nameFile
            cat /dev/urandom | tr -dc 'AGTC' | fold -w 100 | head -n 1 >> $nameFile
        done
    done
done

#echo $1 >> $2
#cat /dev/urandom | tr -dc 'AGTC' | fold -w 100 | head -n 1 >> $2
