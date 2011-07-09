use Plack::Builder;
use POS;
use Inventory;

my $pos_app = POS->new();
my $inv_app = Inventory->new();

builder {
    enable "Static", $app;
}


