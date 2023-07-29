while read -r p; 
do
start=$(echo "${p}" | cut -f3)
gene=$(echo "${p}" | cut -f6)
locustag=$(grep "${start}" /data/projects/punim1921/M55/prokka/annotation/NZ_CP035430.1/*.gff | cut -f9 | grep -oP '(?<=ID=).*?(?=;)')
echo "${gene}	${locustag}" >> locus_tag_list.txt;
done < NZ_TCS.txt
