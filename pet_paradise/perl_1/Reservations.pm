package Reservations;

# Stream Reservation objects read from ../README

use Reservation;
use FileHandle;

use Moose;
has 'read_fh'  => (is => 'rw', isa => 'Object');
has 'next_raw' => (is => 'rw', isa => 'Str');
no Moose;

sub BUILD {
   my ($self) = @_;
  
   my $fh = FileHandle->new();
   $fh->open("../README") or die "Can't open ../README";
   $self->read_fh($fh);

   while (<$fh>) {
      if (/^\d+\|\d+/) {
         chomp;
         $self->next_raw($_);
         last;
      }
   }
}

sub next {
   my ($self) = @_;

   return undef unless ($self->next_raw);
   my $r = Reservation->new(raw => $self->next_raw);
   my $fh = $self->read_fh;
   my $next = <$fh>;
   unless ($next =~ /^\d+\|\d+/) {
      $self->next_raw("");
      return $r;
   }
   chomp $next;
   $self->next_raw($next);
   return $r;
}

1;

