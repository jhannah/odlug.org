package MyBot;
use strict;
use warnings;
use parent 'Ants';
use Position;
use MyAStar;
use Data::Dumper;
use FileHandle;

open my $log, '>>', 'log.txt' or die;
$log->autoflush;

# This is where the implementation of your bot goes!

# setup() will be called once, after the game parameters come in, but before
# the game starts up.
sub setup {
    my $self = shift;
}

# create_orders() will be run after parsing the incoming map data, every turn.
# This example looks for nearby food that isn't immediately blocked by water.
sub create_orders {
   my $self = shift;

   for my $ant ($self->my_ants) {
      my @food = $self->nearby('food', $ant);

      if (@food) {
         # Head straight for food using A* algorithm
         my $f = shift @food;
         my $as = MyAStar->new($self);
         my $direction = $as->my_findPath($ant, $f);
         $self->issue_order( $ant, $direction );
      } else {
         # Uhh... head away from the closest other ant?
         my @ants = $self->nearby('my_ants', $ant);
         shift @ants;  # throw myself away
         my $closest = shift @ants;
         say $log "Avoid other ants!";
         say $log "I'm at: " .  Dumper($ant);
         say $log "Closest: " . Dumper($closest);
         my $direction = $self->direction($closest, $ant);
         say $log "GO $direction dammit!";
         if ($self->passable(Position->from($ant)->move($direction))) {
            $self->issue_order( $ant, $direction );
         } else {
            say $log "   NO! not passable!";
         }
      }
   }
}


=head2 nearby

Returns a list of nearby X for a given location, sorted by distance.

   my @nearby_food =       $self->nearby('food',       $location);
   my @nearby_my_ants =    $self->nearby('my_ants',    $location);
   my @nearby_enemy_ants = $self->nearby('enemy_ants', $location);

=cut

sub nearby {
    my ($self, $what, $ant_location) = @_;

    my @rval;
    for my $loc ($self->$what) {
        my $dist = $self->distance($ant_location, $loc);
        push @rval, { distance => $dist, tile => $loc };
    }

    # Sort by distance:
    return map { $_->{tile} } sort {
        $a->{distance} <=> $b->{distance}
    } @rval;
}



1;
