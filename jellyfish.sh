#!/bin/bash
#SBATCH -J jellyfish
#SBATCH -e jellyfish.err
#SBATCH -o jellyfish.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p normal
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load jellyfish

# Script Input parameters

# - F: number of input files
# - C: count canonical kmers
# - m: k-mer length 
# According to https://github.com/schatzlab/genomescope/blob/47e86a1b5b723b57fa267d9ca4b058b527134796/README.md
#  "We recommend using a kmer length of 21 (m=21) for most genomes, as this length is sufficiently long that most k-mers are not repetitive and is short enough that the analysis will be more robust to sequencing errors" 
# - s: memory usage
# - t: thread count
# - o: output file name

jellyfish count -F 6 <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64164_230302_051904.fastq.gz) <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64164_230303_141943.fastq.gz) <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64164_230304_232818.fastq.gz) <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64164_230306_083357.fastq.gz) <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64284e_230305_090942.fastq.gz) <(zcat /work/marinegenomics/klanoue/red_grouper_genome_assembly/preprocess/fastq_reads/A20043_11_m64292e_230226_035559.fastq.gz) -C -m 21 -s 5G -t 20 -o reads.jf

jellyfish histo -t 20 reads.jf > reads.histo

jellyfish dump reads.jf > reads_dumps.fa
