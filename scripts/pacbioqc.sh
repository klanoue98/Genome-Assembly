#!/bin/bash
#SBATCH -J pacbioqc
#SBATCH -e pacbioqc.err
#SBATCH -o pacbioqc.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p jgoldq
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load fastqc/0.11.9
module load multiqc

# run fastqc on each bam and then combine results with multiqc
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64164_230302_051904.fastq.gz
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64164_230303_141943.fastq.gz
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64164_230304_232818.fastq.gz
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64164_230306_083357.fastq.gz 
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64284e_230305_090942.fastq.gz
fastqc -t 20 /preprocess/fastq_reads/A20043_11_m64292e_230226_035559.fastq.gz

multiqc *fastqc.gz
