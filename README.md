## **resistance-pipeline**<br />
Pipeline for species-specific antibiotic resistance gene annotation. <br />

The annotation considers homologous genes (presence / absence), variants in converved genes, and variants rRNA genes.  <br />

The following species and antibiotics are currently supported: <br />

Species: <br />
  * Enterococcus faecium (Enterococcus faecium DO)
  * Enterococcus faecalis (Enterococcus faecalis V583)
  * Staphylococcus aureus
  * Pseudomonas aeruginosa (Pseudomonas aeruginosa PAO1)

Antibiotics: <br />
  * Erythromycin
  * Clindamycin
  * Quinupristin / dalfopristin
  * Daptomycin
  * Vancomycin
  * Tetracycline
  * Ampicillin
  * Gentamicin
  * Levofloxacin
  * Linezolid
  * Ceftriaxone
  * Streptomycin
  * Penicillin
  * Rifampin
  * Gatifloxacin
  * Ciprofloxacin
  * Trimethoprim / sulfamethoxazole

The list of antibiotic resistance genes and variants were identified in literature searches. For each species, resistance gene sequences were pulled from Genbank, and conserved genes were pulled from reference genomes. <br />

**Usage**
./scripts/resistance_pipeline.sh [species] [fasta file] [prefix]  <br />

Species:
  * Enterococcus faecium = efaecium
  * Enterococcus faecalis = efaecalis
  * Staphylococcus aureus = saureus

Fasta:
  * Contigs or whole genome fasta file

Prefix:
  * Name of output file
  
**Required Modules** <br />
prokka  <br />
rnammer  <br />
blast  <br />
python  <br />

Refere to the attached schematic for the pipeline workflow.  <br />
