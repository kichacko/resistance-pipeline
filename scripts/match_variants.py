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
seconarg=sys.argv[2]

# Load variant.nucdiff
df = pd.read_csv('./' + str(seconarg) + '/tmp-files/' + str(firstarg) + '/' + str(firstarg) + '.blastvar',
                 sep = "\t",
                 header = None)

# Load variant.database
df2 = pd.read_csv('./database/variants.txt',
                  sep = "\t",
                  header = None)

# Relabel the columns
df.columns = [
              "ID",
              "Contig",
              "Codon"
              ]

df2.columns = [
               "ID",
               "Codon"
               ]

df = pd.merge(df, df2, on=['ID', 'Codon'], how='inner')
df = df.loc[:, ['ID','Contig','Codon']]
df.to_csv('./' + str(seconarg) + '/tmp-files/' + str(firstarg) + '/' + str(firstarg) + '.var', sep='\t', index=False, header=False)
