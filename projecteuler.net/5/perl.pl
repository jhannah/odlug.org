use strict;
use 5.10.0;

print <<EOT;

This gets the right answer, but takes 3m 10s on my laptop. 

Brute forcing this one not ideal apparently.  :)

EOT

my $answer = 2519;
ANSWER: while ($answer++) {
   say $answer unless ($answer % 1000000);
   for (2..20) {
      # say "$answer $_";
      next ANSWER if ($answer % $_);
   }
   last;
}
say $answer;



