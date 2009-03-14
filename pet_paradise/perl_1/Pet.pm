package Pet;

my $ID = 1;

use Moose;
has 'id'     => (is => 'rw', isa => 'Int');
has 'type'   => (is => 'rw', isa => 'Str');
has 'weight' => (is => 'rw', isa => 'Int');
no Moose;

sub BUILD {
   my ($self) = @_;
   $self->id($ID);
   $ID++;
}


1;

