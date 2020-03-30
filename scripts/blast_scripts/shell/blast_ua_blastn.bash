#!/bin/bash
#SBATCH --partition=compute         # Queue selection
#SBATCH --job-name=b_search_job       # Job name
#SBATCH --mail-type=END             # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=msantos@whoi.edu  # Where to send mail
#SBATCH --ntasks=1                  # Run on a single CPU
#SBATCH --mem=5gb                   # Job memory request
#SBATCH --time=24:00:00             # Time limit hrs:min:sec
#SBATCH --output=b_search_job_%j.log  # Standard output/error

pwd; hostname; date

module load bio
module load blast

blastn -db UCYN_A -query data/mvco_blast_bact.fasta -out results/results_mvco_seq_18_Mar.out -outfmt 6

date
