#with open('twentyorthos.tsv') as file:
#   ...:     for line in file:
#  ...:         ortholog_id = line.split()
#    ...:         print(*ortholog_id)
#    ...:         ortho = "".join([*ortholog_id, "_aligned.fna"])
#    ...:         print(ortho)
#    ...:         oldfile = "".join(["/home/imogen/BPRC/EpiAll/branchlengths/aligned/", ortho])
#    ...:         newfile = "".join(["/home/imogen/BPRC/EpiAll/branchlengths/twentyalignments/", ortho])
#    ...:         shutil.move(oldfile, newfile)


#!/bin/bash


FILES=./og_*

mkdir ./concat

for file in $FILES
do
base=$(basename ${file} .fna)
echo $base
echo $file
grep -v ">" $file | tr '\n' ' ' | sed -e 's/ //g' > ./concat/${base}.fna
done

#for each species in each file, make new fasta of all sequences for that species


