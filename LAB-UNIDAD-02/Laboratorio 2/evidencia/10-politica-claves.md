# 17. Actividad 10 — Crear una política mínima de protección de claves

## Política para la gestión de claves criptográficas

### 1. Generación de claves
Las claves criptográficas deben generarse mediante herramientas seguras que utilicen métodos aleatorios confiables. No se deben crear claves fáciles de adivinar.

### 2. Almacenamiento
Las claves deben guardarse en un gestor de secretos o en un sistema seguro de administración de claves. No deben incluirse directamente en archivos SQL, código fuente o repositorios Git.

### 3. Control de acceso
Solamente las personas y aplicaciones autorizadas podrán utilizar las claves. Se deben asignar permisos de acuerdo con las funciones y necesidades de cada usuario.

### 4. Rotación de claves
Las claves deben cambiarse periódicamente, de acuerdo con la política de la organización, y también cuando exista sospecha de que fueron comprometidas.

### 5. Respaldo de claves
Se deben mantener respaldos seguros de las claves necesarias para recuperar información cifrada. Estos respaldos deben estar protegidos y disponibles únicamente para personal autorizado.

### 6. Revocación de claves
Cuando una clave se vea comprometida o deje de ser necesaria, debe revocarse para impedir su uso posterior. También se deben revisar los sistemas que dependían de ella.

### 7. Exposición accidental
Si una clave se publica por error en un repositorio, archivo o registro, se debe considerar comprometida. Es necesario revocarla o reemplazarla, revisar los accesos y retirar la exposición cuando sea posible.

### 8. Eliminación de claves
Las claves que ya no sean necesarias deben eliminarse de forma segura, incluyendo las copias que puedan existir en medios de almacenamiento. Antes de eliminarlas, se debe comprobar que no sean necesarias para recuperar información cifrada.
