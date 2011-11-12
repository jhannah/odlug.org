package AI::Pathfinding::AStar::AStarNode;
use base 'Heap::Elem';

use strict;

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my ($id,$g,$h) = @_;

	my $self = {};
	$self->{id}     = $id;
	$self->{g}      = $g;
	$self->{h}      = $h;
	$self->{f}      = $g+$h;
	$self->{parent} = undef;
	$self->{cost}   = 0;
	$self->{inopen} = 0;
	$self->{heap} = undef;

	bless ($self, $class);
	return $self;
}

sub heap {
	my ($self, $val) = @_;
	$self->{heap} = $val if (defined $val);
	return $self->{heap};
}

sub cmp {
    my $self = shift;
    my $other = shift;
    return ($self->{f} <=> $other->{f});
}

1;

