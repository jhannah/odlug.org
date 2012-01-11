use strict;
use 5.10.0;

my @m = (
   # alphabetical by last name
   # name,             URL,                              twitter,      github
   'Stephen Haberman', 'http://draconianoverlord.com',    undef,       'stephenh',
   'Jay Hannah',       'http://jays.net',                'deafferret', 'jhannah',
   'Nick Nisi',        'http://slouchcou.ch',            'nicknisi',   'nicknisi',
   'Ryan Stille',      'http://www.stillnetstudios.com', 'RyanStille', 'stillnet',
   'Samuel Tesla',     'http://blog.alieniloquent.com',   undef,       'stesla',
   'Juan Vazquez',     'http://javazquez.com',           'javazquez',  'javazquez',
   'Nick Wertzberger', undef,                             undef,       'nwerzberger',

   undef, undef, undef,                                                'davekerber',
   undef, undef, undef,                                                'kwbeam',
   undef, undef, undef,                                                'jshickey',
   undef, undef, undef,                                                'ddteeter',
   undef, undef, undef,                                                'meyerds',
   undef, undef, undef,                                                'reynacho',
   undef, undef, undef,                                                'jmichl',
   undef, undef, undef,                                                'Bolerr',
   undef, undef, undef,                                                'rjt',
   undef, undef, undef,                                                'swcline',
   undef, undef, undef,                                                'tdhatcher',
   undef, undef, undef,                                                'gabrielsjoberg',
   undef, undef, undef,                                                'mattdsteele',
   undef, undef, undef,                                                'emonical',

);
while (@m) {
   my ($name, $url, $twitter, $github) = splice @m, 0, 4;
   print "<nobr>";
   if ($name) {
      say "<a href='$url'>$name</a> ";
   } elsif ($github) {
      say "$github ";
   }
   if ($twitter) {
      say "   <a href='http://twitter.com/#/$twitter'><img src='www/images/twitter_icon.png' border=0></a>";
   }
   if ($github) {
      say "   <a href='http://github.com/$github'><img src='www/images/github-icon-16x16.jpg'></a>";
   }
   say "</nobr>";
}



