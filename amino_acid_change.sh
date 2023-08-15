## amino_acid_change.sh #####
## The TCS_RR_Nonsynonymous mutation study is an extension of previous Regulator_mutation study, by which all input files of amino_acid_change.sh are from Regulator_mutation study (please refer to https://github.com/DingyinSun/Regulator_mutation_scripts)

file1=${1:-DEFAULTVALUE} # summary_of_mutation.txt
file2=${2:-DEFAULTVALUE} # blast_out folder
file3=${3:-DEFAULTVALUE} # translated_peptide folder
file4=${4:-DEFAULTVALUE} # ready_for_R folder

grep "Nonsynonymous_mutation" ${file1} | cut -f1 > Nonsynonymous_mutation_list.txt
mkdir snp-sites

## run snp-sites ###
while read -r p;
do
pep1=$(grep " -asequence" ${file2}/${p}.out | sed 's/.*\///')
pep2=$(grep " -bsequence" ${file2}/${p}.out | sed 's/.*\///')
gene=${pep1%_*.pep}
gene_cluster=${pep1%.pep}
any2fasta ${file3}/${gene}/${pep1} ${file3}/${gene}/${pep2} > ${file3}/${gene}/combined_${gene_cluster}.pep
    for file in ${file3}/${gene}/combined_*.pep;
    do
    sed -i '/>/!s/N/J/g' ${file} # change every "N" and "J" for every line, except for line that contain ">"
    done
snp-sites -v -o snp-sites/${gene_cluster}.vcf ${file3}/${gene}/combined_${gene_cluster}.pep
done < Nonsynonymous_mutation_list.txt

## Summarise the snp-sites output ##
for file in snp-sites/*.vcf;
do
gene1=${file#snp-sites/}
gene2=${gene1%.vcf}
less ${file} | grep -E '^1[[:space:]]' > ${gene2}.list
    while read -r p;
    do 
    A1=$(echo "${p}" | cut -f4)
    A2=$(echo "${p}" | cut -f5)
    position=$(echo "${p}" | cut -f2)
    echo -e "${gene2}\t${A1}${position}${A2}" >> ${gene2}_AA_change.txt
    done < ${gene2}.list
done

rm *.list
rm Nonsynonymous_mutation_list.txt

### modify previous ready_for_R output ##### 
cp -r ${file4} . 
for file in *.txt;
do
gene=${file%_*_AA_change.txt}
cluster=$(echo "${file}" | grep -oP '(?<=_)[0-9]+(?=_AA_)')
grep "Cluster${cluster}" ready_for_R/${gene}_hit_Cluster.csv >> ${gene}.csv
#sed -i "/Cluster${cluster}/d" ready_for_R/${gene}_hit_Cluster.txt  
done

## grep for "Cluster1" and add to pre-existing file
for file in *.csv;
do
name1=${file%.csv}
grep -w "Cluster1" ready_for_R/${name1}_*.csv >> ${file}
done

## Add header
for file in *.csv;
do
name=${file%.csv}
sed -i "1i Identifier,${name}" ${file}
done

##END
# Now, you can copy all .csv file to your local machine, and import that into R. 