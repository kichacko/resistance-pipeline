#!/bin/py

#  extract_seq.py
#  
#
#  Created by Kieran Chacko on 9/20/17.
#

# Import Modules
import os
import sys
import pandas as pd
from Bio import SeqIO

# Load arguments
firstarg=sys.argv[1]

# Load fasta file
for rec in SeqIO.parse('./prokka/prokka.faa', 'fasta'):
    
    name = rec.id
    seq = rec.seq
    
    # Match the sequence and contig name
    if name == firstarg:
        output = open('./tmp-files/variant/' + str( name ) + '.faa', "w")
        output.write(">" + name + "\n" + str(seq))

