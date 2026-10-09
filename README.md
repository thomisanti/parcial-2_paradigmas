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

## Autores

_Thomas Santiago Guzmán Páez_


_Samir Elias_
