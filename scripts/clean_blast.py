#!/bin/py

#  clean_blast.py
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

# Load homolog hits
df = pd.read_csv('./tmp-files/blastdb/' + str( firstarg ) + '.out',
                  sep = "\t",
                  header = None)

# Relabel the columns
df.columns = [
    "Contig",
    "ID",
    "Percent_ID",
    "Length",
    "Mismatch",
    "Gap_Open",
    "Query_Start",
    "Query_End",
    "Subject_Start",
    "Subject_End",
    "E_Value",
    "Bitscore"
    ]

# Sort the data by percent identity
df = df.sort_values(by = ['Percent_ID'])
df = df.loc[df['Percent_ID'] >= 90]
df = df.loc[df['E_Value'] <= 1e-10]
df = df.drop_duplicates(subset = ['ID'], keep = 'last')

# Write outputs
if firstarg == "homolog":
    df = df.loc[:, ['ID', 'Contig']]
    df['Type'] = "Homolog"
    df.to_csv('./tmp-files/blastdb/' +str( firstarg ) + '.hits', sep='\t', index=False, header=False)
    
elif firstarg == "variant":
    df = df.loc[:, ['Contig', 'ID','Query_Start','Query_End']]
    df.to_csv('./tmp-files/blastdb/' +str( firstarg ) + '.hits', sep='\t', index=False, header=False)
