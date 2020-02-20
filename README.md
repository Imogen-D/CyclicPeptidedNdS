# CyclicPeptide Analysis
Repository to calculate dNdS for cyclic peptide associated orthologs, create branchlengths for species trees, and do ancestral state reconstruction

1. Subset full ortho_long file into orthologs associated with CP (orthologsubsetting.R)

2. Use master.sh (with use of prot & geneorthologs.py) to produce dNdS for each ortholog as dNdS.tsv
    
        Empty spaces = too few species

3. Analyse ortholog sequence files in datamonkey MEME & InterProScan
       
       Results in dNdsIII.csv
    
4. Plot dNdS with dNdSplotting.R
    
5. Calculate branch lengths with concatenate.py to do ancestral state reconstruction
       
       Utilses subset ortho_long file containing all orthologs with all 24 strains
       Adds branchlengths to straintree as previously produced
    
6. To calculate ancestral state reconstruction use ancestralCP.R






