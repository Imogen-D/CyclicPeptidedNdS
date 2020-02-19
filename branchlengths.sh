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


