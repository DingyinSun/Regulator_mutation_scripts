while read -r p; do
  number=$(echo "${p}"| cut -f2)
  gene=$(echo "${p}"| cut -f1)
  if [ "${number}" -gt 1 ]; then
    awk -v val='0' '$1 == val' ../CD-HIT/${gene}.clstr > sequence_ID_list/${gene}.txt
  fi
done < number_of_cluster.txt

wait

for file in sequence_ID_list/*.txt;
do
file1=${file#sequence_ID_list/}
file2=${file1%.txt}
less ${file} | grep -oP '(?<=>).*?(?=\.)' > sequence_ID_list/${file2}_ID.list;
done 

wait

for file in sequence_ID_list/*ID.list;
do
name1=${file%_hit_ID.list}
name2=${name1#sequence_ID_list/}
annotated_name=$(grep ${name2} ../get_annotated_name/annotated_name_list.txt | cut -f2)
seqtk subseq ../CD-HIT/aligned_gene_sequences/${annotated_name}.aln.fas ${file} > sequence_ID_list/${name2}.fa;
done

wait

cd sequence_ID_list
for file in *.fa;
do
splitfasta ${file};
done
