The challenge
---------------

You own a pet kennel / boarding / hotel business. Weekends and holidays are very busy. You've had a 
sudden rush of new customer demand and you need to maximize your profits so you can retire early. 
Determine the maximum profit possible based on the new demand (customer reservation requests 
sitting in your Inbox waiting for you to confirm or deny their reservation) given the physical 
constraints of your hotel.


Your hotel
---------------
Cage types:

   SMALL - Single pet
   Your hotel has 4 small cages.
 
   LARGE - Single pet >= 60 lbs 
           OR two pets between 20-60 lbs 
           OR three pets < 20 lbs.
   Your hotel has 3 large cages.


Rules
---------------

You can stick different customers' pets together in the same LARGE cage. They won't mind.

BUT you can NEVER stick a dog and a cat in the same cage.


Demand
---------------

Here are the people you need to email/call back. There is no way you can possibly
accomodate everyone, so you'll have to turn away some business. WHICH business you turn away determines
how much profit you end up with. You love money, you capitalist swine, so maximize it for the win!

Reservations must be accepted or rejected entirely. You must board ALL of their pets for ALL of the nights they 
ask for, or reject them entirely.

Customers tell you the price they are willing to pay. You can choose to accept or reject their business, you
can not set the prices or haggle. 

Here's the demand:

Customer ID|TOTAL they offer to pay|Date(s) they require boarding|Pet|Pet|Pet...
1|174.09|20090617-20090618|71 pound DOG|74 pound DOG|60 pound DOG|
2|55.17|20090615-20090617|70 pound CAT|64 pound DOG|
3|76.98|20090615-20090618|61 pound CAT|68 pound CAT|
4|59.22|20090616-20090616|34 pound CAT|36 pound CAT|57 pound DOG|
5|192.49|20090617-20090617|38 pound CAT|55 pound CAT|
6|109.58|20090618-20090618|38 pound DOG|
7|148.82|20090617-20090619|26 pound DOG|81 pound CAT|24 pound CAT|
8|218.97|20090617-20090617|31 pound DOG|
9|72.81|20090618-20090620|33 pound CAT|20 pound CAT|43 pound CAT|
10|46.61|20090615-20090615|84 pound DOG|
11|196.96|20090617-20090617|49 pound CAT|61 pound CAT|66 pound DOG|
12|80.41|20090615-20090616|75 pound DOG|38 pound CAT|
13|151.61|20090618-20090618|31 pound DOG|
14|47.50|20090616-20090618|32 pound CAT|21 pound DOG|71 pound DOG|
15|205.89|20090615-20090617|67 pound CAT|37 pound DOG|
16|54.32|20090616-20090619|34 pound CAT|
17|147.75|20090617-20090618|25 pound DOG|59 pound DOG|
18|28.32|20090616-20090616|62 pound DOG|59 pound CAT|
19|24.65|20090618-20090619|82 pound DOG|16 pound DOG|
20|114.77|20090616-20090619|59 pound CAT|47 pound DOG|69 pound DOG|
21|68.46|20090616-20090616|73 pound CAT|46 pound DOG|
22|55.32|20090616-20090618|67 pound CAT|29 pound DOG|
23|139.73|20090615-20090617|48 pound DOG|33 pound CAT|
24|44.24|20090617-20090619|37 pound DOG|16 pound CAT|
25|111.41|20090615-20090616|34 pound DOG|20 pound DOG|
26|81.77|20090618-20090621|41 pound DOG|20 pound DOG|22 pound DOG|
27|88.15|20090618-20090621|29 pound CAT|28 pound CAT|
28|147.61|20090617-20090618|20 pound DOG|
29|212.28|20090615-20090616|16 pound DOG|21 pound DOG|18 pound DOG|
30|91.55|20090616-20090617|37 pound CAT|78 pound CAT|
31|184.22|20090618-20090621|22 pound CAT|24 pound CAT|83 pound CAT|
32|59.98|20090617-20090618|35 pound DOG|54 pound CAT|45 pound DOG|
33|72.28|20090617-20090617|34 pound DOG|70 pound DOG|
34|35.45|20090618-20090621|39 pound DOG|82 pound CAT|71 pound DOG|
35|154.95|20090615-20090616|82 pound DOG|39 pound CAT|17 pound CAT|
36|119.43|20090618-20090620|40 pound CAT|81 pound CAT|
37|81.51|20090617-20090620|46 pound CAT|
38|92.64|20090616-20090618|79 pound CAT|15 pound CAT|40 pound DOG|
39|199.82|20090615-20090617|70 pound CAT|
40|50.21|20090616-20090617|59 pound DOG|15 pound CAT|


Which customer IDs do you accept? How much money did you make?

May the smartest code (mathmatician?) win!  :)

(Demand created by perl_1/random_demand_gen.pl)

--jhannah 20090311
