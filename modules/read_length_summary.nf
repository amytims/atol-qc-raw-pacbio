process READ_LENGTH_SUMMARY {
    publishDir "${params.logs}", mode: 'copy', pattern: "${basename}_read_length_plot.png"
    publishDir "${params.logs}", mode: 'copy',  pattern: "${basename}.summary_stats.txt"

    input:
    path input_file

    output:
    path "${basename}.summary_stats.txt", emit: summary_stats
    path "${basename}_read_length_plot.png", emit: read_length_plot

    script:
    basename=input_file.getBaseName(input_file.name.endsWith('.gz')? 2: 1)
    """
    seqkit stats $input_file -a > "${basename}.summary_stats.txt"

    seqkit watch --fields ReadLen $input_file -O "${basename}_read_length_plot.png"

    """
}