use Term::ReadKey;
ReadMode 4; # Turn off controls keys
my $c;
while (not defined ($key = ReadKey(-1))) {
   # No key yet
   $c = int(rand(2)) ? 'red' : 'green';
   print "$c ";
}
# print "Get key $key\n";
print "\n\n\nThe walls will be: $c\n\n\n ";
ReadMode 0; # Reset tty mode before exiting



