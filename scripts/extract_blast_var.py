#!/bin/py

#  extract_blast_var.py
#  
#
#  Created by Kieran Chacko on 9/20/17.
#

# Import Modules

import os
import sys
import pandas as pd
from Bio import SeqIO
from Bio.Blast import NCBIXML

# Load arguments
firstarg=sys.argv[1]

# Load fasta file
result_handle = open(firstarg)
blast_records = NCBIXML.read(result_handle)

for alignment in blast_records.alignments:
    
    ID = alignment.title
    ID = ID.replace("Subject_1 ", "")
    
    Contig = blast_records.query
    
    for hsp in alignment.hsps:
        for i in range(len(hsp.query[0:])):
            if hsp.query[i] != hsp.sbjct[i]:
                output = open('./tmp-files/variant/' + str( Contig ) + '.out', "w")
                output.write(ID + "\t" + Contig + "\t" + hsp.sbjct[i] + str(i+1) + hsp.query[i] + "\n")


