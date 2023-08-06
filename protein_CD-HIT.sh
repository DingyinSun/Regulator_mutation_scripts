mkdir protein_seq_for_all
while read -r p; do
gene=$(echo "${p}"| cut -f1)
less CD-HIT/${gene}.clstr | cut -f2 > protein_seq_for_all/${gene}.txt
done < post_process_CD-HIT/number_of_cluster.txt

wait

for file in protein_seq_for_all/*.txt;
do
file1=${file#protein_seq_for_all/}
file2=${file1%.txt}
less ${file} | grep -oP '(?<=>).*?(?=\.)' > protein_seq_for_all/${file2}_ID.list;
done 

wait

for file in protein_seq_for_all/*ID.list;
do
name1=${file%_hit_ID.list}
name2=${name1#protein_seq_for_all/}
annotated_name=$(grep ${name2} get_annotated_name/annotated_name_list.txt | cut -f2)
seqtk subseq CD-HIT/aligned_gene_sequences/${annotated_name}.aln.fas ${file} > protein_seq_for_all/${name2}.fa;
done

wait

## Protein translation ###
for file in protein_seq_for_all/*.fa; 
do
name1=${file%.fa}
name2=${name1#protein_seq_for_all/}
transeq -table 11 ${file} protein_seq_for_all/${name2}.pep; 
done

## remove gaps ##
for file in protein_seq_for_all/*.pep; 
do 
sed -i 's/*/ /g' ${file}; 
done

## Protein CD-HIT #######
mkdir protein_CD-HIT
for file in protein_seq_for_all/*.pep;
do
name1=${file%.pep}
name2=${name1#protein_seq_for_all/}
cd-hit -i ${file} -o protein_CD-HIT/${name2}_protein_CD-HIT -c 1 -s 1 -d 30 
done

