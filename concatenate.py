#code to concatenate each strain's orthologs

from Bio import SeqIO
import os
import shutil

#Code to move aligned ortholog files corresponding to orthologs in subsetfull.tsv - all orthologs containing all species

with open('subsetfull.tsv') as file:
	for line in file:
		ortholog_id = line.split()
		print(*ortholog_id)
		ortho = "".join([*ortholog_id, "_aligned.fna"])
		print(ortho)
		oldfile = "".join(["/home/imogen/BPRC/EpiAll/aligned/", ortho])
		newfile = "".join(["/home/imogen/BPRC/EpiAll/branchlengths/fullalignments/", ortho])
		shutil.move(oldfile, newfile)
		
#remove one alignment from this ./fullalignments to use as extension file in next part of script. In this example: 0g_0178

directory = "/home/imogen/BPRC/EpiAll/branchlengths/fullalignments"
recs = SeqIO.to_dict(SeqIO.parse("og_0178_aligned.fna", "fasta"))
print(len(recs["C2857"]))
for file in os.listdir(directory):
	new_r = SeqIO.parse(file, "fasta")      
	for r in new_r:                                                  
		recs[r.id] += r.seq
print(len(recs["C2857"])) #test that output is longer than beginning by reasonable margin

SeqIO.write(recs.values(), "concatenated.fna", "fasta")                                          
                                
#raxmlHPC -s ./fullalignments/concatenated.fna -m GTRGAMMA -p 10 -n  fullbranchlengthstree -f e -t ~/windowshare/straintree 
#Use last line to add branch lengths to inputted straintree as produced in different repository: https://github.com/Imogen-D/EpichloeSpeciesTreeProject

