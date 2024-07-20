#!/bin/bash

#SBATCH -J blast1                            # Name of the job
#SBATCH -o blast1.out                        # Name of file that will have program output
#SBATCH -e blast1.err                        # Name of the file that will have job errors, if any
#SBATCH -N 1                                # Number of nodes ( the normal cluster partion has 22 total )
#SBATCH -n 20                               # Number of cores ( my test allocated 2 per node )
#SBATCH -p normal                           # Partition
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load fastx_toolkit/0.0.14
module load blast+/gcc7/2.9.0

# Script written to run both the final reads and removed reads against red grouper mitochondrial genome to ensure that any mtDNA fragments were removed from sequences
FILE=A20043_11_m64164_230302_051904.filtered2.fastq
#FILE=mtdna_mapped_A20043_11_m64164_230302_051904.fastq
FILE_PREFIX=$(echo $FILE | cut -f1 -d".")
REF=Grouper_mtdna.fasta
REF_PREFIX=$(echo $REF | cut -f1 -d".")

sed -n '1~4s/^@/>/p;2~4p' $FILE > $FILE_PREFIX.fa
#fastq_to_fasta -i $FILE -o $FILE_PREFIX.fa
wait
makeblastdb -in $REF -input_type fasta -dbtype nucl -out $REF_PREFIX
wait
blastn -query $FILE_PREFIX.fa -out $FILE_PREFIX.blast -db $REF_PREFIX -perc_identity 95 -outfmt "6 qseqid qstart qend sseqid qseq evalue length pident nident mismatch gapopen gaps qcovus qcovhsp" -max_target_seqs 500 -max_hsps 5 -num_threads 20
