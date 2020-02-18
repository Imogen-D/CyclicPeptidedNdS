#!/bin/bash

mkdir ./genes
mkdir ./proteins
mkdir ./orthodir

python3 geneorthologs.py subsetCP.tsv seq_map.tsv 1 ./genes/
python3 protorthologs.py subsetCP.tsv prot_seq_map.tsv 1 ./proteins/

#arguments for above; ortho_subset, seq_files, minimum species, outdir

#created gene and protein files in seperate files, following code to 
#seperate by orthogroup

for file in ./proteins/*
do
filebase=$(basename "$file" _proteins.fna)
mkdir ./orthodir/$filebase
mv ./proteins/${filebase}_proteins.fna ./orthodir/$filebase
rm -d ./proteins
done

for file in ./genes/*
do
filebase=$(basename "$file" _genes.fna)
mv ./genes/${filebase}_genes.fna ./orthodir/$filebase
rm -d ./genes
done

mkdir ./orthodir/trees

for d in ./orthodir/og_*;
do
echo ${d}
e=$(basename ${d})
mafft --thread 10 ${d}/${e}_proteins.fna > ${d}/${e}_proteins_ali.faa
/home/david/funannotate/util/pal2nal.pl -output paml ${d}/${e}_proteins_ali.faa ${d}/${e}_genes.fna > ${d}/${e}_codon.paml
/home/david/funannotate/util/pal2nal.pl -output fasta ${d}/${e}_proteins_ali.faa ${d}/${e}_genes.fna > ${d}_codon.fasta
raxmlHPC -m GTRGAMMA -n ${e}_tmp -s ${d}_codon.fasta -p91812
/home/david/miniconda/bin/ete3 evol --codeml_binary /home/david/miniconda/bin/codeml --alg ${d}/${e}_codon.paml -t RAxML_bestTree.${e}_tmp --models "M0" -o ${d}/codeml --clear_all --codeml_param cleandata,1 --slr_binary /home/david/.etetoolkit/ -C 10 > ${d}/${e}ete.log
n=`tail -n1 ${d}/${e}ete.log | cut -f2 -d":"`
echo $e $n >> dNdS.tsv
mv ./orthodir/${e}_codon.fasta ${d}/ #current script creates into primary directory
mv RAxML_b* ./orthodir/trees
rm RAxML*
done

# 1. We use mafft to align proteins
# 2. We use pal2nal to make codon-alignments in paml and fasta format
# 3. We use RAXML to estimate a tree from the codons
# 4. We use ete3 to automate paml dNdS analysis
# 5. Finally, we do some bash hackery to add a row to a dNdS file
# 6. Remove excess files

