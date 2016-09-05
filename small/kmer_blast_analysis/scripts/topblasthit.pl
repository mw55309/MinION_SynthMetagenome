#!/usr/bin/perl

use lib "/mnt/ark1/software/BioPerl-1.6.0";
use lib "/mnt/ris-fas1a/ark1/software/BioPerl-1.6.0";

# use Bio::Perl
use Bio::SearchIO;

# Rare blast hits
my $in = Bio::SearchIO->new(-file => "Rare5xi15FAA69863_pass.2D.blast", -format => 'blast');

# for each report
while(my $r = $in->next_result) {
	
	# print query name
	print $r->query_name, "\t";

	# get top hit
	my $hit = $r->next_hit;

	# if defined, print it out, otherwise print blank line
	if (defined $hit) {
		print $hit->name, "\t";
		print $hit->description, "\t";

		
		print $hit->significance, "\n";
	} else {
		print "\t\t\n";
	}
}

# Equal blast hits
my $in = Bio::SearchIO->new(-file => "Equal3xi15FAA72444_pass.2D.blast", -format => 'blast');

# for each report
while(my $r = $in->next_result) {
	
	# print query name
	print $r->query_name, "\t";

	# get top hit
	my $hit = $r->next_hit;

	# if defined, print it out, otherwise print blank line
	if (defined $hit) {
		print $hit->name, "\t";
		print $hit->description, "\t";

		
		print $hit->significance, "\n";
	} else {
		print "\t\t\n";
	}
}
