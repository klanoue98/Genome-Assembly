#!/bin/bash
#SBATCH -J wtdbg2
#SBATCH -e wtdbg2.consensus.err
#SBATCH -o wtdbg2.consensus.out
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -p long
#SBATCH --mail-user=katherine.lanoue@tamucc.edu
#SBATCH --mail-type=begin                    # email me when the job starts
#SBATCH --mail-type=end                      # email me when the job ends
#SBATCH --time=96:00:00

cd $WORK/red_grouper_genome_assembly
module load wtdbg2

# Recommend running one at a time. Comment out whichever step you don't need

# Assemble genome
wtdbg2 -g 800m -x ccs -i /preprocess/filter/mtdna_filter/A20043_11_m64284e_230305_090942.fa -i /preprocess/filter/mtdna_filter/A20043_11_m64164_230306_083357.fa -i /preprocess/filter/mtdna_filter/A20043_11_m64292e_230226_035559.fa -i /preprocess/filter/mtdna_filter/A20043_11_m64164_230304_232818.fa -i /preprocess/filter/mtdna_filter/A20043_11_m64164_230303_141943.fa -i /preprocess/filter/mtdna_filter/A20043_11_m64164_230302_051904.fa -t 20 -o /wtdbg2_02062024 L 5000 -f 2>&1 | tee my.log

#g= estimated genome size
#x= sequencing technology (css for pacbio)
#i= input long reads sequences file
#o= output files
#t= Number of threads
#L= Choose the longest subread and drop reads shorter (5000 recommended for PacBio)


# consensus
wtpoa-cns -i /wtdbg2_02062024.ctg.lay.gz -t 20 -o /wtdbg2_02062024.ctg.fa -f 2>&1 | tee my_consensus.log
