use strict;
use 5.10.0;

my $answer;
foreach my $a (100..999) {
   foreach my $b (100..999) {
      if ($a * $b eq (reverse split '', $a * $b)) {
         # say "$a * $b = " . $a * $b;
         if ($a * $b > $answer) {
            $answer = $a * $b;
         }
      }
   }
}
say $answer;



