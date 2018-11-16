#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;
use feature 'say';

my $path = $ARGV[0];
my @iter = glob "$path/*";
my $sum = 0;

for (@iter) {
    next if (-d "$_");

    my $line = `wc "$_" | awk '{ print \$1}'`;
    my $name = `wc "$_" | awk '{ print \$NF}'`;
    chomp($name);

    $name =~ s/.*?\/?([^\/]+)\z/$1/;
    print "$name:\t$line";
    $sum += $line;
}

say "\nsum =>\t$sum";
