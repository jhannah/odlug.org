#!/usr/bin/perl

# This is my god-awful attempt to solve the problem cold in the 15m that
# Michael gave us after introducing the problem.
# It's terrible, and now that the Java solution has taught me a strategy 
# I need to re-write this. On my infinite TODO list...   --jhannah 20100610

my $in = $ARGV[0] || 9;

my %factors; 
foreach $i (   reverse( 2 .. (int(sqrt($in))) + 1)) {
   foreach $j (reverse( 2 .. (int(sqrt($in))) + 1)) {
      print "JAY10 $i $j\n";
      if ($i * $j == $in) {
         print "JAY11 " . (join " ", prime($i)) . (join " ", prime($j)) . "\n";
      }
   }
}

print join " ", sort keys %factors;
print "\n";

sub prime {
   my ($in) = @_;
   foreach $i (   reverse( 2 .. (int(sqrt($in))) + 1)) {
      foreach $j (reverse( 2 .. (int(sqrt($in))) + 1)) {
         print "JAY20 $i $j\n";
         if ($i * $j == $in) {
            print "JAY21 $i * $j == $in\n";
            return (prime($i), prime($j));
         }
      }
   }
   return 1;
}
   

