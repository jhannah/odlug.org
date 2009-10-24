package Cage;

my $ID = 1;

use Moose;
has 'id'        => (is => 'rw', isa => 'Int');
has 'occupants' => (is => 'rw', isa => 'ArrayRef');
no Moose;

sub BUILD {
   my ($self) = @_;
   $self->id($ID);
   $ID++;
}


1;

