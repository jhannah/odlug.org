package MyAStar;
use strict;
use 5.10.0;
use base 'AI::Pathfinding::AStar';
use Data::Dumper;
use FileHandle;

open my $log, '>>', 'log.txt' or die;
$log->autoflush;

sub new {
   my ($invocant, $ants) = @_;
  
   my $class = ref($invocant) || $invocant;
   my $self = bless {
      ants => $ants
   }, $class;

   $self->{map} = {};

   # Convert from Ants lingo to AI::Pathfinding::AStar lingo.
   foreach my $x (0 .. $ants->width) {
      foreach my $y (0 .. $ants->height) {
         $self->{map}->{"$x.$y"} = 1;
      }
   }
   # Water can not be traversed.
   foreach my $loc ($ants->water) {
      $self->{map}->{$loc->x . '.' . $loc->y} = 0;
   }
   # Don't step on my own ants.
   foreach my $loc ($ants->my_ants) {
      $self->{map}->{$loc->x . '.' . $loc->y} = 0;
   }

   return $self;
}


=head2 my_findPath 

Covert from Ants lingo to AI::Pathfinding::AStar lingo.

=cut

sub my_findPath {
   my ($self, $from, $to) = @_;
   print $log "Pathing FROM " . Dumper($from) . " TO " . Dumper($to);
   my $path = $self->findPath(
      $from->x . '.' . $from->y,
      $to->x   . '.' . $to->y,
   );
   say $log Dumper($path);
   my ($current, $next) = @$path;
   my $current = Position->new(split /\./, $current);
   my $next = Position->new(split /\./, $current);
   my $dir = $self->{ants}->direction($current, $next);
   say $log "GO $dir DAMMIT";
   return $dir;
}


#get orthoganal neighbours
sub getOrth
{
	my ($source) = @_;

	my @return = ();
	my ($x, $y) = split(/\./, $source);

	push @return, ($x+1).'.'.$y, ($x-1).'.'.$y, $x.'.'.($y+1), $x.'.'.($y-1);
	return @return;
}


#calculate the Heuristic
sub calcH
{
	my ($source, $target) = @_;

	my ($x1, $y1) = split(/\./, $source);
	my ($x2, $y2) = split(/\./, $target);

	return (abs($x1-$x2) + abs($y1-$y2));
}

#the routine required by AI::Pathfinding::AStar
sub getSurrounding
{
	my ($self, $source, $target) = @_;

	my %map = %{$self->{map}};
	my ($src_x, $src_y) = split(/\./, $source);

	my $surrounding = [];

	# Every move costs 1
	foreach my $node (getOrth($source))
	{
		if ( (exists $map{$node}) && ($map{$node}) )
			{push @$surrounding, [$node, 1, calcH($node, $target)];}
	}
	return $surrounding;
}


1;

