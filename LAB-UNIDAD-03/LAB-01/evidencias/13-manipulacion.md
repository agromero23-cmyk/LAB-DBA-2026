# Actividad 14 — Intentar manipular la auditoría

## Objetivo

Comprobar las limitaciones del sistema de auditoría y analizar cómo detectar modificaciones que no quedaron registradas en la tabla de auditoría.

## 1. ¿Qué evidencia permite detectar que hubo un cambio sin auditar?

La bitácora del servidor permite detectar que el disparador fue desactivado, que se realizó una modificación y que posteriormente volvió a activarse.

En este caso, el RFC del cliente con ID 3 cambió a `GAMA780912GHI`, pero el número de registros de auditoría permaneció en 3.

Esto demuestra que ocurrió una modificación sin generar un nuevo registro en `auditoria.cambios_clientes`.

## 2. ¿Qué control administrativo (no técnico) reduciría este riesgo?

Una medida sería establecer una política donde las modificaciones a los mecanismos de auditoría requieran autorización de un responsable y queden documentadas.

También se debe separar al personal que administra la base de datos de quienes supervisan y resguardan las evidencias, para evitar que una sola persona tenga control de todo el proceso.

## 3. Relaciona esta actividad con el principio de separación de funciones de la Unidad II.

La actividad se relaciona con la separación de funciones porque demuestra que una misma persona con privilegios administrativos podría desactivar el disparador y modificar información sin generar un registro en la tabla de auditoría.

Para reducir este riesgo, las responsabilidades deben distribuirse entre diferentes personas o áreas. Por ejemplo, el administrador puede operar la base de datos, mientras que otro responsable supervisa y conserva las bitácoras.

De esta manera se evita concentrar todo el control en una sola persona.

## Conclusión

La actividad demuestra que la tabla de auditoría no es suficiente para proteger completamente la información, ya que un administrador con privilegios elevados puede desactivar el disparador.

Por eso es importante complementar los controles técnicos con políticas administrativas, separación de funciones y almacenamiento externo de las bitácoras para conservar evidencias de manera más segura.