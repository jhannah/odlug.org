-module(game).
%%
%% Exported Functions
%%
-export([iterate/1]).

%%
%% API Functions
%%
iterate(World) ->
	getFutureStates(getRelevantCells(World), World).


%%
%% Local Functions
%%	
getRelevantCells(Cells) ->
	lists:usort(getRelevantCells_impl(Cells)).

getRelevantCells_impl([]) -> [];
getRelevantCells_impl([Cell|T]) ->
	getNeighbors(Cell) ++ getRelevantCells(T).


getFutureStates([], _World) -> [];
getFutureStates([Cell|T], World) ->
	Alive = lists:member(Cell, World),
	LivingNeighborCount = getNeighborCount(Cell, World),
	
	case {Alive, LivingNeighborCount} of
		{true, 2} -> [Cell|getFutureStates(T, World)];
		{_Either, 3} -> [Cell|getFutureStates(T, World)];
		_Other -> getFutureStates(T, World)
	end.


getNeighborCount(Cell, World) ->
	CountFn = fun(C, Count) -> 
		case lists:member(C, World) of
			true -> 1 + Count;
			false -> Count
		end
		end,
	lists:foldl(CountFn, 0, getNeighbors(Cell)).

getNeighbors({X,Y}) ->
	[{X,Y-1},{X,Y+1},{X-1,Y-1},{X-1,Y},{X-1,Y+1},{X+1,Y-1},{X+1,Y},{X+1,Y+1}].

