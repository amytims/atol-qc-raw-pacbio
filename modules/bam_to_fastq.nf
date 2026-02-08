process BAM_TO_FASTQ {
    input:
    tuple val(pkg), val(file_name), val(format), val(url), val(md5sum), val(lane), val(read), path(file_path)
    
    output:
    path "${basename}.fastq", emit: fastq

    script:
    basename = input_bam.getBaseName(1)
    """
    # Note: --threads value represents *additional* CPUs to allocate (total CPUs = 1 + --threads)
    samtools fastq --threads ${task.cpus-1} $file_path > ${basename}.fastq
    """
}