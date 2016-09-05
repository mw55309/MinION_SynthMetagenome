#!/bin/bash

# calculate 5mer abundance matrices
perl kmer5.pl Rare5xi15FAA69863_pass.2D.fasta  > Rare5xi15FAA69863_pass.2D.kmer5
perl kmer5.pl Equal3xi15FAA72444_pass.2D.fasta > Equal3xi15FAA72444_pass.2D.kmer5

# produce plots
./kmer.R
