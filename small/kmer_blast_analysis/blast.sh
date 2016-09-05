#!/bin/bash

# using ncbi-blast-2.2.27+
blastn -num_descriptions 1 -num_alignments 1 -db all.bacteria.fna -query Rare5xi15FAA69863_pass.2D.fasta  -num_threads 4 -out Rare5xi15FAA69863_pass.2D.blast
blastn -num_descriptions 1 -num_alignments 1 -db all.bacteria.fna -query Equal3xi15FAA72444_pass.2D.fasta -num_threads 4 -out Equal3xi15FAA72444_pass.2D.blast

# extract top hit
perl topblasthit.pl > blast_hits.txt

