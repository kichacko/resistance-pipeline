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

# Load variant.nucdiff
if os.stat("./tmp-files/homolog/homolog.hom").st_size > 0:
    df = pd.read_csv('./tmp-files/homolog/homolog.hom',
                     sep = "\t",
                     header = None)
else:
    df = pd.DataFrame()

# Load variant.database
if os.stat("./tmp-files/variant/variant.var").st_size > 0:
    df2 = pd.read_csv('./tmp-files/variant/variant.var',
                      sep = "\t",
                      header = None)
else:
    df2 = pd.DataFrame()

# Combine outputs together
output = pd.concat([df, df2], ignore_index = True)

# Relabel the columns
output.columns = [
                  "ID",
                  "Contig",
                  "Variant_Type"
                  ]

output.to_csv('./out/output.txt', sep='\t', index=False)


