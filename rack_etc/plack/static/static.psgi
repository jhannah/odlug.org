use Plack::Builder;

my $app = sub {[
   200, 
   ['Content-Type' => 'text/plain'],
   [ "Hello stranger from $env->{REMOTE_ADDR}!"],
]};

builder {
    enable "Static", path => qr!^/static!, root => './htdocs';
    $app;
}

