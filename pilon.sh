#!/bin/bash
#SBATCH -J pilonsplit.
#SBATCH -o pilonsplit.out
#SBATCH -e pilonsplit.err
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p normal
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load minimap2
module load samtools/gcc7/1.9
module load perl
module load pilon/1.23

# step 1: map filtered hifi reads (adapter & mtDNA removed)reads to reference and convert to bam.
minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64284e_230305_090942.filtered2.fastq.gz > minimap.output1.sam

minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64164_230306_083357.filtered2.fastq.gz > minimap.output2.sam

minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64292e_230226_035559.filtered2.fastq.gz > minimap.output3.sam

minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64164_230304_232818.filtered2.fastq.gz > minimap.output4.sam

minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64164_230303_141943.filtered2.fastq.gz > minimap.output5.sam

minimap2 -t 30 -ax asm20 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 01_preprocesses/filter/mtdna_filter/A20043_11_m64164_230302_051904.filtered2.fastq.gz > minimap.output6.sam

#step 2: convert files
samtools view -Sb minimap.output1.sam > minimap.output1.bam
samtools view -Sb minimap.output2.sam > minimap.output2.bam
samtools view -Sb minimap.output3.sam > minimap.output3.bam
samtools view -Sb minimap.output4.sam > minimap.output4.bam
samtools view -Sb minimap.output5.sam > minimap.output5.bam
samtools view -Sb minimap.output6.sam > minimap.output6.bam

# step 3: sort bams
samtools sort -o minimap.output1.sorted.bam minimap.output1.bam
samtools sort -o minimap.output2.sorted.bam minimap.output2.bam
samtools sort -o minimap.output3.sorted.bam minimap.output3.bam
samtools sort -o minimap.output4.sorted.bam minimap.output4.bam
samtools sort -o minimap.output5.sorted.bam minimap.output5.bam
samtools sort -o minimap.output6.sorted.bam minimap.output6.bam

# step 4: index bams
samtools index minimap.output1.sorted.bam
samtools index minimap.output2.sorted.bam
samtools index minimap.output3.sorted.bam
samtools index minimap.output4.sorted.bam
samtools index minimap.output5.sorted.bam
samtools index minimap.output6.sorted.bam

# step 5 v2: split fasta into chunks
perl 00_support/scripts/fasta-splitter.pl --part-size 75 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINALfasta -out-dir 04_polish/emo_32124_hifi/pilon
