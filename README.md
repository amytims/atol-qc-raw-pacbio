# atol-qc-raw-pacbio

Run cutadapt on pacbio hifi reads to filter residual adapters; generate read length distribution plot.

     
Following Hanrahan et al. 2025 (doi.org/10.1093/g3journal/jkaf046),
cutadapt is run with the following parameters: \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--error-rate 0.1 \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--overlap 25 \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--match-read-wildcards \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--revcomp \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--discard-trimmed

To change this, edit the ext.args line in nexflow.config

## Usage

```
nextflow run amytims/atol-qc-raw-pacbio \
    --indir <INPUT_DIRECTORY> \
    --outdir <OUTPUT_DIRECTORY> \
    --plot_title "Read Length Distribution" \
    -profile pawsey 
```

To show all options, use:

```
nextflow run amytims/atol-qc-raw-pacbio --help
```
