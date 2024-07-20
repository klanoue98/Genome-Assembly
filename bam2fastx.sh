#!/bin/bash
#SBATCH -J fastx
#SBATCH -e fastx.consensus.err
#SBATCH -o fastx.consensus.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p jgoldq
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

# Activate conda environment 
source ~/miniconda3/etc/profile.d/conda.sh
conda activate assembly

# Create index file for each bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64164_230302_051904.hifi_reads.bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64164_230303_141943.hifi_reads.bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64164_230304_232818.hifi_reads.bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64164_230306_083357.hifi_reads.bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64284e_230305_090942.hifi_reads.bam
pbindex /raw_reads/pacbio_assembly/A20043_11_m64292e_230226_035559.hifi_reads.bam

# Convert to fastq
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64164_230302_051904 ./raw_reads/pacbio_assembly/A20043_11_m64164_230302_051904.hifi_reads.bam
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64164_230303_141943 ./raw_reads/pacbio_assembly/A20043_11_m64164_230303_141943.hifi_reads.bam
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64164_230304_232818 ./raw_reads/pacbio_assembly/A20043_11_m64164_230304_232818.hifi_reads.bam
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64164_230306_083357 ./raw_reads/pacbio_assembly/A20043_11_m64164_230306_083357.hifi_reads.bam
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64284e_230305_090942 ./raw_reads/pacbio_assembly/A20043_11_m64284e_230305_090942.hifi_reads.bam
bam2fastq -o /preprocess/fastq_reads/A20043_11_m64292e_230226_035559 ./raw_reads/pacbio_assembly/A20043_11_m64292e_230226_035559.hifi_reads.bam
