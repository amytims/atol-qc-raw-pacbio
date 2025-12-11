process GENERATE_STATS_FILE {

   publishDir "${params.outdir}/qc", mode: 'copy'

   input:
   path cutadapt_log
   path stats_file

   output:
   path "pacbio_stats_${basename}.json", emit: summary_stats_json

   script:
   basename=stats_file.getBaseName(2)
   """

   BASECOUNT=\$(awk 'FNR == 2 {print \$5}' $stats_file  | sed 's/,//g')
   READCOUNT=\$(awk 'FNR == 2 {print \$4}' $stats_file | sed 's/,//g')
   BASES_REMOVED=\$((\$(grep "Total basepairs processed" $cutadapt_log | awk '{print \$4}' | sed 's/,//g') - \$(grep "Total written (filtered):" $cutadapt_log | awk '{print \$4}' | sed 's/,//g')))
   READS_REMOVED=\$(grep "Reads discarded as trimmed:" $cutadapt_log | awk '{print \$5}' | sed 's/,//g')
   MEAN_GC=\$(awk 'FNR == 2 {print \$18}' $stats_file | sed 's/,//g')
   N50L=\$(awk 'FNR == 2 {print \$13}' $stats_file | sed 's/,//g')

   cat <<EOF > pacbio_stats_${basename}.json
   {
      "base_count": \$BASECOUNT,
      "read_count": \$READCOUNT,
      "qc_bases_removed": \$BASES_REMOVED,
      "qc_reads_removed": \$READS_REMOVED,
      "mean_gc_content": \$MEAN_GC,
      "n50_length": \$N50L
   }
   EOF

   """
}