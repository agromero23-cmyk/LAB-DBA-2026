## Preguntas de Análisis

### 1. ¿Por qué el proceso que registra el cambio es el principal (PID 1) y no tu sesión?
Cuando se ejecuta `SELECT pg_reload_conf()`, la sesión de usuario únicamente envía una señal `SIGHUP` al proceso principal de PostgreSQL (*Postmaster* / PID 1).

* La sesión del usuario **no modifica ni aplica directamente la configuración** en el motor de base de datos.
* El **proceso principal (PID 1)** es el responsable de recibir la señal, releer el archivo `postgresql.auto.conf` y aplicar dinámicamente los parámetros al servidor, registrando las modificaciones en la bitácora bajo su propio número de proceso.

---

### 2. ¿Qué pasaría si alguien ejecutara `ALTER SYSTEM SET log_statement = 'none'`? ¿Quedaría rastro?
**Sí, queda rastro registrado en la bitácora por dos vías:**

1. **Por la sentencia ejecutada:** Si el parámetro `log_statement` se encontraba configurado en `'ddl'` o `'all'` al momento del comando, la sentencia `ALTER SYSTEM` quedará registrada por la sesión que la ejecutó.
2. **Por el evento de recarga:** Al ejecutarse la recarga de configuración (`SELECT pg_reload_conf()`), el proceso principal (PID 1) siempre registrará la notificación de modificación del parámetro:
   ```text
   LOG: parameter "log_statement" changed to "none"