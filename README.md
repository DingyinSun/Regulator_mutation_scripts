# Regulator_mutation_scripts
Assume had already run Abricate to identify the presence and absence of each regulator genes within a population.

### Step 1. Run get_locus_tag.sh
The gene names annotated by Abricate using self-made database is different to annotation by prokka and panaroo, thus it is important to make sure that the nomenclatures are consistent before running these scripts.
 **locus_tag** act as a bridge that allows us to navigate between different naming system. This is because same gene may have different name, but a unique **locus_tag**.
For M55_regulator_gene_mutation study, I will get all **locus_tag** for  M55_reference_genome (NZ_CP035430) regulator genes, and use this **locus_tag** to find out the corresponding name annotated by panaroo/prokka. (note: could use other ERR's **locus_tag** , which should gives the same result). 

 

### Step 2. Run get_annotated_name.sh




### Step 3. Run CD-HIT.sh



### Step 4. post-processing CD-HIT result
