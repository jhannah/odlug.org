package Grid;

use Storable qw( dclone );

sub new { 
   my $self = {};
   return bless $self;
}

sub is_alive {
   my ($self, $x, $y, $new_state) = @_;
   if (defined $new_state) {
      if ($new_state == 0) {
         delete $self->{$x}->{$y};
         return 1;
      } else {
         $self->{$x}->{$y} = 1;
      }
   }
   return $self->{$x}->{$y};
}

sub tick {
   my ($self) = @_;
   my $orig = dclone($self);
   $orig = bless $orig;
   foreach my $x ( keys %$orig ) {
      foreach my $y ( keys %{$orig->{$x}} ) {
         next unless $orig->{$x}->{$y};
         my $neighbors = $orig->neighbors($x, $y);
         # print "   $x $y has $neighbors neighbors\n";
         if ($neighbors < 2) {
            # Conway Rule #1
            delete $self->{$x}->{$y};
         } elsif ($neighbors > 3) {
            # Conway Rule #3
            delete $self->{$x}->{$y};
         }
      }
   }
   return 1;
}

sub neighbors {
   my ($self, $x, $y) = @_;
   my $rval = 0;
   $rval++ if ($self->{$x - 1}->{$y - 1});
   $rval++ if ($self->{$x    }->{$y - 1});
   $rval++ if ($self->{$x + 1}->{$y - 1});
   $rval++ if ($self->{$x - 1}->{$y    });
   $rval++ if ($self->{$x + 1}->{$y    });
   $rval++ if ($self->{$x - 1}->{$y + 1});
   $rval++ if ($self->{$x    }->{$y + 1});
   $rval++ if ($self->{$x + 1}->{$y + 1});
   return $rval;
}

sub is_empty {
   my ($self) = @_;
   my $cnt = keys %$self;
   return $cnt;
}

sub clear {
   my ($self) = @_;
   $self = {};
   return 1;
}

sub draw {
   my ($self) = @_;
   foreach my $x (reverse 1..20) {
      my $line;
      foreach my $y (1..20) {
         $line .= $self->{$x}->{$y} ? "O" : "-";
      }
      print "$line\n";
   }
}


1;


