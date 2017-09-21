#!/bin/sh

#  variant_call.sh
#  
#
#  Created by Kieran Chacko on 9/20/17.
#

##############
# Inputs
##############

# 1: Fasta file

##############
# Load Modules
##############

module purge
module load samtools

##############
# NucDiff
##############

echo "Finding Variants ..."
while read i j k l
do

    cp "./database/${j}.fna" "./tmp-files/nucdiff/"
    samtools faidx "./tmp-files/prokka/prokka.fna" ${i}:${k}-${l} > "./tmp-files/nucdiff/${j}.samtools"
    sed -i "s/$i.*/$j/g" "./tmp-files/nucdiff/${j}.samtools"
    NucDIFF-Annovar.sh  "./tmp-files/prokka/prokka.fna" "./tmp-files/nucdiff/${j}.fna" "./tmp-files/prokka/prokka.gff" "${j}.nucdiff"

    awk -v var="${j}" ' BEGIN{OFS=FS="\t"}
        {if (NR != 1)
            {print var, $0}
        }' "${j}.nucdiff"_Exonic_SNV-OUTPUT > "./tmp-files/nucdiff/${j}.nucdiff"

    rm -r *.nucdiff*
done < ./tmp-files/blastdb/variant.hits

echo "Combining Results ..."
cat ./tmp-files/nucdiff/*.nucdiff >> ./tmp-files/nucdiff/variants.nucdiff

echo "Cleaning Results ..."
python ./scripts/match_variants.py
