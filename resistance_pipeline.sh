#!/bin/sh

#  resistance_pipeline.sh
#  
#
#  Created by Kieran Chacko on 9/20/17.
#
#
# This script runs the pipeline. Provide the species (eg. efaecium) and the path to the fasta file

##############
# Input
##############

# 1: Species
# 2: Fasta file

##############
# Scripts
##############

# Run file setup
./scripts/file_setup.sh ${1} ${2}

# Run Blast
./scripts/run_blast.sh

# Call Variants
./scripts/run_blast.sh

##############
# Cleaning
##############

rm -r ./tmp


