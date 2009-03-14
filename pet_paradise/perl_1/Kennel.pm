package Kennel;

use Moose;
no Moose;

sub reserve {
   return 1;
}

sub books {
   my $rval = "books here\n";
   return $rval;
}


1;

