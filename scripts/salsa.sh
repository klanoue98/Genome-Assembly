#!/bin/bash
#SBATCH -J salsa
#SBATCH -o salsa.out
#SBATCH -e salsa.err
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p normal                               # Partition
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly

module load samtools
source /home/klanoue/miniconda3/etc/profile.d/conda.sh
conda activate SALSA

# copy files into salsa directory
cp /raw_assembly/wtdbg2_02062024.ctg.fa .

# create reference index file (creates contig lengths as input)
samtools faidx wtdbg2_02062024.ctg.fa

#correcting and scaffolding long read assembly with HiC data
python /home/klanoue/miniconda3/envs/SALSA/bin/run_pipeline.py -a wtdbg2_02062024.ctg.fa -l wtdbg2_02062024.ctg.fa.fai -b ../alignment.bed -e GATC,GACTC,GAGTC,GATTC,GAATC -o scaffolds -m yes

#Look at 'input_breaks' file to see locations in contigs that SALSA found errors
