while read -r p; 
do
annotated_name=$(echo "${p}" | cut -f2)
gene_name=$(echo "${p}" | cut -f1)
cd-hit-est -i aligned_gene_sequences/${annotated_name}.aln.fas -c 1 -s 1 -d 30 -o ${gene_name}_hit;
done < ../get_annotated_name/annotated_name_list.txt
