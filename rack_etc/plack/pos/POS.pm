package POS;
use Moose;

sub total {
   my ($self) = @_;
   return 4;
}


my $app = sub {
   my ($env) = @_;
   return [
      200,
      ['Content-Type' => 'text/plain'],
      [ "Hello stranger from $env->{REMOTE_ADDR}!"],
   ];
};



1;

