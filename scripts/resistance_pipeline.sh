#!/bin/sh

#  abxr_annotation_pipeline.sh
#  
#
#  Created by Kieran Chacko on 9/20/17.
#

##############
# Load Modules
##############

module purge
module load python
module load py_packages

##############
# Scripts
##############

# Run file setup
./scripts/file_setup.sh ${1} ${2}

# Run Blast
./scripts/run_blast.sh

# Combined outputs
python ./scripts/match_variants.py
python ./scripts/final_output.py

##############
# Cleaning
##############

mv ./out/output.txt ./out/"${3}-Resistance-Profile.txt"
rm -r ./tmp-files
