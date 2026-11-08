# 8. Actividad 2 — Cifrado de información sensible

## 8.1 Crear una tabla de demostración

## 8.2 Recuperar el dato

### Preguntas y respuestas

### 1. ¿Qué diferencia existe entre `crypt()` y `pgp_sym_encrypt()`?

La función `crypt()` se utiliza para generar un hash de una contraseña, mientras que `pgp_sym_encrypt()` cifra información utilizando una clave secreta. El hash no permite recuperar directamente el dato original, pero el cifrado sí permite recuperarlo con la clave correcta.

### 2. ¿Cuál de los dos mecanismos permite recuperar el dato original?

`pgp_sym_encrypt()` permite recuperar el dato original mediante la función `pgp_sym_decrypt()` y utilizando la misma clave secreta con la que se cifró.

### 3. ¿Qué ocurre si se utiliza una clave incorrecta?

Si se utiliza una clave incorrecta, la función `pgp_sym_decrypt()` no podrá recuperar correctamente el dato original y PostgreSQL normalmente generará un error de descifrado.

### 4. ¿Qué problema de seguridad representa colocar la clave directamente en una consulta?

Colocar la clave directamente en una consulta representa un riesgo porque puede quedar expuesta en el historial de consultas, registros del sistema o capturas de pantalla. Si una persona obtiene la clave, podría descifrar la información protegida. Por eso, es importante almacenar y administrar las claves de forma segura, evitando escribirlas directamente en el código.