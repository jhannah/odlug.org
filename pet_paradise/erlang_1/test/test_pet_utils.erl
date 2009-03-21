-module(test_pet_utils).
-export([start/0]).

-include("models.hrl").

start() ->
  etap:plan(10),

  SmallDog = #pet{species=dog, weight=10},
  BigCat = #pet{species=cat, weight=50},
  BigDog = #pet{species=dog, weight=70},

  %% pet_utils:increasing/2 for use in sorting things based on their lists of pets
  etap:ok(pet_utils:increasing(SmallDog, BigDog), "small dog < big dog"),
  etap:ok(pet_utils:increasing(SmallDog, BigCat), "small dog < big cat"),
  etap:ok(pet_utils:increasing(BigCat, BigDog), "big cat < big dog"),
  etap:not_ok(pet_utils:increasing(BigDog, SmallDog), "big dog !< small dog"),
  etap:not_ok(pet_utils:increasing([BigDog], [BigDog]), "[big] !< [big]"),
  etap:ok(pet_utils:increasing([SmallDog], [BigDog]), "[small] < [big]"),
  etap:ok(pet_utils:increasing([BigDog], [SmallDog, BigCat]),
              "[big dog] < [small dog, big cat]"),
  etap:not_ok(pet_utils:increasing([SmallDog, BigCat], [BigDog]),
              "[small dog, big cat] !< [big dog]"),
  etap:ok(pet_utils:increasing([SmallDog, BigCat], [BigCat, BigDog]),
          "[small dog, big cat] < [big cat, big dog]"),
  etap:not_ok(pet_utils:increasing([BigCat, BigCat], [BigDog, SmallDog]),
              "[big dog, big cat] !< [big dog, small dog]"),

  etap:end_tests().
