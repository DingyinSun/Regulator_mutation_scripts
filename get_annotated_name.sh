while read -r p; 
do
locustag=$(echo "${p}"| cut -f2)
gene=$(echo "${p}" | cut -f1)
annotated_name=$(grep "${locustag}" gene_presence_absence_roary.txt | cut -f1)
echo "${gene}	${annotated_name}" >> annotated_name_list.txt;
done < ../get_NZ_locus_tag/locus_tag_list.txt

# the gene_presence_absence_roary should be tab-delimited file, not the default .csv file.
# Can convert the default .csv file to tab-delimited file (.txt) using Excel export function. 
