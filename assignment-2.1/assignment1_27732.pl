candidate_number(27732).

% Q1 - retrieve start position
q1(ailp_start_position(P)).

% Q2a - Agent at (1,1) and should move east, write query to retrieve the new position
q2a(new_pos(p(1,1), e, X)).

% Q2b - Agent at (1,1) and wants to move north. What line does this fail?
q2b(109). % X1 >= 1, Y1 >=1,

% Q3 - If an agent moves by simply calling this predicate, moving to the new position, then backtracking to retrieve another direction by calling this predicate again, what is the order of the directions that the agent will move in
q3([s,e,w,n]). % Based on order they appear in file

% Q4a - Path from starting position until first dead end (before agent starts backtracking)
q4b([]).

% Q4b - After backtracking once and thereby avoiding the first dead end, give the full path from the starting position to the second dead end.
q4b([]).

% Q4c - ve the first full path covering the whole grid found by the agent.
q4c([p(1, 4), p(2, 4), p(3, 4), p(4, 4), p(4, 3), p(3, 3), p(2, 3), p(1, 3), p(1, 2), p(2, 2), p(3, 2), p(4, 2), p(4, 1), p(3, 1), p(2, 1), p(1, 1)]).

% Q4d - Give the second full path covering the whole grid found by the agent.
q4d([p(1, 4), p(2, 4), p(3, 4), p(4, 4), p(4, 3), p(3, 3), p(2, 3), p(1, 3), p(1, 2), p(1, 1), p(2, 1), p(2, 2), p(3, 2), p(4, 2), p(4, 1), p(3, 1)]).

% Q5a - Write a predicate called q5_corner_move/0 that moves the agent between all 4 corner squares in the world, in any order. The agent should not visit any other squares.

q5_corner_move :-
  ailp_start_position(X),
  ailp_show_move(X, p(1, 1)),
  ailp_show_move(p(1,1),p(1,4)),
  ailp_show_move(p(1,4),p(4,4)),
  ailp_show_move(p(4,4),p(4,1)),
  ailp_show_move(p(4,1),p(1,1)).

% Q5b - Write another predicate q5_corner_move2/0 that uses this ailp_grid_size/1 predicate so that the agent moves between the corners no matter the size of the grid. (i.e. the locations are not hard coded)
q5_corner_move2 :-
  ailp_grid_size(S),
  ailp_start_position(X),
  ailp_show_move(X, p(1, 1)),
  ailp_show_move(p(1,1), p(1, S)),
  ailp_show_move(p(1,S), p(S, S)),
  ailp_show_move(p(S,S), p(S, 1)),
  ailp_show_move(p(S,1), p(1, 1)).


move(p(X,Y), Direction, Length, p(X1,Y1)) :-
  ( Direction = s -> X1 is X,   Y1 is Y+1
  ; Direction = n -> X1 is X,   Y1 is Y-1
  ; Direction = e -> X1 is X+1, Y1 is Y
  ; Direction = w -> X1 is X-1, Y1 is Y
  ),
  X1 >= 1, Y1 >= 1,
  X1 =< Length, Y1 =< Length.

direction(e, _, _, p(1, 1)).
direction(n, _, Length, p(1, Length)).
direction(w, _, Length, p(Length, Length)).
direction(s, _, Length, p(Length, 1)).
direction(LastDirection, LastDirection, _, _).

% Path of a square with sides of length N and offset from position P
square([p(1, 1)], 1).
square(Path, Length) :-
  Length > 1,
  once(square([], Length, p(1, 1), e, Path)).

% When we have done the correct number of iterations
square(L, Length, _, _, L) :-
  N is Length*4-4,
  length(L, N).

square(L, Length, LastPoint, LastDirection, Path) :-
  direction(Direction, LastDirection, Length, LastPoint),
  move(LastPoint, Direction, Length, NewPoint),
  \+ memberchk(NewPoint, L),
  square([NewPoint|L], Length, NewPoint, Direction, Path).

offset([], _, []).
offset([p(X,Y)|L], p(XO,YO), [p(X1,Y1)|LO]) :-
  X1 is X+XO, Y1 is Y+YO,
  offset(L, p(XO,YO), LO).

% Q6 -Write a predicate q6_spiral/1 that has a single argument being the path taken by the agent. The agent should start in one of the outer squares (any square next to the edge of the board), and cover the board in a spiral (either clockwise or anticlockwise) such that it ends in one of the 4 central positions.
q6_spiral(L) :- 
  ailp_grid_size(N),
  q6_spiral([], N, 0, L).

q6_spiral(L, _, _, L) :-
  ailp_grid_size(N),
  N1 is N*N,
  length(L, N1).
  
q6_spiral(L, N, I, Ls) :-
  N >= 1,
  square(P, N),
  offset(P, p(I, I), P1),
  append(L, P1, L1),
  I1 is I + 1,
  N1 is N - 2,
  q6_spiral(L1, N1, I1, Ls).
  
