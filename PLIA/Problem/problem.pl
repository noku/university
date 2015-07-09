Domains
s=Symbol*
c=s(Symbol,Symbol,Symbol,Symbol,Symbol)
c1=c*

Predicates
perm(s1, s1)
e1(Symbol, s1, s1)
r(INTEGER, c1)
solutie(c1)
apartine(c, c1)

Clauses
apartine(X, [X|_]).
apartine(X, [_|XS]):- apartine(X,XS).
perm([],[]).
perm([X|L], LP):- perm(L, LP1), el(X, LP, LP1).

el(X, [X|L], L).
el(X, [Y|L], [Y|L2]):-el(X, L, L2).

r(1, [s(Daisy,fem,N1,P1,Java), s(Steve,masc,N2,P2,Z2), s(Liewellyn,masc,N3,P3,Z3), s(Gertrude,fem,N4,P4,Z4)]):-
perm([N1,N2,N3,N4], [emacs, vi, pico, joe]),
perm([P1,P2,P3,P4], [Solaris, AIX, Linux, BSD]),
perm([Z1,Z2,Z3,Z4], [C++, Java, Perl, Lisp]),
P1<>"Solaris", P3<>"AIX".
r(2, Programatori):- apartine(s(_,masc,emacs,_,Lisp), Programatori).
r(3, Programatori):- apartine(s(_,fem,pico,BSD, Z1), Programatori), Z1<>"C++", Z1<>"Java".
r(4, Programatori):- apartine(s(_,_,joe,AIX,C++), Programatori).

solutie(Programatori):-
r(1, Programatori),
r(2, Programatori),
r(3, Programatori),
r(4, Programatori).
