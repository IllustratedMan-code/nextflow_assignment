# Nextflow Assignment
Instructions:
Things to do.
- [x] Combine read1 and read2 into one FASTA file for each sample and name the file using the shortname.
- [x] Create a condition fasta file by combining all the sample FASTA file into one FASTA file and name the file using the condition.
- [ ] For each pair of conditions create a combined FASTA file (e.g. SARS1_vs_SARS2.fasta which will have all the SARS1 and SARS2 sequences).
- [ ] Create a summary file of number bases in each sample read 1 and read 2 file.
        shortname,read1,read2,
        sars1_rep_A,100,100
- [ ] Create a summary file of number bases in each condition read 1 and read 2 file.
        condition,read1,read2,
        sars1,300,300
//def i = 0
//def readLocHeader = new File(params.readsLocCsvFile).readLines()[0].split(',')
//def conditionIdx = readLocHeader.findIndexOf {it == 'condition'}
//def conditions = new File(params.readsLocCsvFile).readLines().collect {it.split(',')[conditionIdx]}.drop(1).unique()
//conditions = conditions.collect {[i++,it]}
//def conditionPairs = [conditions,conditions].combinations().findAll {it[1][0] > it[0][0] }.collect {[it[0][1],it[1][1]]}
# Input File

