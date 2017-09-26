## resistance-pipeline
Pipeline for species-specific antibiotic resistance annotation <br />

### Inputs
Species:  <br />
Staphylococcus aureus --> saureus  <br />
Enterococcus faecium  --> efaecium  <br />
Enterococcus faecalis --> efaecalis  <br />
  <br />
fasta file:  <br />
contigs or whole genome fasta file  <br />
  
### Required Modules
prokka  <br />
rnammer  <br />
blast  <br />
python  <br />

### Running the pipeline
Example: ./scripts/resistance_pipeline.sh [species] [fasta file]  <br />

### Pipeline Description
The annotation considers homologous genes (presence / absence), variants and rRNA variants  <br />
Gene database and gene Key is with Kieran.  <br />

