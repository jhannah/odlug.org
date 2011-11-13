package MyBot;
use strict;
use warnings;
use parent 'Ants';
use Position;
use MyAStar;
use Data::Dumper;
use FileHandle;
use Time::HiRes qw(gettimeofday tv_interval);

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

   my $as = MyAStar->new($self);
   my $busy = {};
   my $directions = {};

   foreach my $food ($self->food) {
      say $log "FOOD $food";
      my @ants = $self->nearby('my_ants', $food);
      my $ant = shift @ants;
      say $log "ANT $ant";
      # Head straight for food using A* algorithm
      my $direction = $as->my_findPath($ant, $food);
      $self->issue_order( $ant, $direction );
      $directions->{$direction}++;
      $busy->{$ant} = 1;
      printf $log "%s seconds have elapsed\n", 
         tv_interval($self->{go_time}, [ gettimeofday ]);
   }

   foreach my $ant ($self->my_ants) {
      next if ($busy->{$ant});
      my @ants = $self->nearby('my_ants', $ant);
      shift @ants;  # throw myself away
      my $closest = shift @ants;
      next unless ($closest);
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
      printf $log "%s seconds have elapsed\n", 
         tv_interval($self->{go_time}, [ gettimeofday ]);
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
