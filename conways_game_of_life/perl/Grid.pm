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
         $self->delete($x, $y);
         return 1;
      } else {
         $self->{$x}->{$y} = 1;
      }
   }
   if ($self->{$x}) {
      # Don't autovivify. Confuses is_empty().
      return $self->{$x}->{$y};
   }
   return 0;
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
            $self->delete($x, $y);
         } elsif ($neighbors > 3) {
            # Conway Rule #3
            $self->delete($x, $y);
         }
      }
   }
   return 1;
}

sub delete {
   my ($self, $x, $y) = @_;
   # Autovivification gotchas for is_empty()...
   delete $self->{$x}->{$y};
   my $cnt = keys %{$self->{$x}};
   if ($cnt == 0) {
      delete $self->{$x};
   }
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
    print "   is_empty $cnt (" . (join ",", keys %$self ) . ")\n";
   return ($cnt == 0);
}

sub clear {
   my ($self) = @_;
   foreach my $x (keys %$self) {
      delete $self->{$x};
   }
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


