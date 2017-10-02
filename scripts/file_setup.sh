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
# 3: Prefix

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
    echo "Error: Database directory does not exist"
    exit 1
fi

# Check if species is provided
if [ -z ${1+x} ]
then
    echo "Error: Species input not provided: efaecium or efaecalis"
    exit 1
fi

# Check if FASTA is provided
if [ -z ${2+x} ]
then
    echo "Error: Fasta file not provided. abxr_annotation_pipeline.sh [species] [fasta] [prefix]"
    exit 1
fi

# Check if prefix is provided
if [ -z ${3+x} ]
then
    echo "Error: Prefix not provided. abxr_annotation_pipeline.sh [species] [fasta] [prefix]"
    exit 1
fi

##############
# Set variables
##############

# Set species variable
if [ ${1} = "efaecium" ]
then
    echo -e "\n...Species set as Enterococcus faecium\n"
    species="Ef1"

elif [${1} = "efaecalis"]
then
    echo -e "\n...Species set as Enterococcus faecalis\n"
    species="Ef2"

fi

# Set fasta variable
fasta=${2}

# Set prefix variable
prefix=${3}

##############
# Set environment
##############

# Create directories
mkdir   "./${prefix}"
mkdir   "./${prefix}/out/"
mkdir   "./${prefix}/tmp-files"
mkdir   "./${prefix}/tmp-files/homolog"
mkdir   "./${prefix}/tmp-files/variant"
mkdir   "./${prefix}/tmp-files/rRNA"
mkdir   "./${prefix}/tmp-files/blastdb"

# Split database files
cp ./database/${species}-*-Ac-Re*.faa      "./${prefix}/tmp-files/homolog"
cp ./database/${species}-*-Va-Su*.faa      "./${prefix}/tmp-files/variant"
cp ./database/${species}-*-*rRNA*.fna  "./${prefix}/tmp-files/rRNA"

cat ./${prefix}/tmp-files/homolog/*.faa >> "./${prefix}/tmp-files/blastdb/homolog.faa"
cat ./${prefix}/tmp-files/variant/*.faa >> "./${prefix}/tmp-files/blastdb/variant.faa"
cat ./${prefix}/tmp-files/rRNA/*.fna >>    "./${prefix}/tmp-files/blastdb/rRNA.fna"

##############
# Prokka
##############

# Check if database exists
echo -e "\n...Checking if prokka annotation exists"
if [ ! -d "./${prefix}/prokka" ]

then
    echo -e "\n...Prokka annotation doesn't exist. Running Prokka now. \n"
    prokka --outdir ./${prefix}/prokka --force --quiet --prefix prokka ${fasta}

else
    echo -e "\n...Prokka exists. Skipping Prokka annotation. \n"

fi

##############
# rRNA
##############

echo -e "\n...Running rnammer. \n"
rnammer -S bac -m 'lsu' -f "prokka.rRNA" ${fasta}
mv "prokka.rRNA" "./${prefix}/prokka/"
