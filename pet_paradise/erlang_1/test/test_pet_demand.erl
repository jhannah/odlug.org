-module(test_pet_demand).
-export([start/0]).

-include("models.hrl").

start() ->
  Dog = #pet{species=dog, weight=74},
  Cat = #pet{species=cat, weight=7},
  Demand1 = #demand{id=1, rate=31.41,
                    date_begin={2009, 06, 17}, date_end={2009, 06, 18},
                    pets=[Dog]},
  Demand2 = #demand{id=2, rate=27.18,
                    date_begin={2009, 06, 16}, date_end={2009, 06, 20},
                    pets=[Cat, Dog]},
  etap:plan(2),
  etap:is(Demand1,
          pet_demand:parse("1|31.41|20090617-20090618|74 pound DOG|"),
          "parse single pet demand"),
  etap:is(Demand2,
          pet_demand:parse("2|27.18|20090616-20090620|7 pound CAT|74 pound DOG|"),
          "parse multiple pet demand"),
  etap:end_tests().
