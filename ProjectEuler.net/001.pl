use strict;
use 5.10.0;

my $answer;
for (my $i = 1; $i < 1000; $i++) {
   if ($i % 3 == 0 || $i %5 == 0) {
      $answer += $i;
      # say "+$i = $answer";
   }
}
say $answer;



