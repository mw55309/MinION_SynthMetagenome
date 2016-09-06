#!/bin/bash

source $HOME/.bashrc

# run kraken
kraken -db kraken_bacteria_fungi_120215 --threads 4 --fastq-input --output MockRare.pass.2d.kraken MockRare.pass.2d.fastq

kraken-mpa-report -d kraken_bacteria_fungi_120215 MockRare.pass.2d.kraken  > MockRare.pass.2d.report

