


3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
#!/bin/bash
#SBATCH --partition=compute         # Queue selection
#SBATCH --job-name=serial_job       # Job name
#SBATCH --mail-type=END             # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=email@whoi.edu  # Where to send mail
#SBATCH --ntasks=1                  # Run on a single CPU
#SBATCH --mem=1gb                   # Job memory request
#SBATCH --time=00:15:00             # Time limit hrs:min:sec
#SBATCH --output=serial_job_%j.log  # Standard output/error

pwd; hostname; date

module load bio
module load blast

makeblastdb -in Data/UCYN-A_16S_BBig_chloroplast16S.fasta -input_type fasta -dbtype nucl -out UCYN_A -title "UCYN_A"
blastn –db UCYN_A –query nt.fsa –out results.out -outfmt 6

python /vortexfs1/scratch/username/SLURM/graph_template.py

date
