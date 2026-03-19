# atol-qc-raw-pacbio

Runs QC and produces summary stats on Pacbio HiFi reads
1. Convert .bam file to .fastq for downstream processing
2. Filter reads (`cutadapt`)
3. Compress output (`pigz`)
4. Output stats and read length distribution plot (`seqkit`)

## Installation: Use the [BioContainer](https://quay.io/repository/biocontainers/atol-qc-raw-pacbio?tab=tags)

*e.g.* with Apptainer/Singularity:

```bash
apptainer exec \
  docker://quay.io/biocontainers/atol-qc-raw-pacbio:0.1.1--pyhdfd78af_0 \
  atol-qc-raw-pacbio  
  
```

## Usage
```bash
atol-qc-raw-pacbio \
    --bam data/reads.bam \
    --out results/filtered_reads.fastq.gz \
    --stats results/stats.json \
    --logs results/logs \
    --match-read-wildcards \
    --revcomp \
    --discard-trimmed
```

### Full Usage
```
atol-qc-raw-pacbio version 0.1.dev1+g8817b02cb.d20260316
usage: atol-qc-raw-pacbio [-h] [-t THREADS] [-m MEM_GB] [-n] --bam BAM [--pacbio_adapters PACBIO_ADAPTERS] [--error-rate ERROR_RATE] [--overlap OVERLAP] [--match-read-wildcards]
                          [--revcomp] [--discard-trimmed] [--min-length MIN_LENGTH] --out READS_OUT --stats STATS [--logs LOGS_DIRECTORY]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
  -m MEM_GB, --mem MEM_GB
                        Intended maximum RAM in GB. NOTE: some stepsdon't allow memory usage to be specified by the user.
  -n                    Dry run

Input:
  --bam BAM             Input .bam file
  --pacbio_adapters PACBIO_ADAPTERS

cutadapt options:
  --error-rate ERROR_RATE
  --overlap OVERLAP
  --match-read-wildcards
  --revcomp
  --discard-trimmed
  --min-length MIN_LENGTH
                        Minimum length read to output. Default is 1, i.e. keep all reads.

Output:
  --out READS_OUT       Combined output in fastq.gz
  --stats STATS         Stats output (json)
  --logs LOGS_DIRECTORY
                        Log output directory. Default: logs are discarded.
```