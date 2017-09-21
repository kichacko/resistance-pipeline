#!/bin/sh

#  run_blast.sh
#  
#
#  Created by Kieran Chacko on 9/18/17.
#

##############
# Inputs
##############

# 1: fasta file

##############
# Load Modules
##############

module purge
module load blast
module load python
module load py_packages

##############
# BLAST Homolog
##############

echo "Making blastdb"
makeblastdb -dbtype 'prot' -in "./tmp-files/blastdb/homolog.faa" -input_type 'fasta' -out "./tmp-files/blastdb/homolog"

echo "Running Homolog Blast"
blastp -db "./tmp-files/blastdb/homolog" -query "./tmp-files/prokka/prokka.faa" -outfmt 6 -max_target_seqs 1 -out "./tmp-files/blastdb/homolog.out"

echo "Cleaning Blast Result"
python ./scripts/clean-blast.py homolog

##############
# BLAST variant
##############

echo "Making blastdb"
makeblastdb -dbtype 'nucl' -in "./tmp-files/blastdb/variant.fna"  -input_type 'fasta' -out "./tmp-files/blastdb/variant"

echo "Running Variant Blast"
blastn -db "./tmp-files/blastdb/variant" -query "./tmp-files/prokka/prokka.fna" -outfmt 6 -max_target_seqs 1 -out "./tmp-files/blastdb/variant.out"

echo "Cleaning Blast Result"
python ./scripts/clean-blast.py variant
