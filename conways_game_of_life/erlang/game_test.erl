%% Author: Jonathan
%% Created: Nov 7, 2010
-module(game_test).
-include_lib("eunit/include/eunit.hrl").

%%
%% Exported Functions
%%
-export([]).

%%
%% Tests
%%
all_dead_test() ->
	assertListsEqual([], game:iterate([])).

zero_neighbors_test() ->
	Board = [{0,0}],
	Expected = [],
	assertListsEqual(Expected, game:iterate(Board)).

one_neighbor_test() ->
	Board = [{0,0},{0,1}],
	Expected = [],
	assertListsEqual(Expected, game:iterate(Board)).

%L-shape. All 3 should stay alive. {1,1} should spawn.
%  *       **
%  **  ->  **
two_neighbors_test() ->
	Board = [{0,0},{0,1},{1,0}],
	Expected = [{0,0},{0,1},{1,0},{1,1}],
	assertListsEqual(Expected, game:iterate(Board)).

%  *       ***
% ***  ->  ***
%           *
three_neighbors_test() ->
	Board = [{0,0},{1,0},{-1,0},{0,1}],
	Expected = [{0,0},{-1,0},{-1,1},{0,1},{0,-1},{1,1},{1,0}],
	assertListsEqual(Expected, game:iterate(Board)).

%   *       ***
%  ***  ->  * *
%   *       ***
four_neighbors_test() ->
	Board = [{0,0},{1,0},{-1,0},{0,1},{0,-1}],
	Expected = [{-1,0},{-1,1},{0,1},{0,-1},{1,1},{1,0},{1,-1},{-1,-1}],
	assertListsEqual(Expected, game:iterate(Board)).

%             *
%  ***       * *
%  * *  ->  *   * 
%  ***       * *
%             *
many_neighbors_test() ->
	Board = [{-1,0},{-1,1},{0,1},{0,-1},{1,1},{1,0},{1,-1},{-1,-1}],
	Expected = [{-2,0},{-1,1},{0,2},{1,1},{2,0},{1,-1},{0,-2},{-1,-1}],
	assertListsEqual(Expected, game:iterate(Board)).


%%
%% Local Functions
%%
assertListsEqual(List1, List2) ->
	?assertEqual(lists:sort(List1), lists:sort(List2)).
