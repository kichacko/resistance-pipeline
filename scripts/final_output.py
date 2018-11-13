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

# Load gff_clean file
if os.stat('./' + str(firstarg) + '/prokka/prokka.gff_clean').st_size > 0:
    df4 = pd.read_csv('./' + str(firstarg) + '/prokka/prokka.gff_clean',
                      sep = "\t",
                      header = None)

else:
    print ("Error with your gff file")

# Combine outputs together
output = pd.concat([df, df2, df3], ignore_index = True)

output.columns = [
                  "ID",
                  "PROKKA_ID",
                  "Variant_Type",
                  "Percent_Aligned"
                  ]

# Annotate the output
df4.columns = [
               "Feature",
               "Prodigal",
               "CDS",
               "Start",
               "Stop",
               ".",
               "Strand",
               "0",
               "PROKKA_ID",
               "NOTES",
               "DESCRIPTION"
               ]

output = pd.merge(output, df4, how = 'left', on = "PROKKA_ID")
output = output[["ID", "PROKKA_ID", "Feature", "Start", "Stop", "Variant_Type", "DESCRIPTION"]]

# Output
output.to_csv('./' + str(firstarg) + '/out/' + str(firstarg) + '.txt', sep='\t', index=True)
