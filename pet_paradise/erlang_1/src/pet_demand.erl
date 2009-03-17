-module(pet_demand).

-export([parse/1, parse_file/1]).

-include("models.hrl").

parse_file(Path) ->
  {ok, IoDevice} = file:open(Path, [read]),
  parse_file(IoDevice, []).

parse_file(IoDevice, Acc) ->
  case io:get_line(IoDevice, '') of
    {error, Reason} ->
      exit(Reason);
    eof ->
      lists:reverse(Acc);
    Result ->
      Demand = parse(string:strip(Result, right, $\n)),
      parse_file(IoDevice, [Demand | Acc])
  end.

parse_pet(PetDesc) ->
  [Weight, Species] = string:tokens(PetDesc, " pound "),
  #pet{species=list_to_atom(string:to_lower(Species)),
       weight=list_to_integer(Weight)}.

parse(DemandDesc) ->
  [Id, Rate, DateRange | Pets] = string:tokens(DemandDesc, "|"),
  {DateBegin, DateEnd} = parse_date_range(DateRange),
  #demand{id=list_to_integer(Id),
          rate=list_to_float(Rate),
          date_begin=DateBegin,
          date_end=DateEnd,
          pets=lists:map(fun parse_pet/1, Pets)}.

parse_date_range(DateRange) ->
  list_to_tuple(lists:map(fun parse_date/1, string:tokens(DateRange, "-"))).

parse_date([Y1, Y2, Y3, Y4, M1, M2, D1, D2]) ->
  {list_to_integer([Y1,Y2,Y3,Y4]),
   list_to_integer([M1,M2]),
   list_to_integer([D1,D2])}.
