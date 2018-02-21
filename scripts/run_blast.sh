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
# Set variables
##############

# Set prefix variable
prefix=${1}

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
makeblastdb -dbtype 'prot' -in "./${prefix}/tmp-files/blastdb/homolog.faa" -input_type 'fasta' -out "./${prefix}/tmp-files/blastdb/homolog" > "./${prefix}/tmp-files/blastdb/blast_log.txt"

echo -e "\n...Running Blast for homologs. \n"
blastp -db "./${prefix}/tmp-files/blastdb/homolog" -query "./${prefix}/prokka/prokka.faa" -outfmt "6 qseqid sseqid pident length slen evalue" -out "./${prefix}/tmp-files/homolog/homolog.blast"

echo -e "\n...Cleaning Blast Result. \n"
python ./scripts/clean_blast.py homolog ${prefix}

##############
# Variant
##############

echo -e "\n...Making Blast database for variants. \n"
makeblastdb -dbtype 'prot' -in "./${prefix}/tmp-files/blastdb/variant.faa"  -input_type 'fasta' -out "./${prefix}/tmp-files/blastdb/variant" > "./${prefix}/tmp-files/blastdb/blast_log.txt"

echo -e "\n...Running Blast for variants. \n"
blastp -db "./${prefix}/tmp-files/blastdb/variant" -query "./${prefix}/prokka/prokka.faa" -outfmt "6 qseqid sseqid pident length slen evalue" -out "./${prefix}/tmp-files/variant/variant.blast"

echo -e "\n...Cleaning Blast Result. \n"
python ./scripts/clean_blast.py variant ${prefix}

echo -e "\n...Finding variants from Blast. \n"
while read i j k
do

python ./scripts/extract_seq.py "${j}" variant "${prefix}"
blastp -subject "./${prefix}/tmp-files/variant/${i}.faa" -query "./${prefix}/tmp-files/variant/${j}.faa" -outfmt 5 -out "./${prefix}/tmp-files/variant/${i}.blast"
python ./scripts/extract_blast_var.py "./${prefix}/tmp-files/variant/${i}.blast" variant "${prefix}"

done <  "./${prefix}/tmp-files/variant/variant.hits"

cat "./${prefix}/tmp-files/variant/"*.out >> "./${prefix}/tmp-files/variant/variant.blastvar"

##############
# rRNA
##############

echo -e "\n...Making Blast database for rRNA. \n"
makeblastdb -dbtype 'nucl' -in "./${prefix}/tmp-files/blastdb/rRNA.fna"  -input_type 'fasta' -out "./${prefix}/tmp-files/blastdb/rRNA" > "./${prefix}/tmp-files/blastdb/blast_log.txt"

echo -e "\n...Running Blast for variants. \n"
blastn -db "./${prefix}/tmp-files/blastdb/rRNA" -query "./${prefix}/prokka/prokka.rRNA" -outfmt 5 -out "./${prefix}/tmp-files/rRNA/rRNA.blast"

python ./scripts/extract_blast_var.py "./${prefix}/tmp-files/rRNA/rRNA.blast" rRNA "${prefix}"

cat "./${prefix}/tmp-files/rRNA/"*.out >> "./${prefix}/tmp-files/rRNA/rRNA.blastvar"
