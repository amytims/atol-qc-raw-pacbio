# atol-qc-raw-pacbio

Run cutadapt on pacbio hifi reads to remove adapters; generate read length distribution plot.

## Usage

```
nextflow run amytims/atol-qc-raw-pacbio \
    --indir </path/to/raw/pacbio/reads_directory> \
    --outdir <OUTPUT_DIRECTORY> \
    --plot_title "Genus species Read Length Distribution" 
```

To show all options, use:

```
nextflow run amytims/atol-data-mover --help
```