#!/bin/bash
#SBATCH -J adapter_trim
#SBATCH -e adapter_trim.err
#SBATCH -o adapter_trim.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p jgoldq
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load bbmap/38.90

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64164_230302_051904.fastq.gz out=/preprocess/filter/A20043_11_m64164_230302_051904.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64164_230303_141943.fastq.gz out=/preprocess/filter/fastq_reads/A20043_11_m64164_230303_141943.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64164_230304_232818.fastq.gz out=/preprocess/filter/fastq_reads/A20043_11_m64164_230304_232818.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64164_230306_083357.fastq.gz out=/preprocess/filter/fastq_reads/A20043_11_m64164_230306_083357.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64284e_230305_090942.fastq.gz out=/preprocess/filter/fastq_reads/A20043_11_m64284e_230305_090942.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality

removesmartbell.sh in=/preprocess/fastq_reads/A20043_11_m64292e_230226_035559.fastq.gz out=/preprocess/filter/fastq_reads/A20043_11_m64292e_230226_035559.filtered1.fastq.gz adapter="ATCTCTCTCTTTTCCTCCTCCTCCGTTGTTGTTGTTGAGAGAGAT" split=t ignorebadquality
