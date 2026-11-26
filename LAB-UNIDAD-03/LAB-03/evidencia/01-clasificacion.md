
# 7. Actividad 1 — Calidad de datos desde la operación

## 1. Simulación de registros con errores

Se insertaron dos registros ficticios para simular problemas de calidad en la captura de información.

Los registros presentan los siguientes errores:

- Registro de Ana Lopez: posible duplicado por correo electrónico y RFC incompleto.
- Registro de Jorge Díaz: correo inválido, teléfono incompleto, RFC ausente y edad fuera del rango permitido.

## 2. Verificaciones realizadas

### C1. Posible cliente duplicado

Se encontraron dos registros con el mismo correo, aunque uno está escrito con letras mayúsculas.

- Registros: 1 y 7.
- Regla de calidad: Unicidad del correo.
- Acción propuesta: Verificar si realmente se trata de la misma persona antes de combinar o eliminar registros.

### C2. RFC incompleto

Se encontró un RFC que no cumple con el formato establecido.

- Registro: 7.
- Regla de calidad: Validez del formato del RFC.
- Acción propuesta: Solicitar la verificación del RFC correcto con el cliente.

### C3. Correo electrónico inválido

Se encontró un correo que no cumple con el formato esperado.

- Registro: 8.
- Regla de calidad: Validez del correo electrónico.
- Acción propuesta: Solicitar al cliente que proporcione un correo electrónico correcto.

### C4. Edad fuera de rango

Se encontró una edad negativa que no corresponde a un dato válido.

- Registro: 8.
- Regla de calidad: Validez y consistencia de los datos.
- Acción propuesta: Verificar la edad real con el cliente antes de modificar el registro.

### C5. Teléfono incompleto y RFC ausente

El registro 8 también presenta un teléfono con pocos dígitos y no contiene RFC.

- Registro: 8.
- Regla de calidad: Completitud y validez de los datos.
- Acción propuesta: Solicitar la información faltante y verificarla antes de actualizar la base de datos.

## 3. Tabla de hallazgos

| Hallazgo | Registros | Regla de calidad | ¿Quién decide la corrección? | Acción propuesta |
|---|---|---|---|---|
| C1. Posible cliente duplicado | 1, 7 | Unicidad del correo | Responsable de datos | Verificar si pertenecen a la misma persona. |
| C2. RFC incompleto | 7 | Formato del RFC | Cliente y responsable de datos | Solicitar el RFC correcto. |
| C3. Correo inválido | 8 | Validez del correo | Cliente y responsable de datos | Solicitar un correo válido. |
| C4. Edad fuera de rango | 8 | Validez de los datos | Responsable de datos | Confirmar la edad real. |
| C5. Teléfono incompleto y RFC ausente | 8 | Completitud y validez | Cliente y responsable de datos | Solicitar y verificar los datos faltantes. |

## 4. Preguntas

### 1. ¿Por qué el DBA no debe corregir por su cuenta el RFC del registro 7?

Porque el DBA no tiene forma de saber cuál es el RFC correcto del cliente. Aunque detecte que el dato está incompleto, no debe inventar ni modificar información sin autorización. La corrección debe ser confirmada por el cliente o el responsable de los datos.

### 2. ¿Qué restricción (CHECK, UNIQUE) habría evitado cada hallazgo? ¿Quién debería aprobar agregarla?

Se podrían utilizar las siguientes restricciones:

- UNIQUE o un índice único sobre `lower(correo)` para evitar correos duplicados sin importar las mayúsculas y minúsculas.
- CHECK para validar que el RFC cumpla con el formato establecido.
- CHECK para verificar que el correo tenga un formato válido.
- CHECK para impedir edades menores de 18 o mayores de 120.
- CHECK para validar que el teléfono tenga una cantidad adecuada de dígitos.
- NOT NULL si el negocio determina que el RFC debe ser obligatorio.

Estas restricciones deben ser aprobadas por el responsable del sistema o propietario de los datos, junto con las áreas responsables de la operación. El DBA puede recomendar e implementar los controles, pero no debe decidir por su cuenta las reglas del negocio.

### 3. Si el DBA corrige un dato, ¿qué mecanismo del LAB-01 (Parte B) dejará evidencia del cambio?

El mecanismo de auditoría implementado mediante triggers y tablas de bitácora permitirá registrar las modificaciones realizadas. De esta manera se puede conocer qué operación se ejecutó, cuándo ocurrió y cuáles eran los valores anteriores y posteriores del registro.

## 5. Conclusión

Esta actividad permitió identificar diferentes problemas de calidad en los datos de los clientes, como registros duplicados, correos inválidos, RFC incompletos y edades incorrectas.

También se comprobó que el DBA no debe modificar información sin autorización, ya que las correcciones deben ser verificadas por los responsables correspondientes.

Finalmente, las restricciones de integridad y los mecanismos de auditoría ayudan a prevenir errores y mantener la confiabilidad de la información.
