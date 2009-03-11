-module(moneybox).
-export([start/0,stop/0]).
-export([deposit/1,deposit_money/1,deposit_tokens/1,
         insert/1,spend/1,make_change/0]).
-export([loop/1]).

-include("packages.hrl").

start() ->
    register(moneybox, spawn(?MODULE, loop, [#amount{}])).

stop() -> moneybox ! stop.

deposit(Amount) when is_record(Amount, amount) ->
    rpc({deposit, Amount});
deposit(Amount) ->
    {badrecord, Amount}.

deposit_money(Money) -> rpc({deposit, #amount{money=Money}}).
deposit_tokens(Tokens) -> rpc({deposit, #amount{tokens=Tokens}}).
insert(Amount) -> deposit(Amount).

spend(Amount) when is_record(Amount, amount) ->
    rpc({spend, Amount});
spend(Amount) ->
    {badrecord, Amount}.

make_change() -> rpc(make_change).

loop(Balance) ->
    receive
        stop -> exit(normal);
        {From, {deposit, Amount}} ->
            NewBalance = add_amount(Balance, Amount),
            From ! {self(), {ok, NewBalance}},
            loop(NewBalance);
        {From, {spend, The}} ->
            if
                The#amount.tokens =< Balance#amount.tokens ->
                    NewBalance = subtract_tokens(Balance, The),
                    From ! {self(), {ok, NewBalance}},
                    loop(NewBalance);
                The#amount.money =< Balance#amount.money ->
                    NewBalance = subtract_money(Balance, The),
                    From ! {self(), {ok, NewBalance}},
                    loop(NewBalance);
                true ->
                    Needed = subtract_amount(The, Balance),
                    From ! {self(), {error, not_enough, Needed}},
                    loop(Balance)
            end;
        {From, make_change} ->
            From ! {self(), {change, Balance}},
            loop(#amount{})
    end.

rpc(Message) ->
    Pid = whereis(moneybox),
    Pid ! {self(), Message},
    receive
       {Pid, Response} -> Response
    end.

add_amount(A, B) ->
    #amount{money = A#amount.money + B#amount.money,
            tokens = A#amount.tokens + B#amount.tokens}.

subtract_amount(A, B) ->
    #amount{money = A#amount.money - B#amount.money,
            tokens = A#amount.tokens - B#amount.tokens}.

subtract_tokens(A, B) ->
    subtract_amount(A, B#amount{money=0}).

subtract_money(A, B) ->
    subtract_amount(A, B#amount{tokens=0}).
