package Kennel;

use Moose;
has '_Inventory' => (is => 'rw', isa => 'Object');
no Moose;

use Inventory;

sub BUILD {
   my ($self) = @_;
   $self->_Inventory(Inventory->new());
}

sub reserve {
   my ($self, $res) = @_;
   return $self->_Inventory->reserve($res);
}

sub report {
   my ($self) = @_;
   my $rval = "Our upcoming reservations:\n\n";
   $rval .= $self->_Inventory->report;
   return $rval;
}


1;

