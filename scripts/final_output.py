#!/bin/py

#  final_output.py
#  
#
#  Created by Kieran Chacko on 9/20/17.
#

# Import Modules
import pandas as pd
import sys
import os

# Load homolog.hits
if os.stat("./tmp-files/blastdb/homolog.hits").st_size > 0:
    df = pd.read_csv('./tmp-files/blastdb/homolog.hits',
                      sep = "\t",
                      quotechar='"',
                      header = None)
else:
    df = pd.DataFrame()

# Load variants.output
if os.stat("./tmp-files/nucdiff/variants.output").st_size > 0:
    df2 = pd.read_csv('./tmp-files/nucdiff/variants.output',
                      sep = "\t",
                      header = None)
else:
    df2 = pd.DataFrame()

# Combine variant and homolog hits together
output = pd.concat([df, df2], ignore_index = True)

# Relabel the columns
output.columns = [
    "ID",
    "PROKKA_ID",
    "Variant_Type"
    ]

# Write output
output.to_csv('./out/output.txt', sep='\t', index=False)
