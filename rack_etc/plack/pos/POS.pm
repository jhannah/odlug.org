package POS;
use Moose;

extends 'Plack::Component'; 

sub call { 
   my ($env) = @_;
   return [
      200,
      ['Content-Type' => 'text/plain'],
      [ 2 + 2 ],
   ];
}

1;

