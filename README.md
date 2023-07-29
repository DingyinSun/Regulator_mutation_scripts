# Regulator_mutation_scripts
Assume had already run Abricate to identify the presence and absence of each regulator genes within a population.

### Step 1. Run get_locus_tag.sh
The gene names annotated by Abricate using self-made database is different to annotation by prokka and panaroo, thus it is important to make sure that the nomenclatures are consistent before running these scripts.
 **locus_tag** act as a bridge that allows us to navigate between different naming system. This is because same gene may have different name, but a unique **locus_tag**.
 
For M55_regulator_gene_mutation study, I will get all **locus_tag** for  M55_reference_genome (NZ_CP035430) regulator genes, and use this **locus_tag** to find out the corresponding name annotated by panaroo/prokka. (note: could use other ERR's **locus_tag** , which should gives the same result). 

 **Expected output: locus_tag_list.txt**, list of regulator genes in the first column, and corresponding locus_tag in the second column.
 

### Step 2. Run get_annotated_name.sh
Before running this script, needs to:
1. Copy **gene_presence_absence_roary.csv** (from panaroo) to the directory where this script will run from.
2. Needs to convert the default .csv file to tab-delimited file (.txt). (Can using Excel export function)
3. Run **get_annotated_name.sh**

**Expected output: annotated_name_list.txt**, list of regulator genes annotated by Abricate in the first column, panaroo/prokka annotation in the second column.


### Step 3. Run CD-HIT.sh
Before running this script, needs to:
1. copy **aligned_gene_sequences** folder (from panaroo) to the directory where this script will run from.
2. run **remove_gap_in_alnfas.sh** to remove gap within each .aln.fa file. (Because CD-HIT don't like "-" character).
3. run **CD-HIT.sh**

**Expected output: _hit and _hit.clstr** for each regulator gene. 

Can use: ***for file in *.clstr; do clstr2txt.pl ${file} > ${file%.clstr}.txt; done*** to turn .clstr into a table. 

### Step 4. post-processing CD-HIT result

**number_of_cluster.sh** will gives a **number_of_cluster.txt** file, in which the regulator gene will be in the first column, and number of cluster for this gene in the second column.

**sequence_extraction.sh** will gives 





