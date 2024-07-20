#!/bin/bash
#SBATCH -J hic_align.
#SBATCH -o hic_align.out
#SBATCH -e hic_align.err
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p normal
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load bwa samtools bedtools2
source /home/klanoue/miniconda3/etc/profile.d/conda.sh
conda activate SALSA2
conda activate picard

# run steps one at a time-- comment out whatever steps you are not actively running

#step 0: index reference genome
bwa index -p wtdbg2_02062024 /raw_assembly/wtdbg2_02062024.ctg.fa 
#p=prefix of output
#Run Time:00:21:00


#step 1: align Hi-C reads to reference using bwa-mem. Map R1 and R2 separately, they will be combined in later step
#bwa mem -t 20 wtdbg2_02062024 /raw_reads/hic_reads/20043-11Q2-01_S12_L002_R1_001.fastq.gz | samtools view -@ 20 -Sb - > raw.r1.bam
#bwa mem -t 20 wtdbg2_08122022_3.ctg /raw_reads/hic_reads/20043-11Q2-01_S12_L002_R2_001.fastq.gz | samtools view -@ 20 -Sb - > raw.r2.bam
#Run Time:00:40:00

#step 2: filter chimeric reads that did not map in 5' orientation
#samtools view -h raw.r1.bam | perl /filter_five_end.pl | samtools view -Sb - > filt.r1.bam
#samtools view -h raw.r2.bam | perl /filter_five_end.pl | samtools view -Sb - > filt.r2.bam
#Run Time: ~05:00:00

#step 3.a: combine r1 and r2 reads, map quality filter, sort reads
#perl /two_read_combiner.pl filt.r1.bam filt.r2.bam samtools 10 | samtools view -bS -t wtdbg2_02062024.fai - | samtools sort -@ 20 -o temp.bam -
#Run Time: 03:00:00

#step 3.b: add read group w/ picard
#picard AddOrReplaceReadGroups INPUT=temp.bam OUTPUT=paired.bam ID=assembly LB=assembly SM=redgrouper PL=ILLUMINA PU=none
#Run Time:01:34:58
#LB= read group library
#PL= read group platform
#PU=read group platform unit
#SM= read group sample name
#Run time: 00:30:00

#step 4: remove PCR duplicates
#java -Xmx30G -XX:-UseGCOverheadLimit -Djava.io.tmpdir=temp/ -jar /home/klanoue/miniconda3/envs/picard/share/picard-2.18.29-0/picard.jar MarkDuplicates INPUT=paired.bam OUTPUT=alignment.bam METRICS_FILE=metrics.alignment.txt TMP_DIR=temp/ ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE
#Run time:

#step 5: index and get stats
#samtools index alignment.bam
#perl /get_stats.pl alignment.bam > alignment.bam.stats
#samtools flagstat alignment.bam > alignment_flagstats.txt
#Run Time:

#step 6: convert bam to bed format required by SALSA2. Sort by read name
#bamToBed -i alignment.bam > alignment.bed
#sort -k 4 alignment.bed > tmp && mv tmp alignment.bed
#Run Time: 00:35:00
