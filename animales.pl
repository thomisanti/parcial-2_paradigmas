% animales.pl - Punto 3: clasificacion de animales
% a) Animales: perro, gato, aguila, pinguino, delfin, tiburon, serpiente, rana
% b) Caracteristicas minimas: pelo, plumas, escamas, vuela, vive_en_agua, respira_por_pulmones, pone_huevos, tiene_aletas
% c) Hechos: caracteristicas observadas de cada ejemplar
caracteristica(ejemplar1, pelo).     caracteristica(ejemplar1, ladra).
caracteristica(ejemplar2, pelo).     caracteristica(ejemplar2, maulla).
caracteristica(ejemplar3, plumas).   caracteristica(ejemplar3, vuela).
caracteristica(ejemplar4, plumas).   caracteristica(ejemplar4, vive_en_agua).
caracteristica(ejemplar5, aletas).   caracteristica(ejemplar5, pulmones).  caracteristica(ejemplar5, vive_en_agua).
caracteristica(ejemplar6, aletas).   caracteristica(ejemplar6, branquias). caracteristica(ejemplar6, vive_en_agua).
caracteristica(ejemplar7, escamas).  caracteristica(ejemplar7, sin_patas).
caracteristica(ejemplar8, piel_humeda). caracteristica(ejemplar8, salta).
 
% d) Reglas de clasificacion por grupo
clase(X, mamifero) :- caracteristica(X, pelo).
clase(X, mamifero) :- caracteristica(X, aletas), caracteristica(X, pulmones).
clase(X, ave)      :- caracteristica(X, plumas).
clase(X, pez)      :- caracteristica(X, aletas), caracteristica(X, branquias).
clase(X, reptil)   :- caracteristica(X, escamas).
clase(X, anfibio)  :- caracteristica(X, piel_humeda).
 
% Reglas para identificar cada animal
animal(X, perro)     :- clase(X, mamifero), caracteristica(X, ladra).
animal(X, gato)      :- clase(X, mamifero), caracteristica(X, maulla).
animal(X, aguila)    :- clase(X, ave), caracteristica(X, vuela).
animal(X, pinguino)  :- clase(X, ave), caracteristica(X, vive_en_agua), \+ caracteristica(X, vuela).
animal(X, delfin)    :- clase(X, mamifero), caracteristica(X, vive_en_agua).
animal(X, tiburon)   :- clase(X, pez).
animal(X, serpiente) :- clase(X, reptil), caracteristica(X, sin_patas).
animal(X, rana)      :- clase(X, anfibio), caracteristica(X, salta).
 
% e) 5 consultas de verificacion:
% ?- animal(ejemplar1, A).      % A = perro
% ?- animal(ejemplar4, A).      % A = pinguino
% ?- animal(ejemplar5, A).      % A = delfin
% ?- animal(X, serpiente).      % X = ejemplar7
% ?- clase(ejemplar3, C).       % C = ave
