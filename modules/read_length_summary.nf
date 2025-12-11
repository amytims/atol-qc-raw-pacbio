process READ_LENGTH_SUMMARY {
    publishDir "${params.outdir}/qc/read_length_distributions", mode: 'copy', pattern: "${basename}_read_length_plot"

    input:
    path input_file

    output:
    path "${basename}.summary_stats.txt", emit: summary_stats
    path "${basename}_read_length_plot_1k_ish.png", emit: read_length_plot_1
    path "${basename}_read_length_plot_default_bins.png", emit: read_length_plot_2

    script:
    basename=input_file.getBaseName(input_file.name.endsWith('.gz')? 2: 1)
    """
    seqkit stats $input_file -a > "${basename}.summary_stats.txt"

    seqkit watch --fields ReadLen $input_file -O "${basename}_read_length_plot_1k_ish.png" --bins \$(awk 'FNR == 2 {print \$8}' ${basename}.summary_stats.txt | sed  's/,//g'| xargs -n 1 bash -c 'echo \$(((\$1/1000) +1 ))' args)
    seqkit watch --fields ReadLen $input_file -O "${basename}_read_length_plot_default_bins.png"

    """

// we can plot a histogram directly with seqkit if we want - less pretty but faster
// the 1000-width bins calculation is cursed, maybe we shouldn't do this
// test later
//seqkit watch --fields ReadLen $input_file -O "${basename}_read_length_plot.png" --bins \$(awk 'FNR == 2 {print $8}' ${basename}_summary_stats.txt | sed  's/,//g'| xargs -n 1 bash -c 'echo \$(((\$1/1000) +1 ))' args)

}