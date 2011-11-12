#!/usr/bin/env perl
use strict;
use warnings;

# These two lines may not turn out to be neccessary, depending upon the
# final game environment..
use FindBin qw($Bin);
use lib "$Bin/CPAN/AI-Pathfinding-AStar-0.10/lib";
use lib "$Bin/CPAN/Heap-0.80/lib";

open my $log, '>', 'log.txt' or die;
close $log;

# The implementation of your bot exists in MyBot.pm
use MyBot;
MyBot->new->run;

1;
