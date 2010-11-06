-module(game).
-compile(export_all).

	
iterate(World) ->
	lists:usort(iterate(World, World)).
	
iterate([], World) -> [];
iterate([Cell|T], World) ->

	TempWorld = processDeadNeighbors(Cell, World),
	case getFutureLivingState(Cell, World) of
		Cell -> 
			[Cell | TempWorld ++ iterate(T, World)];
		will_die -> 
			TempWorld ++ iterate(T, World)
	end.


getFutureLivingState(Cell, World) ->
	case length(getLivingNeighbors(Cell, World)) of
		0 -> will_die;
		1 -> will_die;
		2 -> Cell;
		3 -> Cell;
		_More -> will_die
	end.
	
processDeadNeighbors(LivingCell, World) ->
	Fn = fun(DeadCell) -> getFutureDeadNeighborState(DeadCell, World) == DeadCell end,
	lists:filter(Fn, getDeadNeighbors(LivingCell, World)).
	
getFutureDeadNeighborState(DeadCell, World) ->
	case length(getLivingNeighbors(DeadCell, World)) of
		0 -> still_dead;
		1 -> still_dead;
		2 -> still_dead;
		3 -> DeadCell;
		_More -> still_dead
	end.
	
getDeadNeighbors(Cell, World) ->
	getDead(getNeighbors(Cell, World), World).

getLivingNeighbors(Cell, World) ->
	getLiving(getNeighbors(Cell, World), World).

	
getNeighbors({X,Y}, World) ->
	[{X,Y-1},{X,Y+1},{X-1,Y-1},{X-1,Y},{X-1,Y+1},{X+1,Y-1},{X+1,Y},{X+1,Y+1}].
	
	
getLiving(Cells, World) ->
	ExistsFn = fun(Cell) -> lists:member(Cell, World) end,
	lists:filter(ExistsFn, Cells).

getDead(Cells, World) ->
	NotExistsFn = fun(Cell) -> not(lists:member(Cell, World)) end,
	lists:filter(NotExistsFn, Cells).	
	
	
	
	
	
	
	

	
	
%getLiveNeighbors({X,Y}, [{Lx,Ly}|Tail], N) ->
%	Yp1 = Y+1,
%	Ym1 = Y-1,
%	Xp1 = X+1,
%	Xm1 = X-1,
%	NewN = case {Lx,Ly} of
%		{X,Yp1} -> [{Lx,Ly}|N];
%		{X,Ym1} -> [{Lx,Ly}|N];
%		{Xm1, Ym1} -> [{Lx,Ly}|N];
%		{Xm1, Y} -> [{Lx,Ly}|N];
%		{Xm1, Yp1} -> [{Lx,Ly}|N];
%		{Xp1, Ym1} -> [{Lx,Ly}|N];
%		{Xp1, Y} -> [{Lx,Ly}|N];
%		{Xp1, Yp1} -> [{Lx,Ly}|N];
%		_Other -> N
%	end,
%	getLiveNeighbors({X,Y}, Tail, NewN).
	
	
