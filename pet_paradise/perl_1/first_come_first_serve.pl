#!/usr/bin/perl

use strict;
use Kennel;
use Reservations;

my $kennel = Kennel->new();
my $reservations = Reservations->new();
while (my $res = $reservations->next) {
   if ($kennel->reserve($res)) {
      print $res->raw . " reserved.\n";
   } else {
      print $res->raw . " rejected.\n";
   }
}
print $kennel->books;



