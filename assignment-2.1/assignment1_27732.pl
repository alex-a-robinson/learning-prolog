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
q4b([p(1,1),p(2,1),p(3,1),p(4,1),p(4,2),p(3,2),p(2,2),p(1,2),p(1,3),p(2,3),p(3,3),p(4,3),p(4,4),p(3,4),p(2,4),p(1,4)]). % TODO: Check this

% Q4b - After backtracking once and thereby avoiding the first dead end, give the full path from the starting position to the second dead end.
q4b([p(4,2),p(4,1),p(3,1),p(3,2),p(2,2),p(1,2),p(1,3),p(2,3),p(3,3),p(4,3),p(4,4),p(3,4),p(2,4),p(1,4)]). % TODO: Check this

% Q4c - ve the first full path covering the whole grid found by the agent.
q4c(). % TODO: backtracking?

% Q4d - Give the second full path covering the whole grid found by the agent.
q4d(). % TODO: ?

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

% Q6 -Write a predicate q6_spiral/1 that has a single argument being the path taken by the agent. The agent should start in one of the outer squares (any square next to the edge of the board), and cover the board in a spiral (either clockwise or anticlockwise) such that it ends in one of the 4 central positions.

% TODO
%   - Move to the right, then when hit wall down, then when hit wall, left, then up. Use the grid size to know if hit a wall or not. 
%   - Once come across cell which is already in path, then move to p(2, 2) then p(3, 3) until at p(S/2, S/2) which is one of the centre squares in which case stop
q6_spiral([]) :-
  ailp_start_position(p(1, 1)),
  q6_spiral([p(1, 1)]).

q6_spiral([p(X,Y),p(X1,Y1)|L]) :-
  ailp_grid_size(S),
  ( Y1 = 1 -> Y = Y1,    X is X1+1
  ; X1 = S -> Y is Y1+1, X = X1
  ; Y1 = S -> Y = Y1,    X is X1-1
  ; X1 = 1 -> Y is Y1-1, X = X1
  ),
  (member(p(X,Y), [p(X1,Y1)|L]) -> X is X1, Y is Y1+1).
  X >= 1, Y >= 1,
  X =< S, Y =< S,
  
