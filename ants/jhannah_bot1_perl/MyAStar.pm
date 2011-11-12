package MyAStar;
use base AI::Pathfinding::AStar;

sub new
{
    my $invocant = shift;
    my $class = ref($invocant) || $invocant;
    my $self = bless {}, $class;

	$self->{map} = {};
	for(my $x=1; $x<=7; $x++)
	{
		for(my $y=1; $y<=5; $y++)
			{$self->{map}->{$x.'.'.$y} = 1;}
	}
	$self->{map}->{'4.2'} = 0;
	$self->{map}->{'4.3'} = 0;
	$self->{map}->{'4.4'} = 0;

    return $self;
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

