#!/bin/env bash
#SBATCH --job-name=Featuretime
#SBATCH --time=20:00:00
#SBATCH --mem=20G
#SBATCH --ntasks=1
#SBATCH --partition=short,gpu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=thiyanga.talagala@monash.edu
#SBATCH --output=featuretime.txt
module load R/3.5.1
R --vanilla < featuretime.R > featuretime.txt