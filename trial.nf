#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.data_dir = "$baseDir/seqs/"
params.folder = "$baseDir/seqs/*read{1,2}.fasta"
params.csv = "$baseDir/input.csv"
//read_pair_channels = Channel.fromFilePairs(params.folder)

file_csv = Channel.fromPath(params.csv).splitCsv(header: true).map{ tuple(it.shortname, ["$baseDir${it.read1}", "$baseDir${it.read2}"]) }
condition_channel = Channel.fromPath(params.csv).splitCsv(header: true).map{ tuple(it.condition, it.shortname) }
conditions = Channel
    .fromPath(params.csv)
    .splitCsv(header: true)
    .map { tuple(it.read1, it.read2, it.condition) }
    .groupTuple( by: 2)

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
    tuple path('*.fasta'), val(read_id)

    script:
    """
    touch "${read_id}.fasta"
    cat $read_file >> "${read_id}.fasta"

    """
}

process combine_condition {

    publishDir "combine_condition_reads/", mode: "copy"

    input:
    tuple val(shortname),path(read_file),val(condition)

    output:
    path('*.fasta')

    script:
    """
    touch "${condition}.fasta"
    cat $read_file >> "${condition}.fasta"
    """

}

//def i = 0
//def readLocHeader = new File(params.readsLocCsvFile).readLines()[0].split(',')
//def conditionIdx = readLocHeader.findIndexOf {it == 'condition'}
//def conditions = new File(params.readsLocCsvFile).readLines().collect {it.split(',')[conditionIdx]}.drop(1).unique()
//conditions = conditions.collect {[i++,it]}
//def conditionPairs = [conditions,conditions].combinations().findAll {it[1][0] > it[0][0] }.collect {[it[0][1],it[1][1]]}


workflow {
    //condition_channel.view()
    //read_pair_channels.view()
    //merge_reads(file_csv).join(condition_channel, by: 1).groupTuple(by: 2). | combine_condition
    //conditions.view()
    //file_csv | merge_reads |
}
