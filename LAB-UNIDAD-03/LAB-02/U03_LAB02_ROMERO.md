# Pseudocódigo: Función calcularMulta

```text
FUNCIÓN calcularMulta(diasRetraso, tipoUsuario)
1   SI diasRetraso <= 0 ENTONCES
2       RETORNAR 0
3   FIN SI
4   tarifa ← 5
5   SI tipoUsuario = "DOCENTE" ENTONCES
6       tarifa ← 3
7   FIN SI
8   multa ← diasRetraso * tarifa
9   SI multa > 100 ENTONCES
10      multa ← 100
11  FIN SI
12  RETORNAR multa
FIN FUNCIÓN 
```

## Paso 1 — Identifica las decisiones

Las decisiones son las instrucciones `SI` que evalúan una condición dentro del pseudocódigo.

| Decisión | Línea | Condición |
|---|---:|---|
| D1 | 1 | `diasRetraso <= 0` |
| D2 | 5 | `tipoUsuario = "DOCENTE"` |
| D3 | 9 | `multa > 100` |

### ¿Alguna es una condición compuesta?

No, ninguna de las tres decisiones es una condición compuesta.

Todas son condiciones simples porque cada una evalúa una sola expresión lógica y no utiliza operadores booleanos como `Y (AND)` u `O (OR)` para combinar varias condiciones.

### Conclusión

El pseudocódigo contiene tres decisiones (D1, D2 y D3), todas simples. Por lo tanto, no existen condiciones compuestas.

## Paso 2 — Dibuja el grafo de flujo de control

### 1. Identificación de nodos

Se agrupan las instrucciones consecutivas que se ejecutan juntas en un mismo nodo.

| Nodo | Instrucciones | Descripción |
|---|---|---|
| N1 | Inicio | Inicio de la función. |
| N2 | Línea 1 | Decisión D1: `diasRetraso <= 0`. |
| N3 | Línea 2 | Retorna 0 y termina la función. |
| N4 | Líneas 4 y 5 | Asigna `tarifa ← 5` y evalúa D2: `tipoUsuario = "DOCENTE"`. |
| N5 | Línea 6 | Asigna `tarifa ← 3`. |
| N6 | Línea 8 | Calcula `multa ← diasRetraso * tarifa`. |
| N7 | Línea 9 | Decisión D3: `multa > 100`. |
| N8 | Línea 10 | Asigna `multa ← 100`. |
| N9 | Línea 12 | Retorna el valor de `multa`. |
| N10 | Fin | Termina la función. |

### 2. Grafo de flujo de control

```text
                 ┌─────────┐
                 │ INICIO  │
                 └────┬────┘
                      │
                      ▼
             ┌─────────────────┐
             │ D1: Línea 1     │
             │ diasRetraso <= 0│
             └────┬───────┬────┘
                V │       │ F
                  ▼       ▼
             ┌────────┐  ┌──────────────────┐
             │ Línea 2│  │ Líneas 4 y 5     │
             │Return 0│  │ tarifa ← 5      │
             └───┬────┘  │ D2: ¿DOCENTE?    │
                 │       └────┬────────┬────┘
                 │          V│        │F
                 │           ▼        │
                 │      ┌─────────┐   │
                 │      │ Línea 6 │   │
                 │      │tarifa←3 │   │
                 │      └────┬────┘   │
                 │           │        │
                 │           └───┬────┘
                 │               ▼
                 │      ┌──────────────────┐
                 │      │ Línea 8          │
                 │      │ multa ← días*tarifa│
                 │      └────────┬─────────┘
                 │               ▼
                 │      ┌─────────────────┐
                 │      │ D3: Línea 9     │
                 │      │ multa > 100     │
                 │      └────┬───────┬────┘
                 │         V │       │ F
                 │           ▼       │
                 │      ┌─────────┐  │
                 │      │ Línea 10│  │
                 │      │multa←100│  │
                 │      └────┬────┘  │
                 │           │       │
                 │           └───┬───┘
                 │               ▼
                 │       ┌────────────┐
                 │       │ Línea 12   │
                 │       │ RETORNAR   │
                 │       │ multa      │
                 │       └─────┬──────┘
                 │             │
                 ▼             ▼
                ┌───────────────┐
                │      FIN      │
                └───────────────┘
```

## Paso 3 — Calcula la complejidad ciclomática por tres métodos

La complejidad ciclomática permite conocer la cantidad de caminos independientes que existen en el grafo de flujo de control.

### Método 1: Número de decisiones + 1

Fórmula:

V(G) = número de decisiones + 1

En el pseudocódigo identificamos tres decisiones:

- D1: `diasRetraso <= 0`
- D2: `tipoUsuario = "DOCENTE"`
- D3: `multa > 100`

Sustituyendo:

V(G) = 3 + 1

**Resultado: V(G) = 4**

### Método 2: Aristas − Nodos + 2

Fórmula:

V(G) = E - N + 2

Donde:
- E = Número de aristas.
- N = Número de nodos.

Contando los elementos de nuestro grafo:

**Nodos (N):**

1. N1: Inicio.
2. N2: Decisión D1.
3. N3: Retornar 0.
4. N4: Tarifa ← 5 y decisión D2.
5. N5: Tarifa ← 3.
6. N6: Calcular multa.
7. N7: Decisión D3.
8. N8: Multa ← 100.
9. N9: Retornar multa.
10. N10: Fin.

Total de nodos: 10.

**Aristas (E):**

1. N1 → N2
2. N2 → N3 (V)
3. N2 → N4 (F)
4. N3 → N10
5. N4 → N5 (V)
6. N4 → N6 (F)
7. N5 → N6
8. N6 → N7
9. N7 → N8 (V)
10. N7 → N9 (F)
11. N8 → N9
12. N9 → N10

Total de aristas: 12.

Sustituyendo:

V(G) = 12 - 10 + 2

V(G) = 2 + 2

**Resultado: V(G) = 4**

### Método 3: Número de regiones

La complejidad ciclomática también se puede calcular contando las regiones del grafo, incluyendo el área exterior.

En nuestro grafo se identifican:

- Región 1: Área correspondiente a la primera decisión (D1).
- Región 2: Área correspondiente a la segunda decisión (D2).
- Región 3: Área correspondiente a la tercera decisión (D3).
- Región 4: Región exterior del grafo.

Total de regiones: 4.

**Resultado: V(G) = 4**

### CHECKPOINT 1 — Verificación de resultados

| Método | Resultado |
|---|---:|
| Decisiones + 1 | 4 |
| Aristas − Nodos + 2 | 4 |
| Número de regiones | 4 |

### Conclusión

Los tres métodos proporcionan el mismo resultado: **V(G) = 4**. Esto significa que el pseudocódigo tiene cuatro caminos independientes que deben considerarse para realizar las pruebas de caja blanca.

## Paso 4 — Enumera todas las rutas y elige un conjunto base

### 1. Lista de todas las rutas

Se identifican todas las rutas posibles desde el nodo INICIO hasta el nodo FIN, considerando las combinaciones de verdadero (V) y falso (F) de las tres decisiones.

| Ruta | D1 | D2 | D3 | Líneas ejecutadas |
|---|---|---|---|---|
| P1 | V | — | — | 1, 2 |
| P2 | F | V | V | 1, 4, 5, 6, 8, 9, 10, 12 |
| P3 | F | V | F | 1, 4, 5, 6, 8, 9, 12 |
| P4 | F | F | V | 1, 4, 5, 8, 9, 10, 12 |
| P5 | F | F | F | 1, 4, 5, 8, 9, 12 |

**Nota:** El símbolo (—) significa que la decisión no se evalúa porque la ejecución terminó anteriormente.

### 2. ¿Cuántas rutas hay en total? ¿Es el mismo número que V(G)?

Se identificaron **5 rutas posibles** desde el inicio hasta el final.

Sin embargo, la complejidad ciclomática calculada anteriormente fue:

V(G) = 4

Por lo tanto, no existe el mismo número de rutas que de complejidad ciclomática.

Esto se debe a que la complejidad ciclomática representa el número de caminos independientes, no necesariamente el número total de rutas posibles.

### 3. Construye un conjunto base

El conjunto base está formado por cuatro rutas independientes. Cada ruta agregada debe aportar al menos una arista que no haya aparecido en las rutas anteriores.

| Ruta | ¿Qué arista nueva aporta? |
|---|---|
| P1 | D1 → V, porque permite terminar directamente con `RETORNAR 0`. |
| P2 | D1 → F, D2 → V y D3 → V. |
| P3 | D3 → F, porque permite continuar sin modificar la multa. |
| P4 | D2 → F, porque permite calcular la multa sin aplicar la tarifa especial de docente. |

**Conjunto base:**

- P1: D1 = V.
- P2: D1 = F, D2 = V, D3 = V.
- P3: D1 = F, D2 = V, D3 = F.
- P4: D1 = F, D2 = F, D3 = V.

Total de rutas independientes: 4.

### 4. ¿Qué ruta quedó fuera del conjunto base y por qué no es independiente?

La ruta que quedó fuera del conjunto base es **P5**.

- D1 = F.
- D2 = F.
- D3 = F.

Esta ruta no es independiente porque sus aristas de decisión ya aparecen en las rutas anteriores:

- La arista D1 → F aparece en P2.
- La arista D2 → F aparece en P4.
- La arista D3 → F aparece en P3.

Por lo tanto, P5 no aporta ninguna arista nueva al conjunto base.

### Conclusión

Se identificaron cinco rutas posibles, pero solamente cuatro son independientes. El conjunto base está formado por P1, P2, P3 y P4, lo cual coincide con la complejidad ciclomática calculada anteriormente:

**V(G) = 4**

Esto confirma que se seleccionó correctamente el conjunto de rutas independientes para realizar las pruebas de caja blanca.

## Paso 5 — Encuentra las fronteras de salida de RN-04

Para encontrar las fronteras de salida, se calcula cuántos días de retraso necesita cada tipo de usuario para alcanzar el límite de $100 MXN y cuál es el primer día en que supera esa cantidad.

La fórmula utilizada es:

`multa = diasRetraso * tarifa`

El límite máximo establecido en el pseudocódigo es de $100 MXN.

### 1. Cálculo de fronteras

| Tipo de usuario | Días con la multa más alta sin superar 100 MXN | Multa | Primer día que supera 100 MXN | Multa calculada antes del tope |
|---|---:|---:|---:|---:|
| ESTUDIANTE | 20 días | $100 MXN | 21 días | $105 MXN |
| DOCENTE | 33 días | $99 MXN | 34 días | $102 MXN |

### 2. Explicación de los cálculos

**ESTUDIANTE:**

- Tarifa diaria: $5 MXN.
- 20 días × $5 = $100 MXN.
- 21 días × $5 = $105 MXN.

**DOCENTE:**

- Tarifa diaria: $3 MXN.
- 33 días × $3 = $99 MXN.
- 34 días × $3 = $102 MXN.

### 3. Conclusión

Se identificaron las fronteras de salida para ambos tipos de usuario. Los estudiantes alcanzan el límite de $100 MXN a los 20 días y lo superan a los 21 días. Los docentes alcanzan una multa de $99 MXN a los 33 días y superan el límite a los 34 días.

Estos valores permiten comprobar que la función aplica correctamente el límite máximo de $100 MXN.

## Paso 6 — Diseña tres conjuntos de casos

Se diseñan tres conjuntos de pruebas para comprobar el funcionamiento de la función `calcularMulta`, utilizando las reglas de negocio de RN-04.

### 1. Conjunto I — Cobertura de instrucciones

El objetivo es ejecutar las nueve instrucciones ejecutables del pseudocódigo al menos una vez.

Se necesitan **2 casos de prueba**, porque la línea 2 (`RETORNAR 0`) termina la función y no permite ejecutar las instrucciones posteriores.

| Conjunto | ID | diasRetraso | tipoUsuario | Ruta | Resultado esperado según RN-04 |
|---|---|---:|---|---|---|
| I | CP-RN04-I-01 | 0 | ESTUDIANTE | P1: D1 = V | $0 MXN |
| I | CP-RN04-I-02 | 34 | DOCENTE | D1 = F, D2 = V, D3 = V | $100 MXN |

**Justificación:**

- El primer caso ejecuta la instrucción `RETORNAR 0`.
- El segundo caso ejecuta las instrucciones restantes, incluyendo la asignación de tarifa especial y el límite máximo de multa.

Con estos dos casos se cubren las nueve instrucciones ejecutables.

### 2. Conjunto II — Cobertura de decisiones

El objetivo es conseguir que cada decisión tome los dos resultados posibles: verdadero (V) y falso (F).

Se necesitan **3 casos de prueba**.

| Conjunto | ID | diasRetraso | tipoUsuario | Ruta | Resultado esperado según RN-04 |
|---|---|---:|---|---|---|
| II | CP-RN04-II-01 | 0 | ESTUDIANTE | D1 = V | $0 MXN |
| II | CP-RN04-II-02 | 34 | DOCENTE | D1 = F, D2 = V, D3 = V | $100 MXN |
| II | CP-RN04-II-03 | 3 | ESTUDIANTE | D1 = F, D2 = F, D3 = F | $15 MXN |

**Justificación:**

- D1 toma el valor V en el primer caso y F en los otros dos.
- D2 toma el valor V en el segundo caso y F en el tercero.
- D3 toma el valor V en el segundo caso y F en el tercero.

De esta manera, las tres decisiones se prueban en sus dos posibles resultados.

### 3. Conjunto III — Rutas base

El objetivo es probar cada una de las cuatro rutas independientes identificadas anteriormente.

Como la complejidad ciclomática es V(G) = 4, se necesitan **4 casos de prueba**.

| Conjunto | ID | diasRetraso | tipoUsuario | Ruta | Resultado esperado según RN-04 |
|---|---|---:|---|---|---|
| III | CP-RN04-III-01 | 0 | ESTUDIANTE | P1: D1 = V | $0 MXN |
| III | CP-RN04-III-02 | 34 | DOCENTE | P2: D1 = F, D2 = V, D3 = V | $100 MXN |
| III | CP-RN04-III-03 | 3 | DOCENTE | P3: D1 = F, D2 = V, D3 = F | $9 MXN |
| III | CP-RN04-III-04 | 21 | ESTUDIANTE | P4: D1 = F, D2 = F, D3 = V | $100 MXN |

**Justificación:**

- P1 comprueba que no se cobre multa cuando no existen días de retraso.
- P2 comprueba la tarifa de docente y el límite máximo de $100 MXN.
- P3 comprueba la tarifa de docente sin superar el límite.
- P4 comprueba la tarifa de estudiante y el límite máximo de $100 MXN.

### 4. CHECKPOINT 2 — Cobertura de un solo caso

Se analiza el siguiente caso:

- `diasRetraso = 3`
- `tipoUsuario = "ESTUDIANTE"`

**Cobertura de instrucciones**

Las instrucciones que se ejecutan son:

1. Línea 1: evalúa los días de retraso.
2. Línea 4: asigna tarifa de $5.
3. Línea 5: evalúa si el usuario es docente.
4. Línea 8: calcula la multa.
5. Línea 9: comprueba si supera $100.
6. Línea 12: retorna la multa.

Total de instrucciones ejecutadas: 6.

Fórmula:

Cobertura = (Instrucciones ejecutadas / Total de instrucciones) × 100

Cobertura = (6 / 9) × 100

**Resultado: 66.67 %**

**Cobertura de decisiones**

Las decisiones ejecutadas son:

| Decisión | Condición | Resultado |
|---|---|---|
| D1 | diasRetraso <= 0 | F |
| D2 | tipoUsuario = "DOCENTE" | F |
| D3 | multa > 100 | F |

Se ejecutaron 3 resultados de decisión de los 6 posibles.

Fórmula:

Cobertura = (Resultados ejecutados / Total de resultados) × 100

Cobertura = (3 / 6) × 100

**Resultado: 50 %**

### 5. Resumen de resultados

| Conjunto | Objetivo | Número mínimo de casos |
|---|---|---:|
| I | Cobertura de instrucciones | 2 |
| II | Cobertura de decisiones | 3 |
| III | Rutas base | 4 |

| Checkpoint 2 | Cobertura |
|---|---:|
| Instrucciones | 66.67 % |
| Decisiones | 50 % |

### Conclusión

Se diseñaron tres conjuntos de casos de prueba para evaluar diferentes niveles de cobertura del pseudocódigo. El conjunto I necesita dos casos, el conjunto II necesita tres y el conjunto III necesita cuatro, de acuerdo con la complejidad ciclomática calculada.

El caso individual de tres días de retraso para un estudiante alcanza una cobertura de instrucciones del 66.67 % y una cobertura de decisiones del 50 %. Esto demuestra que un solo caso no es suficiente para comprobar todos los caminos posibles de la función.

## Paso 7 — Trazado de escritorio sobre la versión A

El trazado de escritorio consiste en ejecutar manualmente cada caso de prueba, siguiendo las instrucciones del pseudocódigo línea por línea. Se registran los valores de las variables `tarifa` y `multa`, así como el valor retornado por la función.

### 1. Conjunto I — Cobertura de instrucciones

| ID | tarifa | multa (línea 8) | Valor retornado | Resultado esperado | ¿Coincide? |
|---|---:|---:|---:|---:|---|
| CP-RN04-I-01 | — | — | $0 | $0 | Sí |
| CP-RN04-I-02 | $3 | $102 | $100 | $100 | Sí |

**Explicación:**

- CP-RN04-I-01: Como los días de retraso son 0, la función retorna inmediatamente $0.
- CP-RN04-I-02: Se asigna una tarifa de $3 porque es docente. La multa calculada es $102, pero se aplica el límite máximo de $100.

### 2. Conjunto II — Cobertura de decisiones

| ID | tarifa | multa (línea 8) | Valor retornado | Resultado esperado | ¿Coincide? |
|---|---:|---:|---:|---:|---|
| CP-RN04-II-01 | — | — | $0 | $0 | Sí |
| CP-RN04-II-02 | $3 | $102 | $100 | $100 | Sí |
| CP-RN04-II-03 | $5 | $15 | $15 | $15 | Sí |

**Explicación:**

- CP-RN04-II-01: No existen días de retraso, por lo que retorna $0.
- CP-RN04-II-02: Se aplica la tarifa de docente y la multa se limita a $100.
- CP-RN04-II-03: Se aplica la tarifa de estudiante de $5 por día. La multa es de $15 y no supera el límite.

### 3. Conjunto III — Rutas base

| ID | tarifa | multa (línea 8) | Valor retornado | Resultado esperado | ¿Coincide? |
|---|---:|---:|---:|---:|---|
| CP-RN04-III-01 | — | — | $0 | $0 | Sí |
| CP-RN04-III-02 | $3 | $102 | $100 | $100 | Sí |
| CP-RN04-III-03 | $3 | $9 | $9 | $9 | Sí |
| CP-RN04-III-04 | $5 | $105 | $100 | $100 | Sí |

**Explicación:**

- CP-RN04-III-01: La función retorna $0 porque no hay días de retraso.
- CP-RN04-III-02: La multa de docente es de $102, pero se limita a $100.
- CP-RN04-III-03: La multa de docente es de $9 y no supera el límite.
- CP-RN04-III-04: La multa de estudiante es de $105, pero se limita a $100.

### 4. Resumen de resultados

| Conjunto | Casos ejecutados | Casos que coinciden | Casos que no coinciden |
|---|---:|---:|---:|
| I — Instrucciones | 2 | 2 | 0 |
| II — Decisiones | 3 | 3 | 0 |
| III — Rutas base | 4 | 4 | 0 |
| **Total** | **9** | **9** | **0** |

### 5. Conclusión

Después de realizar el trazado de escritorio sobre la versión A, se comprobó que los nueve casos de prueba coinciden con los resultados esperados según RN-04.

La función calcula correctamente las multas para estudiantes y docentes, respeta el límite máximo de $100 MXN y retorna cero cuando no existen días de retraso.

Por lo tanto, la versión A supera satisfactoriamente los casos de prueba diseñados para los tres conjuntos.

**Resultado: 9 de 9 casos coinciden con el resultado esperado.**

## Paso 8 — Una versión con un defecto

La versión B contiene un error en la línea 8. En lugar de utilizar la variable `tarifa`, utiliza directamente el valor 5.

**Versión A:**
```text
8   multa ← diasRetraso * tarifa

8   multa ← diasRetraso * 5
```

## Paso 9 — Lo que el código no dice

### 1. ¿Qué devuelve la versión A si `tipoUsuario = "INVITADO"`? ¿Lo define RN-04?

Si el tipo de usuario es `"INVITADO"`, la versión A asigna la tarifa general de $5 por día, porque solamente establece una tarifa especial para los usuarios DOCENTE.

Ejemplo:

- `diasRetraso = 3`
- `tipoUsuario = "INVITADO"`
- Tarifa aplicada: $5.
- Multa calculada: 3 × 5 = $15 MXN.
- Valor retornado: **$15 MXN**.

Sin embargo, RN-04 no especifica qué tarifa debe aplicarse a los usuarios INVITADOS, por lo que no se puede asegurar que el resultado sea correcto según los requisitos.

### 2. ¿Qué técnica de caja negra del Laboratorio 01 habría generado ese caso aunque no tuvieras el código?

La técnica de **partición de equivalencia** habría permitido identificar diferentes categorías de usuarios y generar casos de prueba para cada una.

Al considerar las categorías ESTUDIANTE, DOCENTE e INVITADO, se puede identificar que el tipo INVITADO necesita una regla específica o una aclaración de los requisitos.

### 3. Pregunta de aclaración para quien define los requisitos

¿Qué tarifa debe aplicarse a los usuarios de tipo INVITADO al calcular una multa por retraso? ¿Deben pagar la tarifa general de $5 por día, tener una tarifa diferente o estar exentos de pagar multas?

### Conclusión

La versión A devuelve $15 MXN para un usuario INVITADO con tres días de retraso, debido a que aplica la tarifa general de $5. Sin embargo, RN-04 no define el comportamiento para este tipo de usuario. Por ello, es necesario aclarar el requisito antes de considerar correcto el resultado.

## Parte B — Pseudocódigo de una regla de tu proyecto base

### Paso 10 — Escribe el pseudocódigo

Para esta parte se utilizará como proyecto base el **LAB-01 — Bitácoras y auditoría del dato en PostgreSQL**.

La función debe representar una regla de negocio tomada de la tabla de decisión de la Parte D del Laboratorio 01.

### Importante

Necesito que me compartas la **tabla de decisión de la Parte D del LAB-01** para convertirla correctamente en pseudocódigo.

Puedes pegar aquí la tabla o enviarme una captura.

Con esa información prepararé:

1. La función con `FUNCIÓN` y `FIN FUNCIÓN`.
2. Las condiciones con `SI ... ENTONCES`.
3. Las decisiones numeradas por línea.
4. Los `RETORNAR` correspondientes a cada resultado o motivo de rechazo.
5. El pseudocódigo completo en formato Markdown, listo para guardar en tu archivo `.md`.

No voy a inventar condiciones ni reglas que no estén en tu tabla de decisión, porque este pseudocódigo debe representar exactamente la lógica de tu proyecto.

## Paso 11 — Grafo, V(G) y conjunto base

Para realizar este apartado se necesita el pseudocódigo elaborado en el Paso 10, ya que el grafo de flujo de control depende de las condiciones y los retornos de la regla de negocio.

Se realizarán los siguientes elementos:

1. Identificación de nodos y aristas.
2. Dibujo del grafo de flujo de control.
3. Cálculo de complejidad ciclomática mediante dos métodos:
   - V(G) = decisiones + 1.
   - V(G) = aristas - nodos + 2.
4. Identificación de todas las rutas.
5. Construcción del conjunto base, indicando la arista nueva que aporta cada ruta.

## Paso 12 — Casos por ruta base

Se elaborará un caso de prueba por cada ruta independiente del conjunto base.

Cada caso contendrá:

| Campo | Descripción |
|---|---|
| ID | Identificador del caso de prueba. |
| Técnica | Caja blanca — rutas base. |
| ESC de origen | Identificador del caso del Laboratorio 01, si existe. |
| Datos de entrada | Valores necesarios para ejecutar la regla. |
| Ruta | Camino independiente que se desea probar. |
| Resultado esperado | Resultado obtenido de la regla de negocio. |
| Estado | Pendiente de ejecutar. |

También se reutilizarán los ID de los casos del LAB-01 cuando correspondan, evitando duplicarlos.

## Paso 13 — Compara caja blanca y tabla de decisión

### 1. ¿Cuántas reglas tiene la tabla completa de tu Laboratorio 01 y cuánto vale V(G) de tu pseudocódigo? ¿Por qué son distintos?

La tabla de decisión del Laboratorio 01 contiene las combinaciones de condiciones y sus respectivas acciones o resultados. Por otro lado, la complejidad ciclomática (V(G)) representa la cantidad de rutas independientes que existen en el pseudocódigo.

Ambos valores pueden ser diferentes porque la tabla de decisión considera las combinaciones posibles de las condiciones, mientras que la complejidad ciclomática mide los caminos independientes de la estructura del programa.

**Respuesta:** La cantidad exacta de reglas y el valor de V(G) dependen de la tabla de decisión y del pseudocódigo de la regla seleccionada en el Paso 10.

### 2. ¿Hay alguna combinación de la tabla que ninguna ruta base obliga a probar? ¿Qué defecto podría esconderse ahí?

Sí, puede existir alguna combinación de condiciones de la tabla de decisión que no sea recorrida por las rutas del conjunto base.

Esto sucede porque las rutas base solamente garantizan cubrir los caminos independientes del pseudocódigo, pero no necesariamente todas las combinaciones posibles de las condiciones.

Un defecto que podría esconderse sería una regla de negocio aplicada incorrectamente cuando se presentan determinadas condiciones al mismo tiempo, provocando que el sistema acepte una operación que debería rechazarla o que aplique una acción equivocada.

### Conclusión

La caja blanca y las tablas de decisión son técnicas complementarias. La caja blanca permite analizar las rutas independientes del programa, mientras que la tabla de decisión ayuda a comprobar las combinaciones de condiciones y sus resultados. Utilizar ambas permite encontrar defectos que podrían pasar desapercibidos al utilizar solamente una técnica.