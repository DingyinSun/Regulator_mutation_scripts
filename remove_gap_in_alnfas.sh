for file in aligned_gene_sequences/*aln.fas;
do
sed -i "s/-//g" ${file};
done

# needs to remove gap in .aln.fas with NA, because CD-HIT don't like "-"
