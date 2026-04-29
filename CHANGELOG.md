## 0.2.0 (26-04-29)

### Changes

* bam file now filtered on tag `rq >= 0.99` before conversion to .fastq to ensure only HiFi reads are kept

### Bug fixes

* stats.json now outputs n50_length instead of n50_number

### Other

* read_lengths.png files now go to stats directory rather than reads directory

## 0.1.3

### Bug fixes

* read_lengths.png files are now named after the file they're created from to avoid overwriting each other

## 0.1.2

### Bug fixes

* temp files are now stored in a temp directory to avoid overwriting each other when running multiple instances of the container in parallel

## 0.1.1 (2026-03-17)

### Other

* Fix filepath to default adapter set in pyproject.toml

## 0.1.0 (2026-03-17)

### Other

* First attempt
