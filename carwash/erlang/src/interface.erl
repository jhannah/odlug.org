-module(interface).
-export([start/0,stop/0]).
-export([later/1,now/1]).
-export([init/0,loop/1]).
-compile(export_all).

-include("packages.hrl").

start() ->
    register(interface, spawn(?MODULE, init, [])).

stop() ->
    carwash ! stop,
    moneybox ! stop,
    appointment ! stop,
    interface ! stop.

now(Package) -> rpc({now, Package}).
later(Package) -> rpc({later, Package}).
redeem(Code) -> rpc({redeem, Code}).

rpc(Request) ->
    Pid = whereis(interface),
    Pid ! {self(), Request},
    receive
        {Pid, Response} -> Response
    end.

init() ->
    carwash:start(),
    moneybox:start(),
    appointment:start(),
    loop(define_packages()).

loop(Packages) ->
    receive
        stop -> exit(normal);
        {From, {later, Package}} ->
            Response = sell_package(fun do_later/1, Package, Packages),
            From ! {self(), Response},
            loop(Packages);
        {From, {redeem, Code}} ->
            case appointment:claim(Code) of
                {ok, Package} ->
                    do_now(Package),
                    From ! {self(), ok},
                    loop(Packages);
                error ->
                    From ! {self(), {error, bad_code}},
                    loop(Packages)
            end;
        {From, {now, Package}} ->
            case carwash:is_working() of
                true ->
                    Response = sell_package(fun do_now/1, Package, Packages),
                    From ! {self(), Response},
                    loop(Packages);
                false ->
                    From ! {self(), {error, not_working}},
                    loop(Packages)
            end
    end.

sell_package(Fun, Any, Packages) ->
    case dict:find(Any, Packages) of
        {ok, The} ->
            case moneybox:spend(The#package.cost) of
                {ok, _Balance} ->
                    {Fun(The), moneybox:make_change()};
                Error -> Error
            end;
        error -> {error, no_such_package}
    end.

do_later(Package) ->
    io:format("Creating appointment for ~p~n", [Package#package.name]),
    appointment:create(Package).

do_now(The) ->
    lists:foreach(fun(Action) ->
                          apply(carwash, Action, [])
                  end, The#package.actions).

define_packages() ->
    ListWithKeys = lists:map(fun(P) ->
                                     {P#package.id, P}
                             end, ?PACKAGES),
    dict:from_list(ListWithKeys).

