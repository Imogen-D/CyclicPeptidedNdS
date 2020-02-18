from Bio import SeqIO
import os

directory = "/home/imogen/BPRC/EpiAll/branchlengths/fullalignments"
recs = SeqIO.to_dict(SeqIO.parse("og_0178_aligned.fna", "fasta"))
print(len(recs["C2857"]))
for file in os.listdir(directory):
	new_r = SeqIO.parse(file, "fasta")      
	for r in new_r:                                                  
		recs[r.id] += r.seq
#recs["C2857"]    
print(len(recs["C2857"]))

SeqIO.write(recs.values(), "concatenated.fna", "fasta") 

#! head /tmp/test.fa                                              
                                

#make directory with all but one in it
#og_0161

#raxmlHPC -s ./fullalignments/concatenated.fna -m GTRGAMMA -p 10 -n  fullbranchlengthstree -f e -t ~/windowshare/straintree 


