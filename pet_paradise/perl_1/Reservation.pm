package Reservation;

use Pet;

use Moose;
has 'raw'        => (is => 'rw', isa => 'Str');
has 'id'         => (is => 'rw', isa => 'Int');
has 'payment'    => (is => 'rw', isa => 'Num');
has 'begin_date' => (is => 'rw', isa => 'Str');
has 'end_date'   => (is => 'rw', isa => 'Str');
has 'pets'       => (is => 'rw', isa => 'ArrayRef');
no Moose;

sub BUILD {
   my ($self) = @_;
   my @raw = split /\|/, $self->raw;
   $self->id(     shift @raw);
   $self->payment(shift @raw);
   my ($bd, $ed) = split /-/, shift @raw;
   $self->begin_date($bd);
   $self->end_date(  $ed);

   # All that's left now is the pets...
   pop @raw;  # discard trailing |
   my @pets;
   foreach my $pet (@raw) {
      my ($weight, undef, $type) = split / /, $pet;
      my $pet = Pet->new(
         weight => $weight,
         type   => $type
      );
      push @pets, $pet;
   }
   $self->pets(\@pets);
}


1;

