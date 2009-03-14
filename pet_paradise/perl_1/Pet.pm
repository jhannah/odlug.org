package Pet;

use Moose;
has 'type'   => (is => 'rw', isa => 'Str');
has 'weight' => (is => 'rw', isa => 'Int');
no Moose;


1;

