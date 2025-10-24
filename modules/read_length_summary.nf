process READ_LENGTH_SUMMARY {
    publishDir "${params.outdir}/qc/read_length_distributions", mode: 'copy', pattern: "${basename}_summary_stats.txt"

    input:
    path input_file

    output:
    path "${basename}_read_lengths.txt", emit: summary_stats
    path "${basename}_read_lengths.txt", emit: read_lengths

    script:
    basename=input_file.getBaseName(input_file.name.endsWith('.gz')? 2: 1)
    """
    seqkit stats $input_file -a > "${basename}_summary_stats.txt"

    zcat $input_file | seqkit fx2tab -l | cut -f 4 > "${basename}_read_lengths.txt"

    sed -i "s/\$/\t${basename}/" ${basename}_read_lengths.txt
    """
}