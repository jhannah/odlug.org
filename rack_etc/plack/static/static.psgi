use Plack::Builder;

my $app = sub {
   my ($env) = @_;
   return [
      200, 
      ['Content-Type' => 'text/plain'],
      [ "Hello stranger from $env->{REMOTE_ADDR}!"],
   ];
};

builder {
    # enable "Static", path => qr!^/static!, root => '../../';
    enable "Static", path => sub { s!^/static/!! }, root => '/var/www/odlug/';
    $app;
}

