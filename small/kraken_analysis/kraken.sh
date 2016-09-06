#!/bin/bash

source $HOME/.bashrc

# run kraken
kraken -db kraken_bacteria_fungi_120215 --threads 4 --fastq-input --output Rare5xi15FAA69863_pass.2D.kraken  Rare5xi15FAA69863_pass.2D.fastq
kraken -db kraken_bacteria_fungi_120215 --threads 4 --fastq-input --output Equal3xi15FAA72444_pass.2D.kraken Equal3xi15FAA72444_pass.2D.fastq

kraken-mpa-report -d kraken_bacteria_fungi_120215 Rare5xi15FAA69863_pass.2D.kraken  > Rare5xi15FAA69863_pass.2D.report
kraken-mpa-report -d kraken_bacteria_fungi_120215 Equal3xi15FAA72444_pass.2D.kraken > Equal3xi15FAA72444_pass.2D.report

