for file in blastp_out/*.out;
do 
Identity=$(less ${file} | grep "Identity" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
Similarity=$(less ${file} | grep "Similarity" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
Gaps=$(less ${file} | grep "Gaps" | sed 's/.*(\([^)]*\)).*/\1/' | tr -d '%')
name1=${file#blastp_out/}
name2=${name1%.out}
 if [ $(echo "${Identity} == 100.0 && ${Gaps} == 0.0" | bc -l) -eq 1 ];then
  echo -e "${name2}\tSynonymous_mutation" >> characterise_mutation_type.txt
 elif [ $(echo "${Gaps} == 0.0 && ${Identity} != 100.0" | bc -l) -eq 1 ];then
  echo -e "${name2}\tNonsyonymous_mutation" >> characterise_mutation_type.txt
 else
  echo -e "${name2}\tother_mutation" >> characterise_mutation_type.txt
 fi
done
