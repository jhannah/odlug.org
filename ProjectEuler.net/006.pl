use strict;
use 5.10.0;

my $a;
map { $a += $_ ** 2 } 1..100;

my $b;
map { $b += $_ } 1..100;
$b = $b ** 2;

say $b - $a;

