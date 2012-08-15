package Foo;
use Moose;
use 5.10.0;
extends 'Bar';
around 'hi' => sub {
   my ($next, $self) = @_;
   say 'foo1';
   $self->$next();
   say 'foo2';
};

package Bar;
use Moose;
use 5.10.0;
extends 'Baz';
around 'hi' => sub {
   my ($next, $self) = @_;
   say 'bar1';
   $self->$next();
   say 'bar2';
};

package Baz;
use Moose;
use 5.10.0;
sub hi { say 'hello' }

package main;
my $b = Foo->new();



