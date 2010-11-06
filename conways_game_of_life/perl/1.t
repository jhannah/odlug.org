use Test::More tests => 22;

use strict;
use Grid;

ok(my $g = Grid->new(),      'new()');
ok($g->is_alive(17,3,1),     'set it ALIVE');
ok($g->is_alive(17,3),       'alive or dead?');
ok($g->is_alive(17,3,0),     'set it DEAD');
ok(! $g->is_alive(17,3),     'alive or dead?');

# for (1..100) {
#    $g->is_alive(   (int(rand(20)) + 1),   (int(rand(20)) + 1),   1    );
# }
# $g->draw();

# Test Conway Rule #1...
ok($g->is_empty,             'clean slate');
$g->is_alive(5,5,1);
ok($g->tick,                 'tick');
ok(! $g->is_alive(5,5),      '5 5 died   RIP');
ok($g->is_empty,             'clean slate');

# Test Conway Rule #2...
ok($g->is_empty,             'clean slate');
$g->is_alive(5,5,1);
$g->is_alive(5,6,1);
$g->is_alive(6,5,1);
ok($g->tick,                 'tick');
ok($g->is_alive(5,5),        'alive');
ok($g->is_alive(5,6),        'alive');
ok($g->is_alive(6,5),        'alive');
# ... plus other cells have been born...

# Test Conway Rule #3...
ok($g->clear,                'clear');
ok($g->is_empty,             'clean slate');
$g->is_alive(5,5,1);
$g->is_alive(5,6,1);
$g->is_alive(6,5,1);
$g->is_alive(6,6,1);
$g->is_alive(6,7,1);
$g->draw;
ok($g->tick,                 'tick');
$g->draw;
ok($g->is_alive(5,5),        'alive 5 5');
ok(! $g->is_alive(5,6),      'died  5 6');
ok($g->is_alive(6,5),        'alive 6 5');
ok(! $g->is_alive(6,6),      'died  6 6');
ok($g->is_alive(6,7),        'alive 6 7');


