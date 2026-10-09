
% arbolgenialogico.pl  -  Punto 2: Arbol genealogico en Prolog
% Notacion: padre(Padre, Hijo).  madre(Madre, Hijo).

:- discontiguous padre/2, madre/2, hombre/1, mujer/1.


% HECHOS: LADO MATERNO (familia de mi mama, alejandra)

% Tatarabuelos paez (hombre) y mozquera (mujer) -> bisabuelo alfredo
padre(paez, alfredo).
madre(mozquera, alfredo).
% Bisabuelos alfredo y anna -> abuela mabel
padre(alfredo, mabel).
madre(anna, mabel).
% Abuelos rafael y mabel -> diego, camila y alejandra (mi mama)
padre(rafael, diego).     madre(mabel, diego).
padre(rafael, camila).    madre(mabel, camila).
padre(rafael, alejandra). madre(mabel, alejandra).
% Prima camilita, hija de camila
madre(camila, camilita).


% HECHOS: LADO PATERNO (familia de mi papa, gio)

% Tatarabuelos cont (hombre) e indi (mujer) -> bisabuelo cordoba
padre(cont, cordoba).
madre(indi, cordoba).
% Bisabuelos cordoba y gomez -> abuela silvia
padre(cordoba, silvia).
madre(gomez, silvia).
% Abuelos teofilo y silvia -> carlos, jeidy, carmen, andres y gio (mi papa)
padre(teofilo, carlos).  madre(silvia, carlos).
padre(teofilo, jeidy).   madre(silvia, jeidy).
padre(teofilo, carmen).  madre(silvia, carmen).
padre(teofilo, andres).  madre(silvia, andres).
padre(teofilo, gio).     madre(silvia, gio).
% Primas arlet y sofia, hijas de carmen
madre(carmen, arlet).
madre(carmen, sofia).

% HECHOS: MI FAMILIA NUCLEAR (gio y alejandra)

padre(gio, yo).      madre(alejandra, yo).
padre(gio, oriana).  madre(alejandra, oriana).
padre(gio, esteban). madre(alejandra, esteban).


% HECHOS: SEXO

hombre(paez). hombre(alfredo). hombre(rafael). hombre(diego).
hombre(cont). hombre(cordoba). hombre(teofilo). hombre(carlos).
hombre(andres). hombre(gio). hombre(esteban).
% Sexo de "yo": quita el % de la linea que corresponda
% hombre(yo).
% mujer(yo).

mujer(mozquera). mujer(anna). mujer(mabel). mujer(camila).
mujer(alejandra). mujer(camilita).
mujer(indi). mujer(gomez). mujer(silvia). mujer(jeidy).
mujer(carmen). mujer(arlet). mujer(sofia). mujer(oriana).


% REGLAS

progenitor(P, H) :- padre(P, H).
progenitor(P, H) :- madre(P, H).

hijo(H, P) :- progenitor(P, H), hombre(H).
hija(H, P) :- progenitor(P, H), mujer(H).

hermanos(X, Y) :- progenitor(P, X), progenitor(P, Y), X \= Y.
hermano(X, Y)  :- hermanos(X, Y), hombre(X).
hermana(X, Y)  :- hermanos(X, Y), mujer(X).

abuelo(A, N)  :- progenitor(P, N), padre(A, P).
abuela(A, N)  :- progenitor(P, N), madre(A, P).

bisabuelo(B, N) :- progenitor(P, N), progenitor(Q, P), padre(B, Q).
bisabuela(B, N) :- progenitor(P, N), progenitor(Q, P), madre(B, Q).

tatarabuelo(T, N) :- progenitor(P, N), progenitor(Q, P), progenitor(R, Q), padre(T, R).
tatarabuela(T, N) :- progenitor(P, N), progenitor(Q, P), progenitor(R, Q), madre(T, R).

tio(T, S)  :- progenitor(P, S), hermano(T, P).
tia(T, S)  :- progenitor(P, S), hermana(T, P).

sobrino(S, T) :- hombre(S), progenitor(P, S), hermanos(P, T).
sobrina(S, T) :- mujer(S),  progenitor(P, S), hermanos(P, T).

% primo(X, Y): X es primo o prima de Y (padres hermanos)
primo(X, Y) :- progenitor(P, X), progenitor(Q, Y), hermanos(P, Q), X \= Y.


% CONSULTAS DE EJEMPLO (escribelas en la consola, con punto final)
% Resultados esperados entre parentesis

% ?- abuelo(A, yo).                       (rafael, teofilo)
% ?- abuela(A, yo).                       (mabel, silvia)
% ?- bisabuelo(B, yo).                    (alfredo, cordoba)
% ?- tatarabuelo(T, yo).                  (paez, cont)
% ?- tio(T, yo).                          (diego, carlos, andres)
% ?- hermano(H, yo).                      (esteban)
% ?- setof(P, primo(P, yo), L).           (camilita, arlet, sofia)
%
% Consultas complejas con AND (,), OR (;) y NOT:
% ?- abuelo(A, yo), padre(A, gio).                         AND  (teofilo)
% ?- tio(T, yo) ; tia(T, yo).                              OR   (tios y tias)
% ?- (tio(T, yo) ; tia(T, yo)), not(hombre(T)).            OR + NOT (camila, jeidy, carmen)
% ?- primo(P, yo), not(progenitor(carmen, P)).             AND + NOT (camilita)
% ?- tatarabuelo(T, yo) ; tatarabuela(T, yo).              OR   (paez, cont, mozquera, indi)
% ?- sobrina(S, jeidy), madre(carmen, S).                  AND  (arlet, sofia)
