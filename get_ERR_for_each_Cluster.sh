for file in ../CD-HIT/*_hit;
do
name1=${file#../CD-HIT/}
name2=${name1%_hit}
ID=$(less ${file} | grep ">")
echo "${name2}	${ID}" >> Cluster_ERR_list.txt; 
done
