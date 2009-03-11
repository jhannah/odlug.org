-module(carwash).
-export([start/0,stop/0]).
-export([soak/0,touchless/0,wash/0,wax/0]).
-export([start_working/0,stop_working/0,is_working/0]).
-export([loop/0]).

start() ->
    register(carwash, spawn(?MODULE, loop, [])).

stop() -> carwash ! stop.

soak() -> rpc(soak).
touchless() -> rpc(touchless).
wash() -> rpc(wash).
wax() -> rpc(wax).

is_working() -> rpc(is_working).
stop_working() -> rpc(stop_working).
start_working() -> rpc(start_working).

loop() ->
    receive
        stop ->
            exit(normal);
        {From, soak} ->
            io:format("Soaking...~n"),
            From ! {self(), ok},
            loop();
        {From, touchless} ->
            io:format("Touchless...~n"),
            From ! {self(), ok},
            loop();
        {From, wash} ->
            io:format("Washing...~n"),
            From ! {self(), ok},
            loop();
        {From, wax} ->
            io:format("Waxing...~n"),
            From ! {self(), ok},
            loop();
        {From, is_working} ->
            From ! {self(), true},
            loop();
        {From, stop_working} ->
            From ! {self(), ok},
            not_working_loop();
        {From, Any} ->
            From ! {self(), {error, unknown, Any}}
    end.

not_working_loop() ->
    receive
        {From, start_working} ->
            From ! {self(), ok},
            loop();
        {From, is_working} ->
            From ! {self(), false},
            not_working_loop();
        {From, _Any} ->
            From ! {self(), {error, not_working}},
            not_working_loop()
    end.

rpc(Message) ->
    Pid = whereis(carwash),
    Pid ! {self(), Message},
    receive
        {Pid, Response} -> Response
    end.
