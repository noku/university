% Determine the prime factors of a given positive integer. 

% descomp(N, L) :-  L is the list of prime factors of N.
%    (integer,list) (+,?)

descomp(N,L) :- N > 0,  descomp(N,L,2).

% descomp(N,L,K) :- L is the list of prime factors of N. It is 
% known that N does not have any prime factors less than K.
% (30, [], 2)
% (30, [F|L], 2)
% R = 30/2, 30 == 15 * 2, true 
% (15, [F|L], 2)
% R = 15/2, 30 == 7 * 2, false
% (15, L, 2)
% next_factor(15, 2, NF)
% next_factor(_, 2, 3)
% ...
% next_factor(5, 3, NF)
% next_factor(5, _, 5)

descomp(1,[],_) :- !.
descomp(N,[F|L],F) :-   % N is multiple of F
   R is N // F, N =:= R * F, !, descomp(R,L,F).
descomp(N,L,F) :- 
   next_factor(N,F,NF), descomp(N,L,NF).        % N is not multiple of F
   
% next_factor(N,F,NF) :- when calculating the prime factors of N
%    and if F does not divide N then NF is the next larger candidate to
%    be a factor of N.

next_factor(_,2,3) :- !.
next_factor(N,F,NF) :- F * F < N, !, NF is F + 2.
next_factor(N,_,N).                                 % F > sqrt(N)