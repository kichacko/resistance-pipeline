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

# Load arguments
firstarg=sys.argv[1]

# Load homolog hits
if os.stat('./' + str(firstarg) + '/tmp-files/homolog/homolog.hom').st_size > 0:
    df = pd.read_csv('./' + str(firstarg) + '/tmp-files/homolog/homolog.hom',
                     sep = "\t",
                     header = None)
else:
    df = pd.DataFrame()

# Load variant hits
if os.stat('./' + str(firstarg) + '/tmp-files/variant/variant.var').st_size > 0:
    df2 = pd.read_csv('./' + str(firstarg) + '/tmp-files/variant/variant.var',
                      sep = "\t",
                      header = None)
else:
    df2 = pd.DataFrame()

# Load rRNA hits
if os.stat('./' + str(firstarg) + '/tmp-files/rRNA/rRNA.var').st_size > 0:
    df3 = pd.read_csv('./' + str(firstarg) + '/tmp-files/rRNA/rRNA.var',
                      sep = "\t",
                      header = None)
else:
    df3 = pd.DataFrame()

# Combine outputs together
output = pd.concat([df, df2, df3], ignore_index = True)

# Relabel the columns
output.columns = [
                  "ID",
                  "Contig",
                  "Variant_Type"
                  ]

output.to_csv('./' + str(firstarg) + '/out/' + str(firstarg) + '.txt', sep='\t', index=False)
