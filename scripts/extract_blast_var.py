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
seconarg=sys.argv[2]
thirdarg=sys.argv[3]

# Load fasta file
result_handle = open(firstarg)
blast_records = NCBIXML.parse(result_handle)

# Ensure there is an empty file in case there are no rRNA variants
output = open('./' + str(thirdarg) + '/tmp-files/' + str(seconarg) + '/empty.out', "w")

for records in blast_records:
    for alignment in records.alignments:
    
        ID = alignment.title
        #        ID = ID.replace("Subject_1 ", "")
        ID = ID.replace(alignment.hit_id + " ", "")
    
        Contig = records.query
    
        for hsp in alignment.hsps:
            for i in range(len(hsp.query[0:])):
                if hsp.query[i] != hsp.sbjct[i]:
                    output = open('./' + str(thirdarg) + '/tmp-files/' + str(seconarg) + '/' + str( ID ) + '.out', "a")
                    output.write(ID + "\t" + Contig + "\t" + hsp.sbjct[i] + str(i+1) + hsp.query[i] + "\n")
