
mkdir translated_peptide
for file in sequence_ID_list/*/*.fasta;
do
name1=${file#*_files/}
name2=${name1%.fasta}
name3=${name2%_*}
mkdir translated_peptide/${name3}
transeq -table 11 ${file} translated_peptide/${name3}/${name2}.pep; 
done
