#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;
use feature 'say';

my $path = $ARGV[0];
my $opt = $ARGV[1];
my @iter = glob "$path/*";
my $line_sum = 0;
my $word_sum = 0;

for (@iter) {
    next if (-d "$_");

    my $line = `wc "$opt" "$_" | awk '{ print \$1}'`;
    my $word = `wc "$opt" "$_" | awk '{ print \$2}'`;
    my $name = `wc "$opt" "$_" | awk '{ print \$NF}'`;
    chomp($name);
    chomp($line);
    chomp($word);

    $name =~ s/.*?\/?([^\/]+)\z/$1/;
    print "$name =>\twords: $word\tlines: $line";
    $line_sum += $line;
    $word_sum += $word;
}

say "\n";
say "Words total:\t$word_sum";
say "Lines total:\t$line_sum";
