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

# Load variant.nucdiff
df = pd.read_csv('./tmp-files/nucdiff/variants.nucdiff',
                  sep = "\t",
                  header = None)

# Load variant.database
df2 = pd.read_csv('./database/variants.txt',
                  sep = "\t",
                  header = None)

# Relabel the columns
df.columns = [
    "ID",
    "PROKKA_ID",
    "Variant_Type",
    "Contig",
    "Var_Start",
    "Var_End",
    "Start_Nuc",
    "End_Nuc",
    "Blank",
    "Codon",
    "Description"
    ]

df2.columns = [
    "ID",
    "Codon"
    ]

# Match variants to the database and write output
df = pd.merge(df, df2, on=['ID', 'Codon'], how='inner')
df = df.loc[:, ['ID','PROKKA_ID','Codon']]
df.to_csv('./tmp-files/nucdiff/variants.output', sep='\t', index=False, header=False)

