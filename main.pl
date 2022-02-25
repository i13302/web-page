#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

sub dp {
	print Dumper shift @_;
}

sub main {
	my @srcfiles=glob 'src/*';
	
	&dp(@srcfiles);
}


&main;
