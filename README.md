# parcial-2_paradigmas

# Sistema experto de deportes en Prolog

Sistema experto sencillo hecho en **SWI-Prolog** que recomienda un deporte según las preferencias del usuario. Hace preguntas de sí/no, guarda las respuestas y explica por qué recomienda el deporte.

Proyecto de la práctica de laboratorio de Sistemas Expertos en Prolog (Paradigmas de Programación).

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) (versión estable)

## Cómo ejecutarlo

1. Clona o descarga este repositorio.
2. Abre una terminal en la carpeta del proyecto y carga el archivo:

   ```bash
   swipl deportes.pl
   ```

3. En el prompt de Prolog, inicia el sistema:

   ```prolog
   ?- iniciar.
   ```

4. Responde cada pregunta con `s.` (sí) o `n.` (no). **Incluye el punto final.**

## Ejemplo de uso

```
?- iniciar.
Te gusta jugar en equipo? (s/n): s.
Quieres usar un balon? (s/n): s.
Prefieres practicarlo al aire libre? (s/n): s.
Tienes buena resistencia fisica? (s/n): s.
Se recomienda futbol porque cumple: [equipo,balon,aire_libre,resistencia]
```

## Deportes incluidos

Fútbol, baloncesto, natación, tenis, ciclismo y judo.

## Cómo funciona

| Componente | Descripción |
|---|---|
| Base de conocimiento | `deporte/2` (deporte y sus características) y `pregunta/2` (texto de cada pregunta) |
| Memoria de trabajo | Hechos dinámicos `si/1` y `no/1` con las respuestas del usuario |
| Motor de inferencia | `verifica/1` y `recomendar/1`, junto con la unificación y el backtracking de Prolog |
| Explicación | `explicar/1` muestra por qué se recomendó el deporte |
| Punto de entrada | `iniciar/0` |

**Lógica principal:** un deporte se recomienda si el usuario cumple **todas** sus características. Si alguna falla, Prolog prueba con el siguiente deporte reutilizando las respuestas ya dadas.

```prolog
recomendar(D) :- deporte(D, Cs), forall(member(C, Cs), verifica(C)).
```

## Agregar un deporte

Añade un hecho nuevo en `deportes.pl`:

```prolog
deporte(voleibol, [equipo, balon, cancha_cubierta, saltos]).
```

Si usas una característica nueva y quieres que se pregunte, agrega también su pregunta:

```prolog
pregunta(raqueta, 'Quieres usar una raqueta').
```

## Limitaciones

- Las características sin pregunta (`cancha_cubierta`, `saltos`, `raqueta`, `bicicleta`) se aceptan automáticamente.
- Devuelve el primer deporte que cumple, no el mejor.
- Las respuestas deben escribirse como `s.` o `n.` (con punto).

## Referencias

- Patrón de reglas "si tiene tales características, entonces es X": <https://metalevel.at/prolog/expertsystems>

# Sistema experto para clasificar animales en Prolog

Sistema experto basado en reglas hecho en **SWI-Prolog**. A partir de un conjunto mínimo de características de un ejemplar, determina a qué clase pertenece (mamífero, ave, pez, reptil o anfibio) y qué animal es.

Proyecto de la práctica de laboratorio de Sistemas Expertos en Prolog (Paradigmas de Programación).

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) (versión estable)

## Cómo ejecutarlo

1. Clona o descarga este repositorio.
2. Abre una terminal en la carpeta del proyecto y carga el archivo:

   ```bash
   swipl animales.pl
   ```

3. Escribe consultas en el prompt, **siempre terminando con punto**:

   ```prolog
   ?- animal(ejemplar1, A).
   ```

## Animales que reconoce

Perro, gato, águila, pingüino, delfín, tiburón, serpiente y rana.

## Características mínimas

`pelo`, `plumas`, `escamas`, `aletas`, `pulmones`, `branquias`, `vive_en_agua`, `vuela`, `ladra`, `maulla`, `sin_patas`, `piel_humeda` y `salta`.

## Cómo funciona

### Hechos

`caracteristica(Ejemplar, Caracteristica)` describe lo que se observa en cada ejemplar:

```prolog
caracteristica(ejemplar1, pelo).
caracteristica(ejemplar1, ladra).
```

### Reglas

El sistema razona en **dos niveles**:

1. **Clase** (`clase/2`), a partir de características generales:

   ```prolog
   clase(X, mamifero) :- caracteristica(X, pelo).
   clase(X, ave)      :- caracteristica(X, plumas).
   clase(X, pez)      :- caracteristica(X, aletas), caracteristica(X, branquias).
   ```

2. **Animal** (`animal/2`), combinando la clase con una característica propia:

   ```prolog
   animal(X, perro)    :- clase(X, mamifero), caracteristica(X, ladra).
   animal(X, pinguino) :- clase(X, ave), caracteristica(X, vive_en_agua),
                          \+ caracteristica(X, vuela).
   ```

   El operador `\+` es la negación: el pingüino es un ave que vive en el agua y **no** vuela.

### Tabla de identificación

| Animal | Clase | Característica clave |
|---|---|---|
| perro | mamífero | ladra |
| gato | mamífero | maulla |
| delfín | mamífero | vive en agua |
| águila | ave | vuela |
| pingüino | ave | vive en agua, no vuela |
| tiburón | pez | aletas y branquias |
| serpiente | reptil | escamas, sin patas |
| rana | anfibio | piel húmeda, salta |

## Consultas de verificación

| Consulta | Resultado esperado |
|---|---|
| `animal(ejemplar1, A).` | `A = perro` |
| `animal(ejemplar4, A).` | `A = pinguino` |
| `animal(ejemplar5, A).` | `A = delfin` |
| `animal(X, serpiente).` | `X = ejemplar7` |
| `clase(ejemplar3, C).` | `C = ave` |

## Agregar un animal nuevo

1. Agrega las características de un ejemplar nuevo:

   ```prolog
   caracteristica(ejemplar9, pelo).
   caracteristica(ejemplar9, trompa).
   ```

2. Agrega la regla que lo identifica:

   ```prolog
   animal(X, elefante) :- clase(X, mamifero), caracteristica(X, trompa).
   ```

## Limitaciones

- Solo reconoce los 8 animales definidos.
- Las reglas dependen de las características que se registren; si falta una, el animal no se identifica.
- Las clases se deducen con pocas características, así que animales fuera de este grupo podrían clasificarse mal.

# Nivel de programación de un estudiante en Prolog

Base de conocimiento hecha en **SWI-Prolog** que determina si un estudiante de Ingeniería de Software de primer semestre conoce los elementos básicos de programación y lo clasifica como **principiante**, **intermedio** o **avanzado**.

Proyecto de la práctica de laboratorio de Sistemas Expertos en Prolog (Paradigmas de Programación).

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) (versión estable)

## Cómo ejecutarlo

1. Clona o descarga este repositorio.
2. Abre una terminal en la carpeta del proyecto y carga el archivo:

   ```bash
   swipl estudiante.pl
   ```

3. Escribe consultas en el prompt, **siempre terminando con punto**:

   ```prolog
   ?- nivel(ana, N).
   ```

## Temas evaluados

Variables, condicionales, ciclos, funciones y arreglos.

## Cómo funciona

### Hechos

- `tema(T)`: los 5 temas básicos.
- `estudiante(E)`: los estudiantes registrados (ana, luis, sofia, mario y pedro).
- `conoce(E, T)`: el estudiante `E` domina el tema `T`.

```prolog
conoce(ana, variables).
conoce(mario, ciclos).
```

### Reglas

`cuantos/2` cuenta cuántos temas domina un estudiante:

```prolog
cuantos(E, N) :- estudiante(E), aggregate_all(count, (tema(T), conoce(E, T)), N).
```

`nivel/2` lo clasifica según esa cantidad:

| Temas dominados | Nivel |
|---|---|
| 5 | avanzado |
| 3 o 4 | intermedio |
| 0 a 2 | principiante |

`falta/2` indica qué temas le faltan al estudiante:

```prolog
falta(E, T) :- estudiante(E), tema(T), \+ conoce(E, T).
```

## Estudiantes de ejemplo

| Estudiante | Temas que conoce | Nivel |
|---|---|---|
| ana | variables, condicionales, ciclos, funciones, arreglos | avanzado |
| mario | variables, condicionales, ciclos, funciones | intermedio |
| luis | variables, condicionales, ciclos | intermedio |
| sofia | variables | principiante |
| pedro | ninguno | principiante |

## Consultas de ejemplo

| Consulta | Resultado |
|---|---|
| `nivel(ana, N).` | `N = avanzado` |
| `nivel(mario, N).` | `N = intermedio` |
| `nivel(pedro, N).` | `N = principiante` |
| `nivel(E, principiante).` | `E = sofia` ; `E = pedro` |
| `findall(T, falta(luis, T), L).` | `L = [funciones, arreglos]` |

## Agregar un estudiante

```prolog
estudiante(carla).
conoce(carla, variables).
conoce(carla, condicionales).
```

Luego consulta `?- nivel(carla, N).`

## Limitaciones

- Todos los temas pesan igual; no se distingue entre temas más fáciles o difíciles.
- La clasificación depende solo de la cantidad de temas, no del grado de dominio.

# Práctica de laboratorio: Sistemas Expertos en Prolog

Conjunto de ejercicios hechos en **SWI-Prolog** para la práctica de Sistemas Expertos del curso de Paradigmas de Programación. Cada carpeta tiene su propio código y su README.

## Contenido

| Carpeta | Ejercicio | Descripción |
|---|---|---|
| [`deportes/`](deportes) | Punto 1 | Sistema experto que recomienda un deporte según las preferencias del usuario |
| [`arbol-genealogico/`](arbol-genealogico) | Punto 2 | Árbol genealógico con reglas de hermano, hijo, tío, sobrino, primo, abuelo, bisabuelo y tatarabuelo |
| [`animales/`](animales) | Punto 3 | Clasificación de animales a partir de características mínimas |
| [`estudiante/`](estudiante) | Punto 4 | Clasificación del nivel de programación de un estudiante |

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) (versión estable)

## Cómo ejecutar cualquier ejercicio

```bash
cd nombre-de-la-carpeta
swipl archivo.pl
```

Luego escribe las consultas indicadas en el README de cada carpeta, siempre terminando con punto.

## Conceptos usados

- **Hechos:** información fija, por ejemplo `padre(gio, oriana).`
- **Reglas:** conclusiones con `:-` (significa "si"), por ejemplo `abuelo(A, N) :- progenitor(P, N), padre(A, P).`
- **Operadores:** AND (`,`), OR (`;`) y NOT (`not` o `\+`).
- **Motor de inferencia:** lo aporta Prolog con la unificación y el backtracking.

## Autores

_Thomas Santiago Guzmán Páez_


_Samir Elias_
