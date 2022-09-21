#!/usr/bin/env nextflow

params.folder = "$baseDir/seqs/*read{1,2}.fa"
read_pair_channels = Channel.fromFilePairs(params.folder)

process merge_reads {

    publishDir "merge_reads/"

    input:
    tuple val(read_id),path(read_file)

    output:
    path "${read_id}.fa"

    script:
    """
    touch "${read_id}.fa"
    cat $read_file >> "${read_id}.fa"
    """
}

process condition {
    
}

workflow {
    merge_reads(read_pair_channels)
}