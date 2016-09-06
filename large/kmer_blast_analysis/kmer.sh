#!/bin/bash

# calculate 5mer abundance matrices
perl kmer5.pl MockRare.pass.2d.fasta  > MockRare.pass.2D.kmer5

# produce plots
./kmer.R
