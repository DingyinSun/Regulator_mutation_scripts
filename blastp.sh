mkdir blastp_out
for file in translated_peptide/*/*_1.pep;
do
name1=${file#translated_peptide/*/}
name2=${name1%_1.pep}
name3=${file%_1.pep}
needle -asequence ${name3}_2.pep -bsequence ${file} -gapopen 10.0 -gapextend 0.5 -outfile blastp_out/${name2}_blastp.out;
done

wait 

for file in translated_peptide/*/*_1.pep;
do
name1=${file#translated_peptide/*/}
name2=${name1%_1.pep}
name3=${file%_1.pep}
needle -asequence ${name3}_3.pep -bsequence ${file} -gapopen 10.0 -gapextend 0.5 -outfile blastp_out/${name2}_blastp_3.out;
done

## Add more for-loop if there is more than 3 Clusters
