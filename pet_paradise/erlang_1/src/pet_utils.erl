-module(pet_utils).
-export([increasing/2]).

-include("models.hrl").

increasing(#pet{weight=A}, #pet{weight=B}) ->
  increasing(A,B);
increasing([A], [B]) ->
  increasing(A, B);
increasing([A | As], [B | Bs]) when length(As) =:= length(Bs) ->
  increasing(A, B) andalso increasing(As, Bs);
increasing(As, Bs) when is_list(As), is_list(Bs) ->
  increasing(length(As), length(Bs));
increasing(A, B) when A < B ->
  true;
increasing(_,_) ->
  false.
