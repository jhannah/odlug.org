use 5.12.1;
use warnings;
use WWW::Mechanize;
use JSON::XS;
use Class::Date qw(date);

my $api_key = '4f3610e2e1b7172e3541d3f255d7bc4c';  # jay@jays.net
my $latlong = '40.8198,-95.7521';   # Thurman, IA (where Jay dirt bikes)
local $Class::Date::DATE_FORMAT="%Y-%m-%d";

my $mech = WWW::Mechanize->new();

my @jsonkeys = qw(
   summary precipIntensity precipIntensityMax precipAccumulation precipType 
   temperatureMin temperatureMax
);

open my $out, ">:utf8", "out.html";
print $out <<EOT;
<p>
<b>precipIntensity</b>: inches of liquid water per hour<br/>
<b>precipAccumulation</b>: inches snow accum<br/>
<a href="https://developer.forecast.io/docs/v2">Read more</a>
</p>
EOT

location("Thurman, IA", '40.8198,-95.7521');  # Where Jay dirt bikes
location("Omaha, NE",   '41.2607,-95.9406');  # Where Jay lives (for comparison)

say $out <<EOT;
<br/><br/><br/><br/>
Data from <a href="https://developer.forecast.io/">forecast.io API</a><br/>
<a href="https://github.com/jhannah/odlug.org/tree/master/forecast.io">soure code</a>
EOT


sub location {
   my ($name, $latlong) = @_;
    print $out <<EOT;
<h1>$name</h1>
<table>
<tr>
   <th>Date</th>
EOT
   foreach my $key (@jsonkeys) {
      say $out "   <th>$key</th>";
   }
   say $out "<th> </th>\n</tr>";
   
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
         @$json{ @jsonkeys };
      my $weburl = "http://forecast.io/#/f/$latlong/$time";
      print $out "<td><a href='$weburl' target='_blank'>web</a>";
      say $out "</td></tr>";
   }

   say $out "</table>";
}




