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
seconarg=sys.argv[2]

# Load homolog hits
df = pd.read_csv('./' + str(seconarg) + '/tmp-files/' + str(firstarg) + '/' + str( firstarg ) + '.blast',
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
df = df.drop_duplicates(subset = ['ID', 'Contig'], keep = 'last')


if firstarg == "homolog":
    df = df.loc[:, ['ID', 'Contig', 'Percent_ID']]
    df.to_csv('./'  + str(seconarg) + '/tmp-files/homolog/' +str(firstarg) + '.hom', sep='\t', index=False, header=False)

elif firstarg == "variant":
    df = df.loc[:, ['ID', 'Contig']]
    df.to_csv('./' + str(seconarg) + '/tmp-files/variant/' +str(firstarg) + '.hits', sep='\t', index=False, header=False)

elif firstarg == "rRNA":
    df = df.loc[:, ['ID', 'Contig']]
    df.to_csv('./' + str(seconarg) + '/tmp-files/rRNA/' +str(firstarg) + '.hits', sep='\t', index=False, header=False)
