#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

sub dp {
	print Dumper shift @_;
}

sub replace_dir {
	my ($str, $from, $to) = @_;
	$str =~ s/$from\//$to\//;
	return $str;
}

sub replace_ext {
	my ($str, $from, $to) = @_;
	$str =~ s/\.$from$/\.$to/;
	return $str;
}

sub pandoc {
	my $md = shift @_;
	my $ref_cssfiles = shift @_;
	my $html=&replace_dir($md, 'md', 'docs');
	$html = &replace_ext($html, 'md', 'html');
	
	my $cmd = "pandoc --shift-heading-level-by=-1 --self-contained -f markdown -c ".join('-c', @$ref_cssfiles)." -t html5 -o $html $md";
	&dp($cmd);
	system($cmd);
}

sub main {
	my @mdfiles=glob 'md/*';
	my @cssfiles=glob 'css/*';
	
	
	&dp(@mdfiles);
	&dp(@cssfiles);
	
	foreach(@mdfiles) {
		&pandoc($_, \@cssfiles);
	}
}


&main;
