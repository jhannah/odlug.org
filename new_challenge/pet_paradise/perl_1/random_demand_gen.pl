#!/usr/bin/perl

use strict;
use Class::Date qw( date );
local $Class::Date::DATE_FORMAT="%Y%m%d";

my $begin = date "2009-06-15";

for (1..40) {
   my $customer_id = $_;
   my $dollars = sprintf("%0.2f", rand(200) + 20);
   my $start = plus_rand($begin);
   my $end =   plus_rand($start);
   printf("%s|%s|%s-%s|", $customer_id, $dollars, $start, $end);
   for (1 .. (int(rand(3) + 1))) {
      my $pet = int(rand(2)) ? "DOG" : "CAT";
      my $weight = int(rand(70)) + 15;
      print "$weight pound $pet|";
   }
   print "\n";
}

sub plus_rand {
   my ($date) = @_;
   return $date + (int(rand(4)) . "D");
}
