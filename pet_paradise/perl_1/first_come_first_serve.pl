#!/usr/bin/perl

use strict;
use Kennel;
use Reservations;

my $kennel = Kennel->new();
my $reservations = Reservations->new();
while (my $res = $reservations->next) {
   if ($kennel->reserve($res)) {
      print $res->id . " reserved.\n";
   } else {
      print $res->id . " rejected.\n";
   }
}

print "\n\n";
print $kennel->report;



