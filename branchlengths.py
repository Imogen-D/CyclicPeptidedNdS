import shutil

with open('subsetfull.tsv') as file:
	for line in file:
		ortholog_id = line.split()
		print(*ortholog_id)
		ortho = "".join([*ortholog_id, "_aligned.fna"])
		print(ortho)
		oldfile = "".join(["/home/imogen/BPRC/EpiAll/aligned/", ortho])
		newfile = "".join(["/home/imogen/BPRC/EpiAll/branchlengths/fullalignments/", ortho])
		shutil.move(oldfile, newfile)






