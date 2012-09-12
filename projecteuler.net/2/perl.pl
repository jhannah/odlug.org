use strict;
use 5.10.0;

my $answer;
my ($a, $b) = (1, 1);
while ($b < 4000000) {
   ($a, $b) = ($b, $a + $b);
   $answer += $b unless ($b % 2);
}
say $answer;



