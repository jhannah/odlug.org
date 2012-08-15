
use Moose::Util::TypeConstraints;
# Turn programmer input into a canonical representation 
# We're assuming here that we've lower-cased first
          my %String_to_suit = (
                  s      => 's',
                  spades => 's',
                  spade  => 's',
                  h      => 'h',
                  hearts => 'h',
                  heart  => 'h',
         );

  subtype 'Suit'
                  => as 'Str'
                  => where { /^[hdcs]$/ };

     coerce 'Suit'
                  => from 'Str'
=> via { $String_to_suit{lc $_} };

package JayShinyness;
use 5.10.0;
use Moose::Role;
sub hi {
   say "hello!";
}

package PlayingCard;
          use Moose;
          with 'JayShinyness';
          has 'suit'  => (
                  is       => 'ro',
                  isa      => 'Suit',
                  required => 1,
                  coerce   => 1,
          );



package main;
use 5.10.0;
my $card = PlayingCard->new(suit => 'hearts');
say $card->suit();


