#!/usr/bin/perl

use lib "/mnt/ris-fas1a/ark1/software/BioPerl-1.6.0";
use lib "/mnt/ark1/software/BioPerl-1.6.0";

# import BioPerl
use Bio::SeqIO;

# d is a hashref which will store kmer counts per sequence
my $d;

# ids is an array of sequence IDs processed
my @ids;

# get FASTA from command line
my $infile = $ARGV[0];

# open
my $in = Bio::SeqIO->new(-file => $infile, -format => 'fasta');

while (my $seqobj = $in->next_seq()) {

	# get sequence id and push into ids
	my $seqid = $seqobj->primary_id;
	push(@ids, $seqid);

	# get sequence and split into single base array
	my $seq = $seqobj->seq;
	my @seq = split(//, $seq);

	# construct 5mers and count
	for ($i=0;$i<scalar(@seq)-4;$i++) {
		my $e = $i+4;
		my $kmer = join("",@seq[$i .. $e]);

		$d->{$kmer}->{$seqid}++;
	}	
}

# first index of hashref is the 5mers
my @k = keys %{$d};

# print titles
print "kmer\t", join("\t", @ids), "\n";

# iterate over kmers
foreach $k (@k) {
	
	# print k and counts from any sequence that contains k
	print $k;
	foreach $f (@ids) {
		print "\t", $d->{$k}->{$f};
	}
	print "\n";
}

