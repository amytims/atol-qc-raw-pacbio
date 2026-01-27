def help_file() {
    log.info """
    #######################################################################################
    ##################### RUN QC AND SUMMARY STATS ON DOWNLOADED DATA #####################
    #######################################################################################

        Runs cutadapt on pacbio data to filter residual adapters; generates read length
        summary plot.
        
        Following Hanrahan et al. 2025 (doi.org/10.1093/g3journal/jkaf046),
        cutadapt is run with the following parameters: 
            --error-rate 0.1 
            --overlap 25 
            --match-read-wildcards 
            --revcomp 
            --discard-trimmed

        To change this, edit the ext.args line in nextflow.config

        OPTIONS:

        --indir <PATH/TO/INPUT/DIRECTORY>
                File path to the directory where raw hifi read files are stored
                Default is './results/raw_reads/hifi'
        
        --outdir <PATH/TO/OUTPUT/DIRECTORY>
                File path to where processed hifi reads should be stored
                Default is './results/processed_reads/hifi'

        --stats <PATH/TO/OUTPUT/DIRECTORY>
                File path to where summary stats .json file should be stored
                Default is './results/qc'

        --logs <PATH/TO/OUTPUT/DIRECTORY>
            File path to where cutadapt and seqkit logs should be stored
            Default is './results/qc/pacbio_logs'

        --pacbio_adapters_fasta
                Path to .fasta file containing PacBio HiFi adapters to filter
                Default is 'assets/pacbio_adapters.fa'

    #######################################################################################
    """.stripIndent()
}


// print help file if requested
if ( params.remove('help') ) {
    help_file()
    exit 0
}

// check no unexpected parameters were specified
allowed_params = [
    // pipeline inputs
    "indir",
    "outdir",
    "stats",
    "logs",
    "pacbio_adapters_fasta",

    // Pawsey options
    "max_cpus",
    "max_memory"
]

params.each { entry ->
    if ( !allowed_params.contains(entry.key) ) {
        println("The parameter <${entry.key}> is not known");
        exit 0;
    }
}


include { BAM_TO_FASTQ } from './modules/bam_to_fastq.nf'
include { CUTADAPT } from './modules/cutadapt.nf'
include { READ_LENGTH_SUMMARY } from './modules/read_length_summary.nf'
include { GENERATE_STATS_FILE } from './modules/generate_stats_file.nf'


workflow {
        
    pacbio_samples_ch = Channel.fromPath("${params.indir}/*")

    BAM_TO_FASTQ(pacbio_samples_ch)

    cutadapt_ch = BAM_TO_FASTQ.out.fastq

    CUTADAPT(cutadapt_ch, "${params.pacbio_adapters_fasta}")

    read_length_summary_ch = CUTADAPT.out.filt_fastq_gz

    READ_LENGTH_SUMMARY(read_length_summary_ch)

    GENERATE_STATS_FILE(CUTADAPT.out.cutadapt_log, READ_LENGTH_SUMMARY.out.summary_stats)

}