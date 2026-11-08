# Actividad 1 — Identificar la superficie de ataque

## 1. Información del servidor

- Versión de PostgreSQL:
- Puerto:
- Interfaces de escucha:
- SSL:
- Método de almacenamiento de contraseñas:

## 2. Conexiones activas

Describe las conexiones que aparecen en el resultado de `pg_stat_activity`.

## 3. Análisis de seguridad

- **Puerto PostgreSQL:** indicar si es necesario para el funcionamiento del servicio y qué riesgo representa si queda expuesto sin controles.
- **Interfaces de escucha:** explicar en qué interfaces acepta conexiones el servidor.
- **Conexiones remotas:** indicar si aparecen conexiones remotas y si puedes determinar que son legítimas.
- **Usuarios administrativos:** identificar las cuentas administrativas que puedas verificar.
- **SSL/TLS:** registrar el estado que devuelve PostgreSQL.
- **Autenticación:** registrar el método de almacenamiento de contraseñas y señalar que las reglas de autenticación se revisarán en la Actividad 4.

## 4. Pregunta

**¿Por qué conocer la superficie de ataque debe preceder al hardening?**

Primero es necesario identificar los servicios, puertos, conexiones, usuarios y configuraciones que pueden representar riesgos. Con esa información se pueden detectar exposiciones innecesarias y elegir medidas de seguridad apropiadas sin afectar las conexiones legítimas.

# Actividad 2 — Identificar los archivos de configuración

## Objetivo

Identificar las rutas de los principales archivos y directorios de
configuración de PostgreSQL.

## Resultados

| Parámetro | Resultado |
|---|---|
| config_file | |
| hba_file | |
| ident_file | |
| data_directory | |
| log_directory | |
| log_connections | |
| log_disconnections | |

## Análisis

### 1. ¿Por qué es importante conocer la ubicación de estos archivos?

Es importante conocer las rutas para localizar la configuración de
PostgreSQL, revisar sus permisos y asegurarse de modificar los archivos
correctos cuando sea necesario.

### 2. ¿Qué archivo controla las reglas de acceso?

El archivo pg_hba.conf contiene las reglas que determinan qué conexiones
pueden autenticarse, para qué bases de datos, con qué usuarios y mediante
qué métodos de autenticación.

### 3. ¿Por qué deben protegerse los archivos de configuración?

Porque una modificación no autorizada podría debilitar la seguridad,
permitir accesos indebidos o afectar el funcionamiento del servidor.

## Conclusión

Completar después de ejecutar las consultas y analizar los resultados.



# Actividad 3 — Revisar listen_addresses

## Objetivo

Identificar las interfaces de red en las que PostgreSQL acepta conexiones y evaluar los posibles riesgos de seguridad.

## Resultado obtenido

- **Parámetro:** `listen_addresses`
- **Valor encontrado:** `*`

## Análisis

### 1. Configuración encontrada

El parámetro `listen_addresses` tiene el valor `*`, lo que indica que PostgreSQL escucha en todas las interfaces de red disponibles.

### 2. Interfaces necesarias

Solo deben habilitarse las interfaces necesarias para que las aplicaciones y los usuarios autorizados puedan conectarse al servidor.

### 3. Interfaces innecesarias

Las interfaces que no se necesitan para el funcionamiento del sistema deben evitarse, ya que pueden aumentar la superficie de exposición del servicio.

### 4. ¿Qué arquitectura reduce mejor la exposición?

Una arquitectura con PostgreSQL dentro de una red privada, acceso limitado mediante firewall y conexiones permitidas únicamente desde equipos autorizados reduce la exposición del servidor.


## Conclusión

Se identificó que PostgreSQL escucha en todas las interfaces de red disponibles. Esta configuración puede ser necesaria en determinados entornos, pero debe acompañarse de controles de acceso y reglas de red para evitar conexiones no autorizadas.


# Actividad 4 — Revisar pg_hba.conf

## Objetivo

Identificar las reglas de autenticación y acceso de PostgreSQL para conocer qué usuarios, bases de datos y direcciones de red pueden conectarse al servidor.

## Resultados

- Reglas locales identificadas: Pendiente de revisar.
- Reglas IPv4 identificadas: Pendiente de revisar.
- Reglas IPv6 identificadas: Pendiente de revisar.
- Métodos de autenticación encontrados: Pendiente de revisar.
- Redes demasiado amplias detectadas: Pendiente de revisar.

## Análisis

### 1. ¿Qué controla pg_hba.conf?

El archivo `pg_hba.conf` controla las conexiones que pueden autenticarse en PostgreSQL. Para ello, considera el tipo de conexión, la base de datos, el usuario, la dirección de origen y el método de autenticación.

### 2. ¿Por qué son riesgosas las redes demasiado amplias?

Las redes demasiado amplias pueden permitir intentos de conexión desde muchas direcciones. Por eso, es recomendable limitar el acceso a las redes y equipos que realmente necesitan utilizar el servidor.

### 3. ¿Por qué no basta con utilizar contraseñas fuertes?

Las contraseñas fuertes ayudan a proteger las cuentas, pero no sustituyen las restricciones de red, los métodos de autenticación seguros ni una configuración adecuada de los permisos.

## Conclusión

La revisión de las reglas de `pg_hba.conf` permite identificar cómo se controla el acceso a PostgreSQL y detectar configuraciones que podrían representar riesgos de seguridad. Las medidas correctivas deben basarse en los resultados obtenidos y en las necesidades reales del sistema.


# Actividad 5 — Analizar una regla permisiva

## Objetivo

Analizar una regla de acceso de PostgreSQL que permite conexiones desde cualquier dirección IPv4 e identificar los riesgos que representa.

## Regla analizada

```text
host    all    all    0.0.0.0/0    scram-sha-256
```

## Análisis de la regla

### 1. ¿Qué bases de datos permite?

Permite conexiones a todas las bases de datos, siempre que se cumplan las demás condiciones de autenticación y acceso.

### 2. ¿Qué usuarios permite?

Permite conexiones de cualquier usuario de PostgreSQL que pueda autenticarse y cumpla las condiciones de la regla.

### 3. ¿Qué direcciones de origen permite?

La dirección `0.0.0.0/0` representa todas las direcciones IPv4. Por lo tanto, la regla no restringe el origen a una red específica.

### 4. ¿Qué método de autenticación utiliza?

Utiliza `scram-sha-256`, un método de autenticación basado en contraseñas que ofrece una protección más robusta que métodos heredados como MD5.

### 5. ¿Por qué puede representar una exposición innecesaria?

Porque permite intentos de conexión desde cualquier origen IPv4 y no limita el acceso a las redes, bases de datos y usuarios que realmente necesitan conectarse.

Aunque utiliza un método de autenticación seguro, esto no elimina los riesgos de una regla demasiado amplia.

### 6. ¿Qué información se necesita para restringirla?

Se necesita conocer:

- La dirección IP o red de origen autorizada.
- La base de datos que necesita utilizarse.
- El usuario específico que requiere acceso.
- El método de autenticación compatible con el entorno.

## Registro de la regla

- **Regla actual:** `host all all 0.0.0.0/0 scram-sha-256`
- **Problema:** Permite conexiones desde cualquier dirección IPv4.
- **Origen que realmente necesita acceso:** Pendiente de confirmar.
- **Base de datos:** Pendiente de confirmar.
- **Usuario:** Pendiente de confirmar.
- **Regla propuesta:** Se definirá cuando se conozcan el origen, la base de datos y el usuario autorizados.

## Conclusión

Una regla puede utilizar autenticación segura y aun así permitir una exposición de red innecesaria. Para mejorar la seguridad de PostgreSQL, las conexiones deben limitarse a los usuarios, bases de datos y orígenes que realmente necesitan acceso.
