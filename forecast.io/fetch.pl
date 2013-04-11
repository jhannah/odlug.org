use 5.12.1;
use warnings;
use WWW::Mechanize;
use JSON::XS;
use Class::Date qw(date);

my $api_key = '4f3610e2e1b7172e3541d3f255d7bc4c';  # jay@jays.net
my $latlong = '40.8198,-95.7521';   # Thurman, IA (where Jay dirt bikes)
local $Class::Date::DATE_FORMAT="%Y-%m-%d";

my $mech = WWW::Mechanize->new();

open my $out, ">:utf8", "thurman_ia.html";
print $out <<EOT;
<h1>Thurman, IA History</h1>
<table>
EOT

foreach my $daysago (0..7) {         # For the last week
   my $time = time - 86400 * $daysago;
   my $date = date $time;
   my $uri = sprintf(
      "https://api.forecast.io/forecast/%s/%s,%s?exclude=currently,minutely,hourly,flags",
      $api_key,
      $latlong,
      $time,
   );
   # say $uri;
   $mech->get($uri);
   # say $mech->content;
   my $json = (decode_json $mech->content)->{daily}->{data}->[0];
   print $out "<tr><td>";
   print $out join "</td><td>", 
      $date,
      $json->{summary};
   say $out "</td></tr>";
}

say $out <<EOT;

</table>

Data from <a href="https://developer.forecast.io/">forecast.io API</a>.
<a href="https://github.com/jhannah/odlug.org">soure code</a>.
EOT




