#!/usr/bin/env nextflow

params.folder = "$baseDir/seqs/*read{1,2}.fa"
read_pair_channels = Channel.fromFilePairs(params.folder)

//fastqCh = Channel
//        .fromPath(params.readsLocCsvFile)
//        .splitCsv(header: true)
//        .map { tuple(it.short_name,  [file(it.read1), file(it.read2)]) }

process merge_reads {
    debug true
    publishDir "merge_reads/", mode: "copy"

    input:
    tuple val(read_id),path(read_file)

    output:
    path '*.fa'

    script:
    """
    cat $read_file >> "${read_id}.fa"
    echo $read_file
    """
}

process combine_condition {
    debug true
    publishDir "merge_condition"

    input:
    path read_file

    output:
    path "*.fa"
    
    shell: 
    '''
    condition=$(echo !{read_file} | gawk 'match($0, /^([^_]*)_/, condition) {print condition[1]}')
    cat !{read_file} >> "${condition}.fa"
    echo "${condition}.fa"
    '''
}

workflow {
    read_pair_channels | merge_reads | combine_condition
}
