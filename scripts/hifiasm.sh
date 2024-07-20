#!/bin/bash
#SBATCH -J hifiasm
#SBATCH -o hifiasm.out
#SBATCH -e hifiasm.err
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 96:00:00
#SBATCH -p normal
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends

cd $WORK/red_grouper_genome_assembly

module load gcc

../pkgs/hifiasm/hifiasm -o emo_31824_hifi.asm -t 20 -f0 --primary /preprocess/filter/mtdna_filter/A20043_11_m64284e_230305_090942.filtered2.fastq.gz /preprocess/filter/mtdna_filter/A20043_11_m64164_230306_083357.filtered2.fastq.gz /preprocess/filter/mtdna_filter/A20043_11_m64292e_230226_035559.filtered2.fastq.gz /preprocess/filter/mtdna_filter/A20043_11_m64164_230304_232818.filtered2.fastq.gz /preprocess/filter/mtdna_filter/A20043_11_m64164_230303_141943.filtered2.fastq.gz /preprocess/filter/mtdna_filter/A20043_11_m64164_230302_051904.filtered2.fastq.gz

# -o prefix of output files
# -t number of threads to use
# -f0 disables initial bloom filter (recommded for smaller genomes)
# --primary outputs a primary and secondary assembly
