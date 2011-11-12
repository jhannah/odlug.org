package AI::Pathfinding::AStar;

use 5.006;
use strict;
use warnings;
use Carp;

our $VERSION = '0.10';

use Heap::Binomial;

use AI::Pathfinding::AStar::AStarNode;
my $nodes;

sub _init {
    my $self = shift;
    croak "no getSurrounding() method defined" unless $self->can("getSurrounding");

    return $self->SUPER::_init(@_);
}

sub doAStar
{
	my ($map, $target, $open, $nodes, $max) = @_;

	my $n = 0;
	FLOOP:	while ( (defined $open->top()) && ($open->top()->{id} ne $target) ) {

		#allow incremental calculation
		last FLOOP if (defined($max) and (++$n == $max));

		my $curr_node = $open->extract_top();
		$curr_node->{inopen} = 0;
		my $G = $curr_node->{g};

		#get surrounding squares
		my $surr_nodes = $map->getSurrounding($curr_node->{id}, $target);
		foreach my $node (@$surr_nodes) {
			my ($surr_id, $surr_cost, $surr_h) = @$node;

			#skip the node if it's in the CLOSED list
			next if ( (exists $nodes->{$surr_id}) && (! $nodes->{$surr_id}->{inopen}) );

			#add it if we haven't seen it before
			if (! exists $nodes->{$surr_id}) {
				my $surr_node = AI::Pathfinding::AStar::AStarNode->new($surr_id,$G+$surr_cost,$surr_h);
				$surr_node->{parent} = $curr_node;
				$surr_node->{cost}   = $surr_cost;
				$surr_node->{inopen} = 1;
				$nodes->{$surr_id}   = $surr_node;
				$open->add($surr_node);
			}
			else {
				#otherwise it's already in the OPEN list
				#check to see if it's cheaper to go through the current
				#square compared to the previous path
				my $surr_node = $nodes->{$surr_id};
				my $currG     = $surr_node->{g};
				my $possG     = $G + $surr_cost;
				if ($possG < $currG) {
					#change the parent
					$surr_node->{parent} = $curr_node;
					$surr_node->{g}      = $possG;
					$open->decrease_key($surr_node);
				}
			}
		}
	}
}

sub fillPath
{
	my ($map,$open,$nodes,$target) = @_;
	my $path = [];

        my $curr_node = (exists $nodes->{$target}) ? $nodes->{$target} : $open->top();
	while (defined $curr_node) {
		unshift @$path, $curr_node->{id};
		$curr_node = $curr_node->{parent};
	}
	return $path;
}


sub findPath {
	my ($map, $start, $target) = @_;

	my $nodes = {};
	my $curr_node = undef;

	my $open = Heap::Binomial->new;
	#add starting square to the open list
	$curr_node = AI::Pathfinding::AStar::AStarNode->new($start,0,0);  # AStarNode(id,g,h)
	$curr_node->{parent} = undef;
	$curr_node->{cost}   = 0;
	$curr_node->{g}      = 0;
	$curr_node->{h}      = 0;
	$curr_node->{inopen} = 1;
	$nodes->{$start}     = $curr_node;
	$open->add($curr_node);

	$map->doAStar($target,$open,$nodes,undef);

	my $path = $map->fillPath($open,$nodes,$target);

	return wantarray ? @{$path} : $path;
}

sub findPathIncr {
	my ($map, $start, $target, $state, $max) = @_;

	my $open = undef;
	my $curr_node = undef;;
	my $nodes = {};
        if (defined($state)) {
		$nodes = $state->{'visited'};
		$open  = $state->{'open'};
        }
	else {
		$open = Heap::Binomial->new;
		#add starting square to the open list
		$curr_node = AI::Pathfinding::AStar::AStarNode->new($start,0,0);  # AStarNode(id,g,h)
		$curr_node->{parent} = undef;
		$curr_node->{cost}   = 0;
		$curr_node->{g}      = 0;
		$curr_node->{h}      = 0;
		$curr_node->{inopen} = 1;
       		$nodes->{$start} = $curr_node;
		$open->add($curr_node);
	}

	$map->doAStar($target,$open,$nodes,$max);

	my $path = $map->fillPath($open,$nodes,$target);
	$state = {
		'path'    => $path,
		'open'    => $open,
		'visited' => $nodes,
		'done'    => defined($nodes->{$target}),
	};

	return $state;
}

1;

__END__

=head1 NAME

AI::Pathfinding::AStar - Perl implementation of the A* pathfinding algorithm

=head1 SYNOPSIS

  package My::Map::Package;
  use base AI::Pathfinding::AStar;

  # Methods required by AI::Pathfinding::AStar
  sub getSurrounding { ... }

  package main;
  use My::Map::Package;

  my $map = My::Map::Package->new or die "No map for you!";
  my $path = $map->findPath($start, $target);
  print join(', ', @$path), "\n";
  
  #Or you can do it incrementally, say 3 nodes at a time
  my $state = $map->findPathIncr($start, $target, undef, 3);
  while ($state->{path}->[-1] ne $target) {
	  print join(', ', @{$state->{path}}), "\n";
	  $state = $map->findPathIncr($start, $target, $state, 3);
  }
  print "Completed Path: ", join(', ', @{$state->{path}}), "\n";
  
=head1 DESCRIPTION

This module implements the A* pathfinding algorithm.  It acts as a base class from which a custom map object can be derived.  It requires from the map object a subroutine named C<getSurrounding> (described below) and provides to the object two routines called C<findPath> and C<findPathIncr> (also described below.)  It should also be noted that AI::Pathfinding::AStar defines two other subs (C<calcF> and C<calcG>) which are used only by the C<findPath> routines.

AI::Pathfinding::AStar requires that the map object define a routine named C<getSurrounding> which accepts the starting and target node ids for which you are calculating the path.  In return it should provide an array reference containing the following details about each of the immediately surrounding nodes:

=over

=item * Node ID

=item * Cost to enter that node

=item * Heuristic

=back

Basically you should return an array reference like this: C<[ [$node1, $cost1, $h1], [$node2, $cost2, $h2], [...], ...];>  For more information on heuristics and the best ways to calculate them, visit the links listed in the I<SEE ALSO> section below.  For a very brief idea of how to write a getSurrounding routine, refer to the included tests.

As mentioned earlier, AI::Pathfinding::AStar provides two routines named C<findPath> and C<findPathIncr>.  C<findPath> requires as input the starting and target node identifiers.  It is unimportant what format you choose for your node IDs.  As long as they are unique, and can be distinguished by Perl's C<exists $hash{$nodeid}>, then they will work.  C<findPath> then returns an array (or reference) of node identifiers representing the least expensive path to your target node.  An empty array means that the target node is entirely unreacheable from the given source.  C<findPathIncr> on the other hand allows you to calculate a particularly long path in chunks.  C<findPathIncr> also takes the starting and target node identifiers but also accepts a C<state> variable and a maxiumum number of nodes to calculate before returning.  C<findPathIncr> then returns a hash representing the current state that can then be passed back in for further processing later.  The current path can be found in C<$state->{path}>.

=head1 PREREQUISITES

This module requires Heap (specifically Heap::Binomial and Heap::Elem) to function.

=head1 SEE ALSO

L<http://www.policyalmanac.org/games/aStarTutorial.htm>, L<http://xenon.stanford.edu/~amitp/gameprog.html>

=head1 AUTHOR

Aaron Dalton - aaron@daltons.ca
This is my very first CPAN contribution and I am B<not> a professional programmer.  Any feedback you may have, even regarding issues of style, would be greatly appreciated.  I hope it is of some use.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2004 Aaron Dalton.  All rights reserved.
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

