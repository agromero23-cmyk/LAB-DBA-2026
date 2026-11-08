# 7. Actividad 1 — Protección de credenciales

## 7.1 El problema

### ¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?

Si una persona obtiene acceso de lectura a la tabla `usuarios_insegura`, podría ver los nombres de usuario y sus contraseñas en texto plano.

Esto representa un riesgo de seguridad, porque podría utilizar las contraseñas para entrar a las cuentas de los usuarios sin autorización. Si una persona utiliza la misma contraseña en otros sistemas, esas cuentas también podrían verse afectadas.

Para evitar este problema, las contraseñas no deben almacenarse directamente en la base de datos. Se deben proteger mediante algoritmos de hash seguros, como Argon2id o bcrypt.

# 7.3 Generar una representación no reversible

## Preguntas y respuestas

### 1. ¿Son iguales?

No, los resultados son diferentes, aunque se utilice la misma contraseña (`Password123`).

### 2. Si no son iguales, ¿por qué?

Porque la función `gen_salt()` genera una sal aleatoria cada vez que se ejecuta. Esta sal se utiliza para calcular el hash, por lo que una misma contraseña puede producir resultados diferentes.

### 3. ¿Qué función cumple `gen_salt()`?

La función `gen_salt()` genera una sal aleatoria que se utiliza en el proceso de hash. Esto ayuda a evitar que contraseñas iguales produzcan siempre el mismo resultado.

### 4. ¿Qué función cumple `crypt()`?

La función `crypt()` genera un hash de la contraseña utilizando el algoritmo y la sal proporcionados. En este ejemplo, `gen_salt('bf')` utiliza Blowfish para generar la sal y calcular el hash.

### 5. ¿Esto es cifrado reversible?

No. Es un proceso de hash que no permite recuperar directamente la contraseña original a partir del resultado. Para verificar una contraseña, se utiliza el hash almacenado y se comprueba si coincide con la contraseña ingresada.

# 7.5 Verificar una contraseña

## Preguntas y respuestas

### 1. ¿Qué resultado obtuviste con la contraseña correcta?

El resultado fue `true`, porque la contraseña ingresada (`Password123`) coincide con el hash almacenado en la base de datos.

### 2. ¿Qué resultado obtuviste con la contraseña incorrecta?

El resultado fue `false`, porque la contraseña ingresada (`OtraPassword`) no coincide con el hash almacenado.

### 3. ¿Por qué no es necesario recuperar la contraseña original?

Porque el sistema puede comprobar si la contraseña ingresada es correcta comparando su hash con el que está guardado en la base de datos. De esta manera, no necesita conocer ni recuperar la contraseña original.

### 4. ¿Por qué un hash no debe confundirse con cifrado?

Porque el hash es una representación diseñada para no recuperar directamente la información original, mientras que el cifrado permite recuperar los datos originales mediante una clave. Por eso, las contraseñas deben almacenarse como hashes seguros y no como texto plano.