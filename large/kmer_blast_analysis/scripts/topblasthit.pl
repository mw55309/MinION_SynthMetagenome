#!/usr/bin/perl

# use Bio::Perl
use Bio::SearchIO;

# Rare blast hits
my $in = Bio::SearchIO->new(-file => "MockRare.pass.2d.blast", -format => 'blast');

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

