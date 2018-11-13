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
# Start Message
##############

echo -e "\n...Running resistance-pipeline on ${2}. \n"

##############
# Scripts
##############

# Run file setup
./scripts/file_setup.sh ${1} ${2} ${3}

# Run Blast
./scripts/run_blast.sh ${3}

# Combined outputs
python ./scripts/clean_gff.py ${3}
python ./scripts/match_variants.py variant ${3}
python ./scripts/match_variants.py rRNA ${3}
python ./scripts/final_output.py ${3}

##############
# End Message
##############

echo -e "\n...resistance-pipeline Complete. \n"
echo -e "\n...Author: Kieran Chacko. \n"
