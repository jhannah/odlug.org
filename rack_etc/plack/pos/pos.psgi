use Plack::Builder;
use POS;
use Inventory;

builder {
   mount '/pos' => POS->to_app,
   mount '/inv' => Inventory->to_app,
}


