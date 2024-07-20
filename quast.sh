#!/bin/bash
#SBATCH -J quast
#SBATCH -o quast.out
#SBATCH -e quast.err
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 96:00:00
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends

cd $WORK/red_grouper_genome_assembly

quast.py --threads 20 --large   02_preliminary_assembly/emo_32124_hifi/emo_32124_hifi.asm.p_ctg.fa 03_scaffolding/emo_32124_hifi/salsa/scaffolds/scaffolds_FINAL.fasta 04_polish/emo_32124_hifi/pilon/emo_32124_hifi.pilon.fasta
