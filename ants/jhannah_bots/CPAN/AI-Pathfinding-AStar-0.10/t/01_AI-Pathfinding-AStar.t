#########################

package AI::Pathfinding::AStar::Test;
use Test::More tests => 6;
BEGIN {
  use base AI::Pathfinding::AStar;
};

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

#initialize a basic map
#This example module represents the following map:
#
#       . . . . . . .
#       . . . | . . .
#       @ . . | . . *
#       . . . | . . .
#       . . . . . . .
#
#Where . represents open squares and | represents walls.  The @ represents our
#starting square and the * the target square.  This module assumes that
#orthogonal moves cost 10 points and diagonal moves cost 140.  The heuristic
#used is Manhattan, which simply counts the orthogonal distance between any 2
#squares whilst disregarding any barriers.

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

#some support routines

#get orthoganal neighbours
sub getOrth
{
	my ($source) = @_;

	my @return = ();
	my ($x, $y) = split(/\./, $source);

	push @return, ($x+1).'.'.$y, ($x-1).'.'.$y, $x.'.'.($y+1), $x.'.'.($y-1);
	return @return;
}

#get diagonal neightbours
sub getDiag
{
		my ($source) = @_;

		my @return = ();
		my ($x, $y) = split(/\./, $source);

		push @return, ($x+1).'.'.($y+1), ($x+1).'.'.($y-1), ($x-1).'.'.($y+1), ($x-1).'.'.($y-1);
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

	#orthogonal moves cost 10, diagonal cost 140
	foreach my $node (getOrth($source))
	{
		if ( (exists $map{$node}) && ($map{$node}) )
			{push @$surrounding, [$node, 10, calcH($node, $target)];}
	}
	foreach my $node (getDiag($source))
	{
		if ( (exists $map{$node}) && ($map{$node}) )
			{push @$surrounding, [$node, 140, calcH($node, $target)];}
	}

	return $surrounding;
}

my $g;

ok($g = AI::Pathfinding::AStar::Test->new(), 'new()');
isa_ok($g, AI::Pathfinding::AStar, 'isa');

can_ok($g, qw/getSurrounding findPath findPathIncr doAStar fillPath/, 'can');

use Data::Dumper;
my $path1 = $g->findPath('1.3', '7.3');
print Dumper($path1);
my $path2 = $g->findPath('2.3', '1.4');
is(@$path1,        11,  "check path length");
is($path1->[1], '2.3',       "check path 0");
is($path2->[1], '2.4',       "check path 2");
