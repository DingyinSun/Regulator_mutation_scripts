for file in ../CD-HIT/*.clstr;
do
cluster=$(grep ">Cluster" ${file} | wc -l)
file1=${file#../CD-HIT/}
file2=${file1%.clstr}
echo "${file2}	${cluster}" >> number_of_cluster.txt;
done
