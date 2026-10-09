% estudiante.pl - Punto 4: nivel de programacion de estudiantes de 1er semestre
% Temas basicos de programacion
tema(variables).
tema(condicionales).
tema(ciclos).
tema(funciones).
tema(arreglos).

% Hechos: lo que conoce cada estudiante
conoce(ana,   variables).  conoce(ana,   condicionales). conoce(ana,   ciclos).
conoce(ana,   funciones).  conoce(ana,   arreglos).
conoce(luis,  variables).  conoce(luis,  condicionales). conoce(luis,  ciclos).
conoce(sofia, variables).
conoce(mario, variables).  conoce(mario, condicionales). conoce(mario, ciclos). conoce(mario, funciones).
estudiante(ana). estudiante(luis). estudiante(sofia). estudiante(mario). estudiante(pedro).

% Cantidad de temas dominados
cuantos(E, N) :- estudiante(E), aggregate_all(count, (tema(T), conoce(E, T)), N).

% Reglas de clasificacion
nivel(E, avanzado)   :- cuantos(E, N), N >= 5.
nivel(E, intermedio) :- cuantos(E, N), N >= 3, N < 5.
nivel(E, principiante) :- cuantos(E, N), N < 3.

% Temas que le faltan
falta(E, T) :- estudiante(E), tema(T), \+ conoce(E, T).

% Consultas:
% ?- nivel(ana, N).          % avanzado
% ?- nivel(mario, N).        % intermedio
% ?- nivel(pedro, N).        % principiante (no conoce ningun tema)
% ?- nivel(E, principiante).
% ?- findall(T, falta(luis, T), L).   % [funciones, arreglos]
