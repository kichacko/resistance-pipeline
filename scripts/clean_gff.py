#!/bin/py

#  match_variants.py
#
#
#  Created by Kieran Chacko on 9/20/17.
#

# Import Modules
import pandas as pd
import sys
import os

# Load arguments
firstarg=sys.argv[1]

# Load Files
with open('./' + str(firstarg) + '/prokka/prokka.gff') as inFile:
    with open('./' + str(firstarg) + '/prokka/prokka.gff_clean', 'w') as outFile:
        for line in inFile:
            
            line = line.replace(';', "\t", 1)
            line = line.replace('ID=', '')
            line = line.replace('product=', '\t')
            
            if line.startswith('#'):
                pass
            
            if line.startswith('##FASTA'):
                break
            
            elif not line.startswith('#'):
                outFile.write(line)
