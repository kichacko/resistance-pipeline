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
# Homolog
##############

echo -e "\n...Making Blast database for homologs. \n"
makeblastdb -dbtype 'prot' -in "./tmp-files/blastdb/homolog.faa" -input_type 'fasta' -out "./tmp-files/blastdb/homolog"

echo -e "\n...Running Blast for homologs. \n"
blastp -db "./tmp-files/blastdb/homolog" -query "./prokka/prokka.faa" -outfmt 6 -max_target_seqs 1 -out "./tmp-files/homolog/homolog.blast"

echo -e "\n...Cleaning Blast Result. \n"
python ./scripts/clean-blast.py homolog

##############
# Variant
##############

echo -e "\n...Making Blast database for variants. \n"
makeblastdb -dbtype 'prot' -in "./tmp-files/blastdb/variant.faa"  -input_type 'fasta' -out "./tmp-files/blastdb/variant"

echo -e "\n...Running Blast for variants. \n"
blastp -db "./tmp-files/blastdb/variant" -query "./prokka/prokka.faa" -outfmt 6 -max_target_seqs 1 -out "./tmp-files/variant/variant.blast"

echo -e "\n...Cleaning Blast Result. \n"
python ./scripts/clean-blast.py variant
# Output = .hits

echo -e "\n...Finding variants from Blast. \n"
while read i j k
do

    python ./scripts/extract_seqs.py "${j}"
# Output = PROKKA.faa
    blastp -subject "./tmp-files/variant/${i}.faa" -query "./tmp-files/variant/${j}.faa" -outfmt 5 -out "./tmp-files/variant/${i}.blast"
# OUTPUT = Ef1.blast
    python ./scripts/extract_blast_var.py "./tmp-files/variant/${i}.blast"
# OUTPUT = Ef1.out


done <  "./tmp-files/variant/variant.hits"

cat "./tmp-files/variant/"*.out >> "./tmp-files/variant/variant.blastvar"
