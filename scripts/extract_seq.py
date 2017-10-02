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
seconarg=sys.argv[2]
thirdarg=sys.argv[3]

# Load fasta file
if seconarg != "rRNA":
    for rec in SeqIO.parse('./' + str(thirdarg) + '/prokka/prokka.faa', 'fasta'):
    
        name = rec.id
        seq = rec.seq
    
        # Match the sequence and contig name
        if name == firstarg:
            output = open('./' + str(thirdarg) + '/tmp-files/' + str(seconarg) + '/' + str( name ) + '.faa', "w")
            output.write(">" + name + "\n" + str(seq))

if seconarg == "rRNA":
    for rec in SeqIO.parse('./' + str(thirdarg) + '/prokka/prokka.rRNA', 'fasta'):
        
        name = rec.id
        seq = rec.seq
        
        # Match the sequence and contig name
        if name == firstarg:
            output = open('./' + str(thirdarg) + '/tmp-files/' + str(seconarg) + '/' + str( name ) + '.fna', "w")
            output.write(">" + name + "\n" + str(seq))
