#!/bin/bash
#SBATCH -J remove_mtdna
#SBATCH -e remove_mtdna.err
#SBATCH -o remove_mtdna.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p normal
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly/preprocess/filter/mtdna_filter

module load minimap2 samtools

# map reads to mitochondrial genome
# minimap has hifi preset (-x map-hifi) but not present in version on HPC. Recommended to use asm20 instead

minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/A20043_11_m64164_230302_051904.filtered1.fastq.gz > mtDNA_contam1.sam
minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/fastq_reads/A20043_11_m64164_230303_141943.filtered1.fastq.gz > mtDNA_contam2.sam
minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/fastq_reads/A20043_11_m64164_230304_232818.filtered1.fastq.gz > mtDNA_contam3.sam
minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/fastq_reads/A20043_11_m64164_230306_083357.filtered1.fastq.gz > mtDNA_contam4.sam
minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/fastq_reads/A20043_11_m64284e_230305_090942.filtered1.fastq.gz > mtDNA_contam5.sam
minimap2 -t 20 -ax asm20 emo_mtdna.fasta /preprocess/filter/fastq_reads/A20043_11_m64292e_230226_035559.filtered1.fastq.gz > mtDNA_contam6.sam


# extract reads that did not map
# -n write read names as they are
# -f 4 means include only unmapped reads

samtools fastq -n -f 4 mtDNA_contam1.sam > A20043_11_m64164_230302_051904.filtered2.fastq
samtools fastq -n -f 4 mtDNA_contam2.sam > A20043_11_m64164_230303_141943.filtered2.fastq
samtools fastq -n -f 4 mtDNA_contam3.sam > A20043_11_m64164_230304_232818.filtered2.fastq
samtools fastq -n -f 4 mtDNA_contam4.sam > A20043_11_m64164_230306_083357.filtered2.fastq
samtools fastq -n -f 4 mtDNA_contam5.sam > A20043_11_m64284e_230305_090942.filtered2.fastq
samtools fastq -n -f 4 mtDNA_contam6.sam > A20043_11_m64292e_230226_035559.filtered2.fastq

# zip reads
gzip A20043_11_m64164_230302_051904.filtered2.fastq
gzip A20043_11_m64164_230303_141943.filtered2.fastq
gzip A20043_11_m64164_230304_232818.filtered2.fastq
gzip A20043_11_m64164_230306_083357.filtered2.fastq
gzip A20043_11_m64284e_230305_090942.filtered2.fastq
gzip A20043_11_m64292e_230226_035559.filtered2.fastq

# optional: save mapped reads to make sure they align to mtDNA sequence
samtools fastq -F 4 mtDNA_contam1.sam > mtdna_mapped_A20043_11_m64164_230302_051904.fastq.gz
samtools fastq -F 4 mtDNA_contam2.sam > mtdna_mapped_A20043_11_m64164_230303_141943.fastq.gz
samtools fastq -F 4 mtDNA_contam3.sam > mtdna_mapped_A20043_11_m64164_230304_232818.fastq.gz
samtools fastq -F 4 mtDNA_contam4.sam > mtdna_mapped_A20043_11_m64164_230306_083357.fastq.gz
samtools fastq -F 4 mtDNA_contam5.sam > mtdna_mapped_A20043_11_m64284e_230305_090942.fastq.gz
samtools fastq -F 4 mtDNA_contam6.sam > mtdna_mapped_A20043_11_m64292e_230226_035559.fastq.gz
