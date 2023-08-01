for file in blastp_out/*.out;
do 
Identity=$(less ${file} | grep "Identity" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
Similarity=$(less ${file} | grep "Similarity" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
Gaps=$(less ${file} | grep "Gaps" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
name1=${file#blastp_out/}
name2=${name1%.out}
 if [ $(echo "${Identity} == 100.0 && ${Gaps} == 0.0" | bc -l) -eq 1 ];then
  echo -e "${name2}\tNonsynonymous_mutation" >> characterise_mutation_type.txt
 elif [ $(echo "${Gaps} == 0.0 && ${Identity} != 100.0" | bc -l) -eq 1 ];then
  echo -e "${name2}\tSynonymous_mutation" >> characterise_mutation_type.txt
 else
  echo -e "${name2}\tother_mutation" >> characterise_mutation_type.txt
 fi
done


for file in blastp_out/*.out;
do
number1=$(less ${file} | grep "Identity" | grep -oE '[0-9]+/' | grep -oE '[0-9]+')
number2=$(less ${file} | grep "Identity" | grep -oE '/[0-9]+' | grep -oE '[0-9]+')
diff=$(expr ${number2} - ${number1})
file1=${file#blastp_out/}
file2=${file1%.out}
echo -e "${file2}\t${diff}" >> number_of_mutation.txt;
done

#sort -k1 characterise_mutation_type.txt > sorted_file1.txt
#sort -k1 number_of_mutation.txt > sorted_file2.txt
#join -1 1 -2 1 sorted_file1.txt sorted_file2.txt > summary_of_mutation.txt
join -t $'\t' -1 1 -2 1 characterise_mutation_type.txt number_of_mutation.txt > summary_of_mutation.txt
sed -i '1i Gene\tTypes\tchange_in_AA' summary_of_mutation.txt
