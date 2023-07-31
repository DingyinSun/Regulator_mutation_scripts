less ../../M55_two_component_regulators.txt | grep "NZ" > NZ_TCS.txt
mkdir TEST
while read -r p; do
    start=$(echo "${p}" | grep "NZ" | cut -f3)
    end=$(echo "${p}" | grep "NZ" | cut -f4)
    gene=$(echo "${p}" | grep "NZ" | cut -f6)
    mkdir TEST/${gene}
    echo "NZ_CP035430.1	${start}	${end}" > TEST/${gene}/${gene}.bed   
    bedtools getfasta -fi M55_reference_genome.fna -bed TEST/${gene}/${gene}.bed -fo TEST/${gene}/${gene}_out.fa
done < NZ_TCS.txt

for sb in TEST/*/*_out.fa;
do
   for file in ../CD-HIT/aligned_gene_sequences/*;
   do
   sb1=${sb%/*_out.fa}
   file1=${file#../CD-HIT/aligned_gene_sequences/}
   blastn -query ${file} -subject ${sb} -out ${sb1}/${file1}_blast.out;
   done
done

for file in TEST/*/*_blast.out;
do
   if grep -q "Identities" "${file}"; 
   then
   gene1=${file%/*_blast.out}
   gene2=${gene1#TEST/}
   file2=${file#TEST/*/}
        echo "Found 'Identities' for ${gene2} in: ${file2}"
    fi
done
