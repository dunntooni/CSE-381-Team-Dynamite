-module(w01).
-export([test/0, newMap/2]).

% Map Function
newMap([], _) -> [];
newMap([H | T], MyFunc) -> [MyFunc(H)] ++ newMap(T, MyFunc).

% Filter Function 1
newFilter([], _) ->
    [];
newFilter([H | T], MyFunc) ->
    case MyFunc(H) of
        true -> [H] ++ newFilter(T, MyFunc);
        false -> newFilter(T, MyFunc)
    end.

% Filter Function 2

% GCD Algorithm 1
newGCD(M, 0) -> M;
newGCD(M, N) -> newGCD(N, M rem N).

extendedGCD(A, B) ->
    ext_helper(A, B, {0, 1}, {1, 0}).

% GCD Algorithm 2
ext_helper(0, B, _, _) ->
    B;
ext_helper(A, B, {X, Y}, {U, V}) ->
    Q = B div A,
    ext_helper(B rem A, A, {U, V}, {X - U * Q, Y - V * Q}).

% Sieve of Eratosthenese

sieve(Acc, []) ->
    Acc;
sieve(Acc, [H | T]) ->
    case is_multiple_of(Acc, H) of
        true -> sieve(Acc, T);
        false -> sieve(Acc ++ H, T)
    end.

is_multiple_of([], _) ->
    false;
is_multiple_of([H | T], Acc) ->
    % io:fwrite("Head: ~B Tail: ~B~n", [H, T]),
    case (0 == (Acc rem H)) of
        true -> true;
        false -> is_multiple_of(T, Acc)
    end.

test() ->
    % For use with the map function
    Double = fun(X) -> X * 2 end,

    [X, Y, Z] = newMap([25, 30, 35], Double),
    X = 50,
    Y = 60,
    Z = 70,
    io:fwrite("Map: ~B~n", [X]),
    io:fwrite("Map: ~B~n", [Y]),
    io:fwrite("Map: ~B~n", [Z]),

    % For use with the filter function
    IsEven = fun(Num) -> Num rem 2 == 0 end,

    [] = newFilter([], IsEven),
    [D, E, F] = newFilter([25, 30, 32, 35, 40], IsEven),
    D = 30,
    E = 32,
    F = 40,
    io:fwrite("Filter: ~B~n", [D]),
    io:fwrite("Filter: ~B~n", [E]),
    io:fwrite("Filter: ~B~n", [F]),
    G = newGCD(40, 50),
    % should be 10
    io:fwrite("newGCD: ~B~n", [G]),
    H = extendedGCD(40, 50),
    % should be 10
    io:fwrite("extendedGCD: ~B~n", [H]),
    I = sieve([2], lists:seq(2, 30)),
    io:fwrite("sieve: ~B~n", [I]).
