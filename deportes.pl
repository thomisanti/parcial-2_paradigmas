% deportes.pl - Punto 1: sistema experto que recomienda un deporte
% Base de conocimiento: caracteristicas de cada deporte
deporte(futbol,     [equipo, balon, aire_libre, resistencia]).
deporte(baloncesto, [equipo, balon, cancha_cubierta, saltos]).
deporte(natacion,   [individual, agua, resistencia]).
deporte(tenis,      [individual, raqueta, aire_libre, reflejos]).
deporte(ciclismo,   [individual, aire_libre, resistencia, bicicleta]).
deporte(judo,       [individual, contacto, reflejos, cancha_cubierta]).

% Hechos dinamicos con las respuestas del usuario
:- dynamic si/1, no/1.

pregunta(equipo,          'Te gusta jugar en equipo').
pregunta(individual,      'Prefieres un deporte individual').
pregunta(balon,           'Quieres usar un balon').
pregunta(agua,            'Quieres practicarlo en el agua').
pregunta(aire_libre,      'Prefieres practicarlo al aire libre').
pregunta(resistencia,     'Tienes buena resistencia fisica').
pregunta(reflejos,        'Te gustan los deportes de reflejos rapidos').
pregunta(contacto,        'Aceptas contacto fisico').

% Motor de inferencia: un deporte se recomienda si TODAS las
% caracteristicas del usuario que se preguntan se cumplen
verifica(C) :- si(C), !.
verifica(C) :- no(C), !, fail.
verifica(C) :- pregunta(C, Texto), !,
    format('~w? (s/n): ', [Texto]), read(R),
    ( R == s -> assertz(si(C)) ; assertz(no(C)), fail ).
verifica(_).   % caracteristicas sin pregunta se aceptan

recomendar(D) :- deporte(D, Cs), forall(member(C, Cs), verifica(C)).

% Explicacion: por que se recomienda
explicar(D) :- deporte(D, Cs),
    format('Se recomienda ~w porque cumple: ~w~n', [D, Cs]).

iniciar :- retractall(si(_)), retractall(no(_)),
    ( recomendar(D) -> explicar(D) ; writeln('No hay deporte que cumpla tus preferencias') ).

% Uso:  ?- iniciar.   (responde con  s.  o  n.  incluyendo el punto)
