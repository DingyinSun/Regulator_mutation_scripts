# Regulator_mutation_scripts
Scripts used to extract regulator genes, and identify and classify mutation of the extracted regulator gene.

Assume had already run Abricate to identify the presence and absence of regulator genes of interest, because these scripts are relying on the Abricate output.

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

### It is worth to run double_check_nomanclature.sh before running CD-HIT.sh to check if panaroo-name and Abricate-name is correspond. **Please note: double_check_nomanclature.sh may run for more than 2 hrs.....**


### Step 3. Run CD-HIT.sh   with (-c 1 -s 1)
Before running this script, needs to:
1. copy **aligned_gene_sequences** folder (from panaroo) to the directory where this script will run from.
2. run **remove_gap_in_alnfas.sh** to remove gap within each .aln.fa file. (Because CD-HIT don't like "-" character).
3. run **CD-HIT.sh**

**Expected output: _hit and _hit.clstr** for each regulator gene. 

Can use: **for file in .clstr; do clstr2txt.pl ${file} > ${file%.clstr}.txt; done** to turn .clstr into a table. 

### Step 4. post-processing CD-HIT result

**number_of_cluster.sh** will gives a **number_of_cluster.txt** file, in which the regulator gene will be in the first column, and number of cluster for this gene in the second column.

**sequence_extraction.sh** will gives:  (NOTE: this will only extract ERRs that have more than 1 Clusters!) 
1. **.txt** file, that contains a list of unprocessed representative ERRs. 
2. **.list** file, that contains a list of processed representative ERRs. 
3. **.fa** file, that contains representative ERRs and its nucleotide sequences.
4. **_split_files** folder that contains multiple fasta files, each containing a representative ERRs and its nucleotide sequence.

**get_ERR_for_each_Cluster.sh** will gives **Cluster_ERR_list.txt** file, with genes in the first column, a representative ERRs from each Cluster in column 2,3....

**translate_nucleic_acid.sh** will translates nucleotide sequence from each **.fasta** to protein sequence. All translated protein sequence can be found in **translated_peptide** folder.

**blastp.sh** will compare protein sequences for each Cluster's representative ERRs. The output can be found in **blastp_out** folder. 

**characterise_mutation_type.sh** will characterise mutations into three sub-categories, Synonymous_mutation, Nonsynonymous_mutation, and other_mutation. The result can be found in **characterise_mutation_type.txt**

**ready_for_R.sh** helps convert and concatenate **.clstr** file in more R friendly format.
It is recommended to copy all **.clstr** to an empty folder that contain **ready_for_R.sh**, because this script will produce many many .csv files.







