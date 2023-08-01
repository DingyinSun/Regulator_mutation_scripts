cp ../CD-HIT/*.clstr .

for file in *.clstr;
do
n=$(grep ">Cluster" ${file} | wc -l)
n_1=$(expr ${n} + 1)
echo ">Cluster ${n}" >> ${file}
grep -Pzo "(?s)(?<=>Cluster 0\n).*?(?=\n>Cluster 1)" ${file} | cut -f2 | grep -oP '(?<=>).*?(?=;)'| awk -v OFS='\t' '{print $0, "Cluster1"}' > ${file%.clstr}_Cluster.txt
grep -Pzo "(?s)(?<=>Cluster 1\n).*?(?=\n>Cluster 2)" ${file} | cut -f2 | grep -oP '(?<=>).*?(?=;)'| awk -v OFS='\t' '{print $0, "Cluster2"}' >> ${file%.clstr}_Cluster.txt 
grep -Pzo "(?s)(?<=>Cluster 2\n).*?(?=\n>Cluster 3)" ${file} | cut -f2 | grep -oP '(?<=>).*?(?=;)'| awk -v OFS='\t' '{print $0, "Cluster3"}' >> ${file%.clstr}_Cluster.txt
name=${file%_hit.clstr}
sed -i "1i Identifier\t${name}" ${file%.clstr}_Cluster.txt
done

rm *.clstr

for file in *.txt;
do
sed -i "s/NZ_CP035430.1/Reference/g" ${file};
done

for file in *.txt;
do
less ${file} | tr '\t' ',' > ${file%.txt}.csv;
done

rm *.txt

## add more "grep -Pzo" if there is more than 3 Clusters
