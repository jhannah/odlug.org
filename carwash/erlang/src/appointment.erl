-module(appointment).
-export([start/0,stop/0]).
-export([create/1,claim/1,clear/0]).
-export([init/0]).

-define(LOW_CODE, 10000).
-define(HIGH_CODE, 99999).

start() ->
    register(appointment, spawn(?MODULE, init, [])).

stop() -> appointment ! stop.

create(Product) -> rpc({create, Product}).
claim(Code) -> rpc({claim, Code}).
clear() -> rpc(clear).

init() ->
    crypto:start(),
    loop(dict:new()).

loop(IssuedCodes) ->
    receive
        stop -> exit(normal);
        {From, {create, Product}} ->
            Code = crypto:rand_uniform(?LOW_CODE, ?HIGH_CODE),
            case dict:is_key(Code, IssuedCodes) of
                true ->
                    self() ! {From, {create, Product}},
                    loop(IssuedCodes);
                false ->
                    From ! {self(), {ok, Code}},
                    loop(dict:store(Code, Product, IssuedCodes))
            end;
        {From, {claim, Code}} ->
            case dict:find(Code, IssuedCodes) of
                error ->
                    From ! {self(), {error, invalid_code}},
                    loop(IssuedCodes);
                Response ->
                    From ! {self(), Response},
                    loop(dict:erase(Code, IssuedCodes))
            end;
        {From, clear} ->
            From ! {self(), ok},
            loop(dict:new())
    end.

rpc(Request) ->
    Pid = whereis(appointment),
    Pid ! {self(), Request},
    receive
        {Pid, Response} -> Response
    end.
