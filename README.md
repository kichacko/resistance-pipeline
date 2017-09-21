## resistance-pipeline
Pipeline for species-specific antibiotic resistance annotation

### Inputs
species:
Staphylococcus aureus --> saureus
Enterococcus faecium  --> efaecium
Enterococcus faecalis --> efaecalis
  
fasta file:
contigs or whole genome fasta file
  
### Required Modules
prokka
rnammer
NucDIFF
annovar
samtools
blast
python

### Running the pipeline
Example: ./scripts/resistance_pipeline.sh [species] [fasta file]

### Pipeline Description
The annotation considers homologous genes (presence / absence), variants and rRNA variants
Gene database and gene Key is with Kieran.

