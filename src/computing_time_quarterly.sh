#!/bin/env bash
#SBATCH --job-name=Qtime
#SBATCH --time=20:00:00
#SBATCH --mem=100G
#SBATCH --ntasks=1
#SBATCH --partition=short,gpu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=thiyanga.talagala@monash.edu
#SBATCH --output=computing_time_quarterly.txt
module load R/3.5.1
R --vanilla < computing_time_quarterly.R > computing_time_quarterly.txt