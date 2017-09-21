#!/bin/sh

#  file_setup.sh
#  
#
#  Created by Kieran Chacko on 9/18/17.
#

##############
# Inputs
##############

# 1: Species
# 2: Fasta file

##############
# Load Modules
##############

module purge
module load CPAN
module load prokka/1.11
module load barrnap/0.6
module load rnammer/1.2
module load minced/0.2.0
module load signalp/4.1


##############
# Checks
##############

# Check if database exists
if [ ! -d "database" ]
then
    echo "Database directory does not exist"
    exit 1
fi

# Check if out exists
if [ ! -d "out" ]
then
    mkdir "out"
fi

# Check if species is provided
if [ -z ${1+x} ]
then
    echo "Species input not provided: efaecium or efaecalis"
    exit 1
fi

# Check if species is provided
if [ -z ${2+x} ]
then
    echo "Fasta file not provided."
    exit 1
fi


##############
# Set variables
##############

# Set species variable
if [ ${1} = "efaecium" ]
then
    species="Ef1"

elif [${1} = "efaecalis"]
then
    species="Ef2"

fi

# Set fasta variable
fasta=${2}

##############
# Set environment
##############

# Create directories
mkdir   "tmp-files"
mkdir   "./tmp-files/homolog"
mkdir   "./tmp-files/variant"
mkdir   "./tmp-files/rRNA"
mkdir   "./tmp-files/blastdb"
mkdir   "./tmp-files/nucdiff"

# Split database files
cp ./database/${species}-*-Ac-Re*.faa ./tmp-files/homolog
cp ./database/${species}-*-Va-Su*.fna ./tmp-files/variant

cat ./tmp-files/homolog/*.faa >> ./tmp-files/blastdb/homolog.faa
cat ./tmp-files/variant/*.fna >> ./tmp-files/blastdb/variant.fna

##############
# Prokka
##############

# Check if database exists
echo "Checking if prokka annotation exists"
if [ ! -d "./tmp-files/prokka" ]

then
    echo "Prokka annotation doesn't exist...Running Prokka"
    prokka --outdir ./tmp-files/prokka --force --quiet --prefix prokka ${fasta}

elif
    echo "Prokka exists...skipping annotation"

fi

##############
# rRNA
##############

echo "...Running rnammer"
rnammer -S bac -m 'lsu' -f "prokka.23SrRNA" ${fasta}
mv "prokka.23SrRNA" "./tmp-files/rRNA"



