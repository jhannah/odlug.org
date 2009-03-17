-module(test_pet_demand).
-export([start/0]).

start() ->
  etap:plan(1),
  etap:ok(true, "foo"),
  etap:end_tests().
